function doPoll(){
    $.getScript('/conductor/gemfile/install.js', function(data) {
        setTimeout(doPoll, 500);
    });
   }

$(document).ready(function(){
  var editor = ace.edit("editor");
  var textarea = $('#installgems_body');
  editor.renderer.setShowGutter(false);
  editor.setReadOnly(true);
  textarea.hide();

  editor.setTheme("ace/theme/textmate");
  editor.getSession().setMode("ace/mode/ruby");
  editor.getSession().setValue(textarea.val());
  doPoll();
});