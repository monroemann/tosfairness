$(document).on('turbolinks:load', function() {
  if ( $('.edit-lawsuit').length > 0) {

    var isEditing = false;

    $('a#toggle-edit-lawsuit').on('click', function(e) {
      if (isEditing) {
        $('form.edit-lawsuit .to-disable').attr('disabled', 'disabled');
        $('.editable').hide();
        $('.read-only').show();
        $('a#toggle-edit-lawsuit').addClass('btn-primary').text("Edit Lawsuits");
        $('input.lawsuit-save').removeClass('btn-primary');
      }
      else {
        $('form.edit-lawsuit :disabled')
          .removeAttr('disabled')
          .addClass('to-disable');

        $('.editable').show();
        $('.read-only').hide();
        $('a#toggle-edit-lawsuit').removeClass('btn-primary').text("Cancel");
        $('input.lawsuit-save').addClass('btn-primary');
      }

      isEditing = !isEditing;
    });
  }
});
