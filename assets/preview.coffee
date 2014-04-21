$ ->
  document.execCommand('defaultParagraphSeparator', false, '')
  $Input   = $('#Inputview')
  $Preview = $('#Preview')

  source = ""
  firstInput = true

  $Input.on 'mousedown', ->
    if firstInput
      $Input.html('')
      firstInput = false
    true

  $Input.keyup (e)->
    setTimeout ->
      compile()
    ,200

  # コピペ
  $Input.on 'paste', (e)->
    setTimeout ->
      compile()
    ,200

  compile = ->
    source = $Input.html().replace(/<br>/gi,'\n').replace(/<div>/gi,'\n').replace(/<\/div>/gi,'')
    html = marked source
    $Preview.html(html)

