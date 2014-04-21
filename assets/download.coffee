$ ->

  # jQuery Objects
  $Md    = $('#MdSave')
  $Html  = $('#HtmlSave')

  $Input = $('#Inputview')

  $Input.keyup ->
    markdown = $Input.html().replace(/<br>gi/,'\n').replace(/<div>/gi,'\n').replace(/<\/div>/gi,'')

    # Md
    blob = new Blob [ markdown ],
      type: "text/plain"
    $Md.attr('href',window.URL.createObjectURL(blob))
    .attr("download", "file.md")

    # Html
    html = new Blob [ marked(markdown) ],
      type: "text/plain"
    $Html.attr('href',window.URL.createObjectURL(html))
    .attr("download","file.html")
