$ ->
  path = window.location.pathname.split("/")[1]
  return if path is ""
  socket = io.connect()

  $Input = $('#Inputview')

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


