$(document).ready(function(){
  var ws = new WebSocket("ws://" + location.host + "/conductor/test/websocket_test");
  var editor = ace.edit("editor");
  editor.renderer.setShowGutter(false);
  editor.setReadOnly(true);
  ws.onmessage = function(e) {
    editor.insert(e.data + "\n"); };
  editor.setTheme("ace/theme/textmate");
  editor.getSession().setMode("ace/mode/ruby");
  });