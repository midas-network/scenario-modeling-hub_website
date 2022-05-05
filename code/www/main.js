window.addEventListener('message', function (event) {
   if (event.data == "FrameHeight") {
        var body = document.body, html = document.documentElement;
        var height = Math.max(body.scrollHeight, body.offsetHeight,
            html.clientHeight, html.scrollHeight, html.offsetHeight);
        event.source.postMessage({ "FrameHeight": height }, "*");       
    }
});

