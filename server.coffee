# REQUIREMENT
express = require 'express'
argv    =  require('optimist').argv

# Application
#
app = express()

# CONFIGURATION
app.use require('morgan')()
app.locals.port = argv.port || 3000
app.set 'view engine', 'jade'
app.set 'views', __dirname + '/views'
app.use express.static(__dirname + '/public')

app.get '/', (req,res)->
  res.render 'index'

app.listen app.locals.port
console.log "MarkdownEditor listen #{app.locals.port}"
