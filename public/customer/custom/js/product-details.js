showCustomizeStep(0);
drawPreview();
$.ratePicker("#rate", {
  max :5,
  rate :function (stars){
    console.log(stars)
  }
});
$('#btn_product_customize').on('click', function () {
  if (!loginState) {
    return openLoginPopup();
  }
  $('#btn_customize_prev_step').html(`<span>&lharu;</span> ${Lang.get('message.cancel_customize')}`);
  $('#btn_customize_next_step').html(`${Lang.get('message.next')} <span>&rharu;</span>`);
  $('#product_description').fadeOut();
  $('#customization_wizard').fadeIn();
});

$('#btn_add_to_cart').on('click', function (event) {
  if (!loginState) {
    return openLoginPopup();
  }
  addSelectedProductToCart(event.target);
});

$('#btn-write-review').on('click', function() {
  $('.product-reviews').addClass('d-none');
  $('.product-review-form').removeClass('d-none');
});

$('#btn-cancel-review').on('click', function() {
  $('.product-reviews').removeClass('d-none');
  $('.product-review-form').addClass('d-none');
});

$('#btn-write-comment').on('click', function() {
  $('.product-comments').addClass('d-none');
  $('.product-comment-form').removeClass('d-none');
});

$('#btn-cancel-comment').on('click', function() {
  $('.product-comments').removeClass('d-none');
  $('.product-comment-form').addClass('d-none');
});

function drawPreview() {
  const tagPreview = $('#step_title_' + step).attr('preview');
  var checkedRadios = $(`#step_item_${step} input[type="radio"]:checked`)
    .map(function () {
      return $(this).attr('preview');
    })
    .get();
  if (tagPreview) {
    $('#product-main-photo-image').addClass('d-none');
    $('#customization-preview-image').removeClass('d-none');
    $('#product-customization-preview').attr('src', '/storage/tagpreview/' + tagPreview);
    $('.customfield-preview-container .customfield_preview').remove();
    $('.customfield-preview-container').append(
      checkedRadios.map(item => (item ? `<img src='/storage/customfield/${item}' class='customfield_preview' />` : null))
    );
  } else {
    $('#product-main-photo-image').removeClass('d-none');
    $('#customization-preview-image').addClass('d-none');
  }
}

async function moveToNextCustomizeStep() {
  if (step < maxStep) {
    showCustomizeStep(step + 1);
  } else {
    const result = await setCustomized(true);
    if (result) {
      $('#product_description').fadeIn();
      $('#customization_wizard').fadeOut();
    }
  }
}

async function moveToPrevCustomizeStep() {
  if (step > 0) {
    showCustomizeStep(step - 1);
  } else {
    const result = await setCustomized(false);
    if (result) {
      $('#product_description').fadeIn();
      $('#customization_wizard').fadeOut();
    }
  }
}

$('#btn_cancel_customize').on('click', function () {
  setCustomized(false);
});

$('#btn_quantity_minus').on('click', function () {
  if (quantity > 1) {
    quantity--;
    $('#product_quantity').html(quantity);
  }
});

$('#btn_quantity_plus').on('click', function () {
  quantity++;
  $('#product_quantity').html(quantity);
});

function showCustomizeStep(s) {
  $('#step_item_' + step).removeClass('active');
  $('#step_title_' + step).removeClass('active');
  $('#step_item_' + s).addClass('active');
  $('#step_title_' + s).addClass('active');
  if (s === 0) {
    $('#btn_customize_prev_step').html(`<span>&lharu;</span> ${Lang.get('message.cancel_customize')}`);
  } else if (s === maxStep) {
    $('#btn_customize_next_step').html(`${Lang.get('message.complete_customize')} <span>&rharu;</span>`);
  } else {
    $('#btn_customize_prev_step').html(`<span>&lharu;</span> ${Lang.get('message.prev')}`);
    $('#btn_customize_next_step').html(`${Lang.get('message.next')} <span>&rharu;</span>`);
  }
  $('html, body').animate({
    scrollTop: 0,
  });
  step = s;
  drawPreview();
}

async function setCustomized(bCustomized, showConfirm = true) {
  customized = bCustomized;

  if (bCustomized) {
    if (showConfirm && !(await getConfirmResult('Are you sure to complete customization?'))) return false;
    $('.customized-alert').css('display', 'block');
    $('#btn_product_customize').css('display', 'none');
  }
  if (!bCustomized) {
    if (showConfirm && !(await getConfirmResult('Are you sure to cancel customization?'))) return false;
    showCustomizeStep(0);
    $('.customized-alert').css('display', 'none');
    $('#btn_product_customize').css('display', 'block');
  }
  return true;
}

async function addSelectedProductToCart(element) {
  const result = await getConfirmResult('Are you sure to add cart?');
  if (!result) return false;
  setLoadingButton(element, true);
  let customization = customized
    ? $('#customization_form')
        .serializeArray()
        .reduce((acc, { name, value }) => {
          acc[name] = value;
          return acc;
        }, {})
    : null;
  $.ajax({
    url: '/carts/addcart',
    method: 'POST',
    data: {
      product_id,
      quantity,
      customization,
    },
    success: function (response) {
      setLoadingButton(element, false);
      if (response.success) {
        toastr.success('Add to cart successfully.');
        getCartPopupList();
        openCartPopup();
        setCustomized(false, false);
      } else {
        toastr.error('An error has occurred. Try again.');
      }
    },
    error: function () {
      setLoadingButton(element, false);
    },
  });
}
