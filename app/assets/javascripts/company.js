$(document).on('turbolinks:load', function() {
  $('input[type="radio"][name="company[tos_flag]"]').on('change', function() {
    if (this.value == 'new') {
      $('#form-tos-update').addClass('hidden');
    }
    else if (this.value == 'update') {
      $('#form-tos-update').removeClass('hidden');
    }
  });
});
