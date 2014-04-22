###
#
# Page.coffee
#
###

Mongo = require 'mongoose'

PageSchema = new Mongo.Schema
  uuid : { type:String, unique:true}
  md   : String
  cache: [String]
  date : [Date]

PageSchema.statics.findOrCreateOneByUUID = (uuid,callback)->
  that = @
  @findOne
    uuid:uuid
  ,null,null,(err,doc)->
    console.log "reach doc" if doc
    return callback doc if doc
    that.create
      uuid:uuid
    ,(err,doc)->
      console.log "create doc" if doc
      return callback null if err
      return callback doc

module.exports = Mongo.model 'pages', PageSchema

