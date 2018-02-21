$( function() {
  if ( $('.edit-rating').length > 0) {

    var isEditing = false;

    $('a#toggle-edit').on('click', function(e) {
      if (isEditing) {
        $('form.edit-rating .to-disable').attr('disabled', 'disabled');
        $('.editable').hide();
        $('.read-only').show();
        $('a#toggle-edit').addClass('btn-primary').text("Edit Rating");
        $('input.rating-save').removeClass('btn-primary');
      }
      else {
        $('form.edit-rating :disabled')
          .removeAttr('disabled')
          .addClass('to-disable');

        $('.editable').show();
        $('.read-only').hide();
        $('a#toggle-edit').removeClass('btn-primary').text("Cancel");
        $('input.rating-save').addClass('btn-primary');
      }

      isEditing = !isEditing;
    });
  }
});
