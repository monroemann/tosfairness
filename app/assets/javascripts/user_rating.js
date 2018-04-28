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

  // $('#new_user_rating').submit( function(e) {
  //   e.preventDefault();
  //
  //   $.ajax({
  //     type: 'POST',
  //     url: this.action,
  //     data: $('#new_user_rating').serialize(),
  //     success: function(data) {
  //       alert("success " + data);
  //     },
  //     error: function(a, b, c) {
  //       $('#user_rating_submit').prop('disabled', false);
  //       alert(b + ': ' + c);
  //     }
  //   });
  // })
});
