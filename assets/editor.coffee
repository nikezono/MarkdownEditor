$ ->

  $Zen     = $('#Zen')
  $ZenView = $('#ZenView')
  $Type    = $('#Typewriter')

  $Input   = $('#Inputview')

  # Zen
  $Zen.click ->
    target = document.getElementById('ZenView')
    $ZenView.addClass 'fullscreen'
    if target.webkitRequestFullscreen
      target.webkitRequestFullscreen() #Chrome15+, Safari5.1+, Opera15+
    else if target.mozRequestFullScreen
      target.mozRequestFullScreen() #FF10+
    else if target.msRequestFullscreen
      target.msRequestFullscreen() #IE11+
    else target.requestFullscreen()  if target.requestFullscreen # HTML5 Fullscreen API仕様



  # TypeWriter
  typeMode  = false

  key       = new Audio('/sound/key.mp3')
  linebreak = new Audio('/sound/linebreak.mp3')

  $Type.click -> typeMode ^= true
  $Input.keydown (e)->
    return unless typeMode
    if e.keyCode is 13
      linebreak.play()
      linebreak = new Audio( linebreak.src )
    else
      key.play()
      key = new Audio( key.src )

