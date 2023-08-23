$('#profile_form').submit(function (event) {
  event.preventDefault();
  var url = $(this).attr('action');
  var formData = $(this).serializeArray();
  $.ajax({
    url: url,
    method: 'POST',
    data: formData,
    success: function (response) {
      if (response.success) {
        $('.profile-alert').fadeOut();
        toastr.success('Your profile is updated successfullly.');
      } else {
        if (typeof response.error === 'string') {
          $('.profile-alert').html(response.error);
        }
        if (typeof response.error === 'object') {
          $('.profile-alert').html(Object.values(response.error)[0]);
        }
        $('.profile-alert').fadeIn();
      }
    },
  });
});

$('#password_form').submit(function (event) {
  event.preventDefault();
  var url = $(this).attr('action');
  var formData = $(this).serializeArray();
  $.ajax({
    url: url,
    method: 'POST',
    data: formData,
    success: function (response) {
      if (response.success) {
        $('.password-alert').fadeOut();
        $('input[name="old_password"]').val('');
        $('input[name="new_password"]').val('');
        $('input[name="confirm_password"]').val('');
        toastr.success('Update your password successfullly.');
      } else {
        if (typeof response.error === 'string') {
          $('.password-alert').html(response.error);
        }
        if (typeof response.error === 'object') {
          $('.password-alert').html(Object.values(response.error)[0]);
        }
        $('.password-alert').fadeIn();
      }
    },
  });
});

$('#profile_photo').on('click', function () {
  $('#profile_photo_input').click();
});

$('#profile_photo_input').on('change', function () {
  var fileType = this.files[0].type;
  if (!fileType || !fileType.startsWith('image/')) {
    toastr.error('Selected file is not an image.');
    return;
  }

  var formData = new FormData();
  formData.append('photo', this.files[0]);

  $.ajax({
    url: '/profile/photo',
    method: 'POST',
    data: formData,
    processData: false,
    contentType: false,
    success: function (response) {
      $('#profile_photo img').attr('src', response.photo);
    },
  });
});
