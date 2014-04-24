$ ->

  $Zen     = $('#Zen')
  $ZenView = $('#ZenView')

  $Presen    = $('#Presentation')
  $Preview   = $('#Preview')


  $Input   = $('#Inputview')

  # Zen
  $Zen.click ->
    target = document.getElementById('ZenView')
    fullscreen(target)

  #Presentation
  $Presen.click ->
    target = document.getElementById('Preview')
    fullscreen(target)


  fullscreen = (target)->
    if target.webkitRequestFullscreen
      target.webkitRequestFullscreen() #Chrome15+, Safari5.1+, Opera15+
    else if target.mozRequestFullScreen
      target.mozRequestFullScreen() #FF10+
    else if target.msRequestFullscreen
      target.msRequestFullscreen() #IE11+
    else target.requestFullscreen()  if target.requestFullscreen # HTML5 Fullscreen API仕様


