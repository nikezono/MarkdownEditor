$ ->
  path = window.location.pathname.split("/")[1]
  return if path is ""
  socket = io.connect()

  $Input = $('#Inputview')

  # Load時にPageObjectもらう @todo status更新
  socket.emit 'page',path

  socket.on 'page',(page)->
    window.page = page
    window.compile()
  socket.on 'updated',(page)->
    window.page = page
    window.compile()

  # EnterKey時Sync
  $Input.keypress (e)->
    return if e.keyCode isnt 13
    save()

  # MouseUp時Sync
  $Input.focusout (e)->
    save()


  save = ->
    source = $Input.html()

    socket.emit 'update',
      path:path
      md:source


