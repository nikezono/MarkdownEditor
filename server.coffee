# REQUIREMENT
express  = require 'express'
argv     = require('optimist').argv
uuid     = require('node-uuid')
mongoose = require 'mongoose'
socketIO = require 'socket.io'
moment   = require 'moment'

# Application
#
app = express()

# CONFIGURATION
app.use require('morgan')()
app.locals.port = argv.port || 3000
app.set 'view engine', 'jade'
app.set 'views', __dirname + '/views'
app.use express.static(__dirname + '/public')

# DATABASES
mongoose.connect "mongodb://localhost/markdown"
Page = require './models/Page'

# ROUTING
app.get '/',      (req,res)-> res.render 'index'
app.get '/create',(req,res)-> res.json { page:uuid.v1().slice(0,9) }
app.get '/:page', (req,res)->
  id = req.params.page
  Page.findOrCreateOneByUUID id,(page)->
    res.render 'editor',
      page:page
      latest:moment(page.date[page.date.length-1]).fromNow()

server = app.listen app.locals.port

# Socket.IO
io = socketIO.listen(server)
io.sockets.on 'connection', (socket)->

  socket.on 'page',(path)->
    Page.findOrCreateOneByUUID path,(page)->
      socket.emit 'page',page

  socket.on 'update',(data)->
    Page.findOrCreateOneByUUID data.path,(page)->
      page.cache.push page.md || ""
      page.date.push new Date()
      page.md = data.md
      page.save (err,doc)->
        return console.log err if err
        socket.emit 'updated',doc

console.log "MarkdownEditor listen #{app.locals.port}"
