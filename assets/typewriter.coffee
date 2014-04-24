$ ->

  $Input    = $('#Inputview')
  $Type     = $('#Typewriter')
  $TypeMode = $('#TypeMode')

  # TypeWriter
  window.typeMode  = false

  keys      = []
  for i in [1..4]
    keys.push new Audio("/sound/key#{i}.wav")
  console.log keys
  linebreak = new Audio('/sound/return.wav')
  start     = new Audio('/sound/start.wav')
  end       = new Audio('/sound/end.wav')
  backspace = new Audio('/sound/backspace.wav')
  release   = new Audio('/sound/release.wav')

  $Type.click ->
    window.typeMode ^= true
    $TypeMode.text("Typewriter=#{window.typeMode}")

  # Start
  $Input.focusin ->
    return if window.typeMode is false
    start.play()
    start = new Audio(start.src)

  # End
  $Input.focusout ->
    return if window.typeMode is false
    end.play()
    end = new Audio(end.src)

  # Keydown
  $Input.keydown (e)->
    return unless typeMode
    if e.keyCode is 13
      linebreak.play()
      linebreak = new Audio( linebreak.src )
    else if e.keyCode is 8 or e.keyCode is 46
      backspace.play()
      backspace = new Audio(backspace.src)
    else
      random = Math.floor(Math.random() * 4) + 1 - 1
      keys[random].play()
      keys[random] = new Audio( keys[random].src )

  # Keyup
  $Input.keyup (e)->
    return if window.typeMode is false
    return if e.keyCode is 13
    release.play()
    release = new Audio(release.src)


