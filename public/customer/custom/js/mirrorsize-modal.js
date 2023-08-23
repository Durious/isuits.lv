function openCustomerMirrorsizeModal(event) {
  setLoadingButton(event.target, true);
  $.ajax({
    url: '/mirrorsize/modal',
    method: 'GET',
    success: function (response) {
      setLoadingButton(event.target, false);
      $('#section-mirrorsize-modal').html(response);
      $('#mirrorsize-modal').addClass('active');
      $('.body-overlay').addClass('active');
    },
    error: function (err) {
      setLoadingButton(event.target, false);
      if (typeof err === 'string') {
        toastr.error(err);
      } else {
        toastr.error(err.statusText);
      }
    },
  });
}

async function handleMirrorsizeSubmit(event) {
  event.preventDefault();
  var url = $(event.target).attr('action');
  const frontImage = event.target.querySelector('input[name="frontImage"]').files[0];
  const sideImage = event.target.querySelector('input[name="sideImage"]').files[0];
  const submitBtn = event.target.querySelector('button[type="submit"]');
  var formData = $(event.target).serializeArray();
  formData.push({ name: 'frontImage', value: await toBase64(frontImage) });
  formData.push({ name: 'sideImage', value: await toBase64(sideImage) });
  $(submitBtn).html('Analyzing Images...')
  setLoadingButton(submitBtn, true);
  // Set measurement
  $.ajax({
    url: url,
    method: 'POST',
    data: formData,
    success: function (response) {
      if(response.success) {
        // Get measurement
        $(submitBtn).html('Getting Result...')
        setLoadingButton(submitBtn, true);
        $.ajax({
          url: '/mirrorsize/get_measure',
          method: 'POST',
          data: response.data,
          success: function (response) {
            if(response.success) {
              $(submitBtn).fadeOut();
              toastr.success('Customer measure is saved successfully!');
              closeModal('mirrorsize-modal');
              updateCustomerMeasureContainer();
            } else {
              $(submitBtn).html('Submit')
              toastMessage(response.error);
              setLoadingButton(submitBtn, false);
            }
          },
        });
      } else {
        $(submitBtn).html('Submit')
        toastMessage(response.error);
      }
    },
  });
}

const toBase64 = file =>
  new Promise((resolve, reject) => {
    if (!file) resolve(null);
    const reader = new FileReader();
    reader.readAsDataURL(file);
    reader.onload = () => {
      let encoded = reader.result.toString().replace(/^data:(.*,)?/, '');
      if ((encoded.length % 4) > 0) {
        encoded += '='.repeat(4 - (encoded.length % 4));
      }
      resolve(encoded)
    };
    reader.onerror = error => reject(error);
  });
