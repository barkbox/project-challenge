$(document).ready(
  function () {
    $('input:submit').attr('disabled', true);
    $('input:file').change(
      function () {
        if ($(this).val()) {
          $('input:submit').prop('disabled', false);
        }
        else {
          $('input:submit').prop('disabled', true);
        }
      });
  });
