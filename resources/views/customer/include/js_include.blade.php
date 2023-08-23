<!-- jquery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script src="{{ asset('messages.js') }}"></script>
<!-- popper -->
<script src="{{asset('customer/js/popper.min.js')}}"></script>
<!-- bootstrap -->
<script src="{{asset('customer/js/bootstrap.min.js')}}"></script>
<!-- magnific popup -->
<script src="{{asset('customer/js/jquery.magnific-popup.js')}}"></script>
<!-- wow -->
<script src="{{asset('customer/js/wow.min.js')}}"></script>
<!-- owl carousel -->
<script src="{{asset('customer/js/owl.carousel.min.js')}}"></script>
<!-- waypoint -->
<script src="{{asset('customer/js/waypoints.min.js')}}"></script>
<!-- counterup -->
<script src="{{asset('customer/js/jquery.counterup.min.js')}}"></script>
<!-- imageloaded -->
<script src="{{asset('customer/js/imagesloaded.pkgd.min.js')}}"></script>
<!-- isotope -->
<script src="{{asset('customer/js/isotope.pkgd.min.js')}}"></script>

<script src="{{asset('customer/js/jquery.datetimepicker.full.min.js')}}"></script>
<script src="{{asset('customer/js/jquery-rate-picker.js')}}"></script>
<script src="{{asset('customer/js/countdown.js')}}"></script>
<!-- slick -->
<script src="{{asset('customer/js/slick.min.js')}}"></script>
<!-- intlTelInput -->
<script src="{{asset('customer/js/intlTelInput-jquery.min.js')}}"></script>
<script src="{{asset('customer/js/countrySelect.min.js')}}"></script>
<!-- Confirm Modal -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.js"></script>
<!-- Datepicker -->
<script src="{{asset('customer/js/datepicker.min.js')}}"></script>
<script src="{{asset('customer/js/datepicker-en.js')}}"></script>
<!-- Cookie -->
<script src="{{asset('customer/js/cookiealert.js')}}"></script>
<!-- toast js -->
<script src="{{asset('customer/js/toastr.min.js')}}"></script>
<!-- main js -->
<script src="{{asset('customer/js/main.js')}}"></script>
<!-- common js -->
<script src="{{asset('customer/custom/js/common.js')}}"></script>
<!-- chat js -->
<script src="{{asset('customer/custom/js/chat.js')}}"></script>
<!-- body-overlay js -->
<script src="{{asset('customer/custom/js/body-overlay.js')}}"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.15.5/dist/sweetalert2.all.min.js"></script>

<script
    src="https://cdn.socket.io/4.6.0/socket.io.min.js"
    integrity="sha384-c79GN5VsunZvi+Q/WObgk2in0CbZsHnjEqvFxC5DxHn9lTfNce2WW6h2pH6u/kF+"
    crossorigin="anonymous"></script>
<script>
    var csrfToken = $('meta[name="csrf-token"]').attr('content');
    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': csrfToken,
        },
    });
    @if(Session::has('message'))
    toastr.success("{{ session('message') }}");
    @endif

    @if(Session::has('error'))
    toastr.error("{{ session('error') }}");
    @endif

    @if(Auth::guard('customer')->check())
    var socket = io.connect('https://node.isuits.lv');
    // var socket = io.connect('http://localhost:3000');
    socket.on('USERID_REQUEST', function() {
        socket.emit('USERID_RESPONSE', {
            'user_id': {{ Auth::guard('customer')->id() }},
            'type': 'customer',
        });
    });
    socket.on('CUSTOMER_MSG_RECEIVED', function() {
        var userId = $('.chat-send #chat_user_id').val();
        if (userId) {
            showChatHistory(userId);
        }
    });

    socket.on('notification', function(data) {
        let notiCount = parseInt($('#noti-count').text()) + 1;
        if (notiCount >= 0)
            $('#noti-count').text(notiCount);

        $('.empty-noti').remove();
        const time = new Date().getTime();
        var humanReadableTime = moment(time).fromNow();

        $('.noti-list').prepend(`<div>
        <span style='display: inline-block' class='noti-is-new badge badge-pill badge-danger ml-2' id='${'new-badge-' + time}'>New</span>
        <span style='display: none' class='noti-created-time last-time ml-auto'
              id='${'read-time-' + time}'>
                            ${humanReadableTime}
                </span>
        <div class='alert alert-info'>
            <div
                style='cursor: pointer; color: blue; overflow: hidden; text-overflow: ellipsis; white-space: nowrap'
                type='button' data-toggle='collapse'
                data-target='${'#notification' + time}'>${data}</div>
            <div id='${'notification' + time}'
                 class='notification-collapse collapse mt-2'>${data}</div>
            <span style='display: none'>${time}</span>
        </div>

    </div>`);

        $('.notification-collapse').on('shown.bs.collapse', function() {
            const id = $(this).next().text();
            $('#new-badge-' + id).hide();
            $('#read-time-' + id).show();

            let notiCount = parseInt($('#noti-count').text()) - 1;
            if (notiCount >= 0)
                $('#noti-count').text(notiCount);

            const index = $('.noti-list').children().length - 1;

            $.ajax({
                url: '/notification/readByIndex',
                method: 'POST',
                data: { index },
                success: function(response) {
                    console.log(response);
                },
                error: function(xhr, status, error) {
                    console.error(error);
                },
            });
        }).on('hidden.bs.collapse', function() {
            // do something else when the collapse animation is complete
        });
    });
    @endif

    $('.notification-collapse').on('shown.bs.collapse', function() {
        const id = $(this).next().text();
        $('#new-badge-' + id).hide();
        $('#read-time-' + id).show();

        let notiCount = parseInt($('#noti-count').text()) - 1;
        if (notiCount >= 0)
            $('#noti-count').text(notiCount);

        $.ajax({
            url: '/notification/read',
            method: 'POST',
            data: { id },
            success: function(response) {
                console.log(response);
            },
            error: function(xhr, status, error) {
                console.error(error);
            },
        });
    }).on('hidden.bs.collapse', function() {
        // do something else when the collapse animation is complete
    });

    $('#noti-read-all').click(function() {
        const id = $(this).next().text();
        $('.noti-is-new').hide();
        $('.noti-created-time').show();

        $('#noti-count').text('0');

        $.ajax({
            url: '/notification/readAll',
            method: 'POST',
            success: function(response) {
                console.log(response);
            },
            error: function(xhr, status, error) {
                console.error(error);
            },
        });
    });

    $('#noti-detail').click(function() {
        window.open('/notification');
    });
</script>
