$('#login_form').submit(function (event) {
  event.preventDefault();
  var url = $(this).attr('action');
  var formData = $(this).serializeArray();
  $.ajax({
    url: url,
    method: 'POST',
    data: formData,
    success: function (response) {
      if (response.success) {
        location.reload();
      } else {
        if (typeof response.error === 'string') {
          $('.login-alert').html(response.error);
        } else if (typeof response.error === 'object') {
          $('.login-alert').html(Object.values(response.error)[0]);
        } else {
          $('.login-alert').html('An unexpected error occured, try again');
        }
        $('.login-alert').fadeIn();
      }
    },
  });
});

$('#signup_form').submit(function (event) {
  event.preventDefault();
  var url = $(this).attr('action');
  var formData = $(this).serializeArray();
  $.ajax({
    url: url,
    method: 'POST',
    data: formData,
    success: function (response) {
      if (response.success) {
        $('.login-content').removeClass('part-hide');
        $('.signup-content').removeClass('part-active');
      } else {
        if (typeof response.error === 'string') {
          $('.signup-alert').html(response.error);
        } else if (typeof response.error === 'object') {
          $('.signup-alert').html(Object.values(response.error)[0]);
        } else {
          $('.signup-alert').html('An unexpected error occured, try again');
        }
        $('.signup-alert').fadeIn();
      }
    },
  });
});

async function addToCart(product_id, event) {
  const result = await getConfirmResult('Are you sure to add cart?');
  if(!result)
    return false;
  setLoadingButton(event.target, true);
  $.ajax({
    url: '/carts/addcart',
    method: 'POST',
    data: {
      product_id,
      quantity: 1,
      customization: null,
    },
    success: function (response) {
      setLoadingButton(event.target, false);
      if (response.success) {
        toastr.success('Add to cart successfully.');
        getCartPopupList();
        openCartPopup();
      } else {
        toastr.error('An error has occurred. Try again.');
      }
    },
    error: function () {
      setLoadingButton(event.target, false);
    },
  });
}

function getCartPopupList() {
  const cart_item_template = `
    <div class="single-item d-flex justify-content-between py-3 {{border_top}}">
      <div class="item-left d-flex">
        <div class="item-image" style="background-image: url({{photo_url}})"></div>
        <div class="item-name align-self-center">
          <h6>{{name}}</h6>
          <div>{{customization}}</div>
        </div>
      </div>
      <div class="item-right d-flex align-items-center">
        <div class="item-price">
          <h6>{{unit}} &times; {{quantity}}</h6>
        </div>
        <div class="item-icon ml-3">
          <i class="fa fa-trash-o" onclick="deleteCart({{id}})"></i>
        </div>
      </div>
    </div>
  `;
  $.ajax({
    url: '/carts/popup_list',
    method: 'GET',
    success: function (response) {
      if (response.success) {
        let cart_list_html = '';
        let cart_item_html = '';
        let total_price = 0;
        response.carts.forEach((item, index) => {
          customization = JSON.parse(item.customization) ?? [];

          cart_item_html = cart_item_template;
          cart_item_html = cart_item_html.replace('{{id}}', item.id);
          cart_item_html = cart_item_html.replace('{{unit}}', item.unit);
          cart_item_html = cart_item_html.replace('{{name}}', item.product.name);
          cart_item_html = cart_item_html.replace('{{quantity}}', item.quantity);
          cart_item_html = cart_item_html.replace('{{border_top}}', index !== 0 ? 'border-top' : '');
          cart_item_html = cart_item_html.replace('{{photo_url}}', '/storage/product/' + item.product.main_photo);
          cart_item_html = cart_item_html.replace(
            '{{customization}}',
            Object.keys(customization)
              .map(key_item => `<div>${key_item}: <strong>${customization[key_item]}</strong></div>`)
              .join('')
          );
          cart_list_html += cart_item_html;
          total_price += item.unit * item.quantity;
        });
        $('#cart-popup #cart_items').html(cart_list_html);
        $('.navbar .cart .cart-count').html(response.carts.length);
        $('#cart-popup .cart-title h6').html(`${response.carts.length} Items`);
        $('#cart-popup .total-price h3').html(
          `$ ${total_price.toLocaleString('en-US', {
            minimumFractionDigits: 2,
            maximumFractionDigits: 2,
          })}`
        );
      }
    },
  });
}

function deleteCart(cart_id) {
  $.ajax({
    url: '/carts/' + cart_id,
    method: 'DELETE',
    success: function (response) {
      if (response.success) {
        toastr.success('Selected cart is removed successfully.');
        if (typeof getCartList === 'function') {
          getCartList();
        }
        getCartPopupList();
      }
    },
  });
}

$('#checkbox_promotion_popup').on('change', function () {
  window.localStorage.setItem('promotionPrevent', $(this).prop('checked'));
});

function closeModal(id) {
  $('#' + id).removeClass('active');
  $('.body-overlay').removeClass('active');
}

function openModal(id) {
  $('#' + id).addClass('active');
  $('.body-overlay').addClass('active');
}

function openLoginPopup() {
  $('.login-popup').addClass('active');
  $('.body-overlay').addClass('active');
  $('.floating-icon').addClass('active');
}
function openCartPopup() {
  $('.cart-popup').addClass('active');
  $('.body-overlay').addClass('active');
  $('.floating-icon').addClass('active');
}

function setFavorite(product_id) {
  $.ajax({
    url: '/products/favorite',
    method: 'POST',
    data: {
      product_id,
    },
    success: function (response) {
      if (response.success) {
        toastr.success('Set as favorite successfully.');
        location.reload(true);
      } else {
        toastr.error('An error has occurred. Try again.');
      }
    },
  });
}

function setLoadingButton(element, status) {
  if (status && !element.querySelector('.spinner-border')) {
    element.insertAdjacentHTML('afterbegin', "<div class='spinner-border mr-3'></div>");
  }
  if (!status) {
    const spinnerChildren = element.querySelectorAll('.spinner-border');
    spinnerChildren.forEach(child => {
      child.remove();
    });
  }
}

async function getConfirmResult(text, header = null) {
  return new Promise((resolve) => {
    $.confirm({
      icon: 'fa fa-info',
      title: header ?? 'Info',
      content: text,
      type: 'blue',
      typeAnimated: true,
      buttons: {
        confirm: function () {
          resolve(true);
        },
        cancel: function () {
          resolve(false);
        },
      },
    });
  })
}

$('#select_language').on('change', function() {
  $('#form_locale').submit();
}) 

function toastMessage(message) {
  if (typeof message === 'string') {
    toastr.error(message)
  }
  if (typeof message === 'object') {
    toastr.error(Object.values(message)[0])
  }
}