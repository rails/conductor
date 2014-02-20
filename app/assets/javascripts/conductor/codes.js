$(document).ready(function(){
  var editor = ace.edit("editor");
  var textarea = $('#code_content');
  textarea.hide();
  var filePath = $('#code_path').val();
  var modelist = ace.require('ace/ext/modelist');
  var mode = modelist.getModeForPath(filePath).mode;
  editor.setTheme("ace/theme/textmate");
  editor.getSession().setMode(mode);
  editor.getSession().setValue(textarea.val());
  editor.getSession().on('change', function(){
    textarea.val(editor.getSession().getValue());
  });
});
