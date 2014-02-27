$(document).ready(function(){
  var editor = ace.edit("editor");
  editor.renderer.setShowGutter(false);
  editor.setReadOnly(true);
  editor.setTheme("ace/theme/textmate");
  editor.getSession().setMode("ace/mode/ruby");
  var ws = new WebSocket("ws://" + location.host + "/conductor/test/websocket_test");
  ws.onmessage = function(e) {
    editor.insert(e.data + "\n");
   };
 });