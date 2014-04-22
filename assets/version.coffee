$ ->

  $Prev  = $('#Prev')
  $Next  = $('#Next')

  $Input = $('#Inputview')

  window.counter = counter = 0

  $Prev.click ->
    return unless window.page?
    page = window.page
    window.counter = window.counter + 1
    console.log "version #{window.counter} total #{page.cache.length}"
    return window.counter -= 1 if window.counter is window.page.date.length
    $Input.html(page.cache[page.date.length - window.counter])
    window.compile()

  $Next.click ->
    return if not window.page? or window.counter is 0
    page = window.page
    window.counter =  window.counter - 1
    console.log "version #{window.counter} total #{page.cache.length}"
    $Input.html(page.cache[page.date.length - window.counter])
    window.compile()
