<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <title>ISuits - @yield('title')</title>
    <link rel="icon" href="{{asset('favicon.ico')}}" sizes="20x20" type="image/png" />
    
    @include('customer.include.css_include')
    @yield('css_style')
</head>

<body class="@yield('body_class')">
    <!-- preloader area start -->
    <div class="preloader" id="preloader">
        <div class="preloader-inner">
            <div class="spinner">
                <div class="dot1"></div>
                <div class="dot2"></div>
            </div>
        </div>
    </div>
    <!-- preloader area end -->

    @if(Auth::guard('customer')->guest())
        @include('customer.auth.index')
    @else
        @include('customer.components.cart')
        @include('customer.chats.index')
    @endif

    @include('customer.components.search')
    @include('customer.components.promotion')

    {{-- BEGIN MAIN LAYOUT --}}

    @include('customer.layout.header')
    @yield('container')
    @include('customer.layout.footer')

    {{-- END MAIN LAYOUT --}}

    <!-- back to top area start -->
    <div class="back-to-top">
        <span>{{_t('back_to_top')}}</span>
    </div>
    <!-- back to top area end -->

    <!-- START Bootstrap-Cookie-Alert -->
    <div class="alert text-center cookiealert" role="alert">
        <b>Do you like cookies?</b> &#x1F36A; We use cookies to ensure you get the
        best experience on our website. <a href="#" target="_blank">Learn more</a>

        <button type="button" class="btn btn-sm acceptcookies" aria-label="Close">
            I agree
        </button>
    </div>
    <!-- END Bootstrap-Cookie-Alert -->

    @include('customer.include.js_include')
    @yield('js_script')
</body>

</html>
