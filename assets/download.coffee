$ ->

  # jQuery Objects
  $Md    = $('#MdSave')
  $Html  = $('#HtmlSave')

  $Input = $('#Inputview')

  downloadURLUpdate = ->
    markdown = $Input.html().replace(/<br>/gi,'\n').replace(/<div>/gi,'\n').replace(/<\/div>/gi,'').replace(/<br\/>/gi,'\n')

    # Md
    blob = new Blob [ markdown ],
      type: "text/plain"
    $Md.attr('href',window.URL.createObjectURL(blob))
    .attr("download", "file.md")

    markded = "<html><head><meta charset='UTF-8'></head><body>" + marked markdown  + "</body></html>"

    # Html
    html = new Blob [ markded ],
      type: "text/plain"
    $Html.attr('href',window.URL.createObjectURL(html))
    .attr("download","file.html")

  if window.location.pathname isnt "/"
    downloadURLUpdate()
  $Input.change ->
    downloadURLUpdate()


