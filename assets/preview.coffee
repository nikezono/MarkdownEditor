$ ->
  document.execCommand('defaultParagraphSeparator', false, '')
  $Input   = $('#Inputview')
  $Preview = $('#Preview')

  marked.setOptions
    gfm:true
    tables:true
    breaks:true

  source = ""

  if $Input.length
    $(document).ready ->
      compile()


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
    source = $Input.html().replace(/&nbsp;/gi,' ').replace(/<br>/gi,'\n').replace(/<div>/gi,'\n').replace(/<\/div>/gi,'')
    html = marked source
    $Preview.html(html)
    $('pre code').each (i,e)-> hljs.highlightBlock(e)

