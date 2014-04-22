$ ->

  $Create = $('#Create')

  $Create.click (e)->
    $.getJSON '/create',null,(json)->
      location.href="/#{json.page}"
