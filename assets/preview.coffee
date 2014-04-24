$ ->
  document.execCommand('defaultParagraphSeparator', false, '')
  $Input   = $('#Inputview')
  $Preview = $('#Preview')

  $Url      = $('#Url')
  $Changed  = $('#Changed')
  $Versions = $('#Versions')

  marked.setOptions
    gfm:true
    tables:true
    breaks:true

  source = ""

  if $Input.length
    $(document).ready ->
      compile()


  $Input.keyup (e)->
    window.counter = 0
    setTimeout ->
      compile()
    ,200


  # コピペ
  $Input.on 'paste', (e)->
    setTimeout ->
      compile()
    ,200

  compile = window.compile = ->
    # md
    source = $Input.html().replace(/&nbsp;/gi,' ').replace(/<br>/gi,'\n').replace(/<div>/gi,'\n').replace(/<\/div>/gi,'')
    html = marked source
    console.log html = html.replace(/&lt;/gi,'<').replace(/&gt;/gi,'>').replace(/script/gi,'text')
    $Preview.html(html)
    # Highlight
    $('pre code').each (i,e)-> hljs.highlightBlock(e)
    # Status
    if window.page?
      page = window.page
      $Url.text("url=http://md.nikezono.net/#{page.uuid}")
      $Changed.text("changed:#{moment(page.date[page.date.length - window.counter]).fromNow()}")
      $Versions.text("version #{page.date.length - window.counter} in #{page.date.length} versions")

