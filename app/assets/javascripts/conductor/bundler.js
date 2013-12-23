function doPoll(){
    $.getScript('/conductor/bundler.js', function(data) {
        setTimeout(doPoll, 300);
    });
   }

$(document).ready(function(){
  var editor = ace.edit("editor");
  var textarea = $('#bundler_body');
  editor.renderer.setShowGutter(false);
  editor.setReadOnly(true);
  textarea.hide();

  editor.setTheme("ace/theme/textmate");
  editor.getSession().setMode("ace/mode/ruby");
  editor.getSession().setValue(textarea.val());
  doPoll();
});