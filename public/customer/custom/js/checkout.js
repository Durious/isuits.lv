const PAYMENT_METHOD = {
    MT_SYSTEM: 'Monezium',
    CREDIT_CARD: 'Credit Card',
    WIRE_TRANSFER: 'Wire Transfer'
}
function verifyCheckout() {
    var paymentMethod = $('input[name="payment_method"]:checked').val();
    if(!paymentMethod) {
        toastr.error('Please select payment information.');
        return;
    }
    $.ajax({
        url: "/orders/verify",
        method: 'POST',
        success: function(response) {
            if (response.success) {
                if(paymentMethod === PAYMENT_METHOD.MT_SYSTEM) {
                    $('#mt-payment-system').click();
                } else {
                    onCheckoutPaySuccess(
                        {
                            status: 'pending',
                            reference: generateRandomString(12)
                        },
                        paymentMethod
                    )
                }
            } else {
                toastr.error(response.error);
            }
        }
    });
}
function generateRandomString(length) {
    let result = '';
    const characters ='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    const charactersLength = characters.length;
    for ( let i = 0; i < length; i++ ) {
        result += characters.charAt(Math.floor(Math.random() * charactersLength));
    }
    return result;
}
var onCheckoutPaySuccess = function (message, gateway = PAYMENT_METHOD.MT_SYSTEM) {
    $.ajax({
        url: "/orders",
        method: 'POST',
        data: {
            ...message,
            gateway
        },
        success: function(response) {
            if (response.success) {
                toastr.success('Payment is proceed successfully. Thanks.');
                setTimeout(() => {
                    window.location.href="/products/all";
                }, 1000);
            } else {
                toastr.error(response.error);
            }
        }
    });
}
var onCheckoutPayError = function (message) {
    toastr.error(message);
}