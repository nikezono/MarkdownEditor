// Generated by CoffeeScript 1.7.1
$(function() {
  var $Html, $Input, $Md;
  $Md = $('#MdSave');
  $Html = $('#HtmlSave');
  $Input = $('#Inputview');
  return $Input.keyup(function() {
    var blob, html, markdown;
    markdown = $Input.html().replace(/<br>gi/, '\n').replace(/<div>/gi, '\n').replace(/<\/div>/gi, '');
    blob = new Blob([markdown], {
      type: "text/plain"
    });
    $Md.attr('href', window.URL.createObjectURL(blob)).attr("download", "file.md");
    html = new Blob([marked(markdown)], {
      type: "text/plain"
    });
    return $Html.attr('href', window.URL.createObjectURL(html)).attr("download", "file.html");
  });
});

$(function() {
  var $Input, $Presen, $Preview, $Type, $Zen, $ZenView, fullscreen, key, linebreak, typeMode;
  $Zen = $('#Zen');
  $ZenView = $('#ZenView');
  $Presen = $('#Presentation');
  $Preview = $('#Preview');
  $Type = $('#Typewriter');
  $Input = $('#Inputview');
  $Zen.click(function() {
    var target;
    target = document.getElementById('ZenView');
    return fullscreen(target);
  });
  $Presen.click(function() {
    var target;
    target = document.getElementById('Preview');
    return fullscreen(target);
  });
  typeMode = false;
  key = new Audio('/sound/key.mp3');
  linebreak = new Audio('/sound/linebreak.mp3');
  $Type.click(function() {
    return typeMode ^= true;
  });
  $Input.keydown(function(e) {
    if (!typeMode) {
      return;
    }
    if (e.keyCode === 13) {
      linebreak.play();
      return linebreak = new Audio(linebreak.src);
    } else {
      key.play();
      return key = new Audio(key.src);
    }
  });
  return fullscreen = function(target) {
    if (target.webkitRequestFullscreen) {
      return target.webkitRequestFullscreen();
    } else if (target.mozRequestFullScreen) {
      return target.mozRequestFullScreen();
    } else if (target.msRequestFullscreen) {
      return target.msRequestFullscreen();
    } else {
      if (target.requestFullscreen) {
        return target.requestFullscreen();
      }
    }
  };
});

$(function() {
  var $Create;
  $Create = $('#Create');
  return $Create.click(function(e) {
    return $.getJSON('/create', null, function(json) {
      return location.href = "/" + json.page;
    });
  });
});

$(function() {
  var $Input, path, save, socket;
  path = window.location.pathname.split("/")[1];
  if (path === "") {
    return;
  }
  socket = io.connect();
  $Input = $('#Inputview');
  socket.emit('page', path);
  socket.on('page', function(page) {
    window.page = page;
    return window.compile();
  });
  socket.on('updated', function(page) {
    window.page = page;
    return window.compile();
  });
  $Input.keypress(function(e) {
    if (e.keyCode !== 13) {
      return;
    }
    return save();
  });
  $Input.focusout(function(e) {
    return save();
  });
  return save = function() {
    var source;
    source = $Input.html();
    return socket.emit('update', {
      path: path,
      md: source
    });
  };
});

$(function() {
  var $Changed, $Input, $Preview, $Url, $Versions, compile, source;
  document.execCommand('defaultParagraphSeparator', false, '');
  $Input = $('#Inputview');
  $Preview = $('#Preview');
  $Url = $('#Url');
  $Changed = $('#Changed');
  $Versions = $('#Versions');
  marked.setOptions({
    gfm: true,
    tables: true,
    breaks: true
  });
  source = "";
  if ($Input.length) {
    $(document).ready(function() {
      return compile();
    });
  }
  $Input.keyup(function(e) {
    window.counter = 0;
    return setTimeout(function() {
      return compile();
    }, 200);
  });
  $Input.on('paste', function(e) {
    return setTimeout(function() {
      return compile();
    }, 200);
  });
  return compile = window.compile = function() {
    var html, page;
    source = $Input.html().replace(/&nbsp;/gi, ' ').replace(/<br>/gi, '\n').replace(/<div>/gi, '\n').replace(/<\/div>/gi, '');
    html = marked(source);
    $Preview.html(html);
    $('pre code').each(function(i, e) {
      return hljs.highlightBlock(e);
    });
    if (window.page != null) {
      page = window.page;
      $Url.text("url=http://md.nikezono.net/" + page.uuid);
      $Changed.text("changed:" + (moment(page.date[page.date.length - window.counter]).fromNow()));
      return $Versions.text("version " + (page.date.length - window.counter) + " in " + page.date.length + " versions");
    }
  };
});

$(function() {
  var $Input, $Next, $Prev, counter;
  $Prev = $('#Prev');
  $Next = $('#Next');
  $Input = $('#Inputview');
  window.counter = counter = 0;
  $Prev.click(function() {
    var page;
    if (window.page == null) {
      return;
    }
    page = window.page;
    window.counter = window.counter + 1;
    console.log("version " + window.counter + " total " + page.cache.length);
    if (window.counter === window.page.date.length) {
      return window.counter -= 1;
    }
    $Input.html(page.cache[page.date.length - window.counter]);
    return window.compile();
  });
  return $Next.click(function() {
    var page;
    if ((window.page == null) || window.counter === 0) {
      return;
    }
    page = window.page;
    window.counter = window.counter - 1;
    console.log("version " + window.counter + " total " + page.cache.length);
    $Input.html(page.cache[page.date.length - window.counter]);
    return window.compile();
  });
});
