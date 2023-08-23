let current_measure_step = 0;

function openCustomerMeasureModal(event) {
  setLoadingButton(event.target, true);
  $.ajax({
    url: '/measure/modal',
    method: 'GET',
    success: function (response) {
      setLoadingButton(event.target, false);
      $('#section-measure-modal').html(response);
      $('#measure-modal').addClass('active');
      $('.body-overlay').addClass('active');
      setCustomerMeasureStep(0);
    },
    error: function () {
      setLoadingButton(event.target, false);
    }
  });
}

function updateCustomerMeasureContainer() {
  $.ajax({
    url: '/measure/container',
    method: 'GET',
    success: function (response) {
      $('#customer-measure-container').html(response);
    },
  });
}

function prevCustomerMeasureStep() {
  if (current_measure_step === 0) return;
  setCustomerMeasureStep(current_measure_step - 1);
}

function nextCustomerMeasureStep() {
  if (current_measure_step === 18) return;
  setCustomerMeasureStep(current_measure_step + 1);
}

function setCustomerMeasureStep(step) {
  current_measure_step = step;
  $('.measure-current-step').html(step + 1);
  for (let index = 0; index <= 18; index++) {
    $('.measure-step-' + index).addClass('d-none');
  }
  $('.measure-step-' + step).removeClass('d-none');
  $('.measure-step-' + step + ' input:first').focus();
  if (step === 0) {
    $('.btn-prev-measure').addClass('d-none');
    $('.btn-next-measure').removeClass('d-none');
    $('.btn-submit-measure').addClass('d-none');
  } else if (step === 18) {
    $('.btn-prev-measure').removeClass('d-none');
    $('.btn-next-measure').addClass('d-none');
    $('.btn-submit-measure').removeClass('d-none');
  } else {
    $('.btn-prev-measure').removeClass('d-none');
    $('.btn-next-measure').removeClass('d-none');
    $('.btn-submit-measure').addClass('d-none');
  }
}

function saveCustomerMeasure(event) {
  event.preventDefault();
  
  var url = $('#customer_measure_form').attr('action');
  var formData = $('#customer_measure_form').serializeArray();
  $.ajax({
    url: url,
    method: 'POST',
    data: formData,
    success: function (response) {
      if (response.success) {
        toastr.success('Customer measure is saved successfully!');
        closeModal('measure-modal');
        updateCustomerMeasureContainer();
      } else {
        let error = '';
        if (typeof response.error === 'string') {
          error = response.error;
        } else if (typeof response.error === 'object') {
          error = Object.values(response.error)[0];
        } else {
          error = 'An unexpected error occured, try again';
        }
        toastr.error(error);
      }
    },
  });
}