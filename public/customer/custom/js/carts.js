function updateCartQuantity(cart_id, changed) {
  $.ajax({
    url: '/carts/' + cart_id + '/quantity',
    method: 'POST',
    data: {
      changed
    },
    success: function (response) {
      if(response.success) {
        toastr.success('Cart quantity is updated successfully.');
        getCartList();
        getCartPopupList();
      } else {
        toastr.error(response.error);
      }
    }
  });
}

function getCartList() {
  $.ajax({
    url: '/carts/cart_list',
    method: 'GET',
    success: function (response) {
      $('.section-cart-list #cart-list').html(response);
    },
  });
}