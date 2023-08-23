function saveBillingAddress(event) {
  event.preventDefault();
  var url = $('#billing_address_form').attr('action');
  var operation = $('#billing_address_form').attr('operation');
  var formData = $('#billing_address_form').serializeArray();
  $.ajax({
    url: url,
    method: 'POST',
    data: formData,
    success: function (response) {
      if (response.success) {
        getBillingList(`Billing is ${operation}d successfully!`);
        closeModal('billing-modal');
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

function getBillingList(message = null) {
  const selectable = Boolean($('#billing_item_selectable').val())
  $.ajax({
    url: '/billing_address',
    method: 'GET',
    data: {
      selectable: selectable
    },
    success: function (response) {
      $('#billing-list').html(response);
      if (message) toastr.success(message);
    },
  });
}

function openBillingCreateModal(id, event) {
  if(event)
    event.stopPropagation();
  $.ajax({
    url: '/billing_address/' + id,
    method: 'GET',
    success: function (response) {
      $('#section-billing-modal').html(response);
      $('#billing-modal').addClass('active');
      $('.body-overlay').addClass('active');
      $('#billing_phone').intlTelInput({
        showFlags:true,
      });
      $("#billing_country_selector").countrySelect({
        localizedCountries:null,
      });
    },
  });
}

function deleteBillingAddress(id, event) {
  event.stopPropagation();
  if(!confirm('Are you sure to delete billing address?'))
    return;
  $.ajax({
    url: '/billing_address/' + id,
    method: 'DELETE',
    success: function (response) {
      if (response.success) {
        getBillingList('Billing is removed successfully!');
      } else {
        toastr.error('An unexpected error occured, try again.');
      }
    },
  });
}

function setDefaultBillingAddress(id) {
  $.ajax({
    url: '/billing_address/' + id + '/default',
    method: 'POST',
    success: function (response) {
      if (response.success) {
        getBillingList('Set the default billing address successfully!');
      } else {
        toastr.error('An unexpected error occured, try again.');
      }
    },
  });
}