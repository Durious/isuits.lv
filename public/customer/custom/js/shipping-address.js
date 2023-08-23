function saveShippingAddress(event) {
  event.preventDefault();
  var url = $('#shipping_address_form').attr('action');
  var operation = $('#shipping_address_form').attr('operation');
  var formData = $('#shipping_address_form').serializeArray();
  $.ajax({
    url: url,
    method: 'POST',
    data: formData,
    success: function (response) {
      if (response.success) {
        getShippingList(`Shipping is ${operation}d successfully!`);
        closeModal('shipping-modal');
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

function getShippingList(message = null) {
  const selectable = Boolean($('#shipping_item_selectable').val())
  $.ajax({
    url: '/shipping_address',
    method: 'GET',
    data: {
      selectable: selectable
    },
    success: function (response) {
      $('#shipping-list').html(response);
      if (message) toastr.success(message);
    },
  });
}

function openShippingCreateModal(id, event) {
  if(event)
    event.stopPropagation();
  $.ajax({
    url: '/shipping_address/' + id,
    method: 'GET',
    success: function (response) {
      $('#section-shipping-modal').html(response);
      $('#shipping-modal').addClass('active');
      $('.body-overlay').addClass('active');
      $('#shipping_phone').intlTelInput({
        showFlags:true,
      });
      $("#shipping_country_selector").countrySelect({
        localizedCountries:null,
      });
    },
  });
}

function deleteShippingAddress(id, event) {
  event.stopPropagation();
  if(!confirm('Are you sure to delete shipping address?'))
    return;
  $.ajax({
    url: '/shipping_address/' + id,
    method: 'DELETE',
    success: function (response) {
      if (response.success) {
        getShippingList('Shipping is removed successfully!');
      } else {
        toastr.error('An unexpected error occured, try again.');
      }
    },
  });
}

function setDefaultShippingAddress(id) {
  $.ajax({
    url: '/shipping_address/' + id + '/default',
    method: 'POST',
    success: function (response) {
      if (response.success) {
        getShippingList('Set the default shipping address successfully!');
      } else {
        toastr.error('An unexpected error occured, try again.');
      }
    },
  });
}