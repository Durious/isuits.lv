<!-- navbar area starts -->
<nav class="navbar navbar-area navbar-expand-lg nav-style-02 nav-absolute">
    <div class="container-fluid nav-container">
        <div class="responsive-mobile-menu">
            <div class="logo-wrapper">
                <a href="{{ route('customer.home') }}" class="logo">
                    <img src="{{asset($account_logo)}}" alt="logo" height="45" />
                    <h4>ISuits <br />Frontend</h4>
                </a>
            </div>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#bizcoxx_main_menu"
                    aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
        </div>

        <div class="collapse navbar-collapse" id="bizcoxx_main_menu">
            <ul class="navbar-nav">
                <li>
                    <a href="{{ route('customer.home') }}">{{_t('home')}}</a>
                </li>
                <li>
                    <a href="/services">{{_t('service', 2)}}</a>
                </li>
                <li class="menu-item-has-children">
                    <a href="#">{{_t('clothes')}}</a>
                    <ul class="sub-menu">
                        <li><a href="{{ route('customer.products', ['type' => 'men']) }}">{{_t('men')}}</a></li>
                        <li><a href="{{ route('customer.products', ['type' => 'women']) }}">{{_t('women')}}</a></li>
                    </ul>
                </li>
                <li>
                    <a href="{{ route('customer.about') }}">{{_t('about_us')}}</a>
                </li>               
                <li>
                    <form method="POST" action="{{route('customer.lang')}}" id="form_locale">
                        @csrf
                        @php
                            $langCode = app()->getLocale();
                            $languages = getLocales();
                        @endphp

                        <select class="select-language" id="select_language" name="lang">
                            @foreach ($languages as $lang_item)
                                <option
                                    value="{{ $lang_item->value }}"
                                    {{ $langCode === $lang_item->value ? 'selected' : '' }}
                                >
                                    {{ $lang_item->flag }}
                                </option>
                            @endforeach
                        </select>
                    </form>
                </li>
            </ul>
        </div>

        <div class="nav-right-content">
            <ul>
                <li class="search" id="search" style='margin: 0'>
                    <span class="lnr lnr-magnifier"></span>
                </li>
                @if(Auth::guard('customer')->guest())
                    <li class="ml-3 floating-icon-3 user">
                        <span class="lnr lnr-user"></span>
                    </li>
                @else
                    <li class="notification floating-icon-2 cursor-pointer">
                        <div class="cart-sec">
                            <a href="#"><span class="lnr lnr-envelope"></span></a>
                            <span class="cart-count" id="noti-count"
                                  style='left: 10px'>{{Auth::guard('customer')->user()->unreadNotifications->count()}}</span>
                        </div>
                    </li>

                    <li class="cart floating-icon-1">
                        <div class="cart-sec">
                            <a href="#"><span class="lnr lnr-cart"></span></a>
                            <span class="cart-count"
                                  style='left: 10px'>{{count(Auth::guard('customer')->user()->carts)}}</span>
                        </div>
                    </li>
                    <li class="dropdown user-info">
                        <a class="nav-link dropdown-toggle p-0" href="#" data-toggle="dropdown" aria-haspopup="true"
                           aria-expanded="false">
                            <span class="lnr lnr-user"></span>
                        </a>
                        <div class="dropdown-menu dropdown-menu-right">
                            <a class="dropdown-item" href="#">{{Auth::guard('customer')->user()->name}}</a>
                            <a class="dropdown-item" href="{{ route('customer.profile') }}">{{_t('My Profile')}}</a>
                            <a class="dropdown-item" href="{{ route('customer.carts') }}">{{_t('my_carts')}}</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="{{ route('customer.logout') }}">{{_t('Logout')}}</a>
                        </div>
                    </li>
                @endif
            </ul>
        </div>
    </div>
</nav>
<!-- navbar area end -->
