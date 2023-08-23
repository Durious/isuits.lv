<!-- Footer Starts -->
<footer class="footer-area">
    <div class="footer-widget">
        <div class="container">
            <div class="row">
                <div class="col-lg-3">
                    <div class="footer-widget widget widget_nav_menu">
                        <h5 class="widget-title">{{_t('navigation')}}</h5>
                        <ul>
{{--                            <li><a href="{{ route('customer.home') }}">{{_t('home')}}</a></li>   --}}
{{--                            <li><a href="{{ route('customer.products', ['type' => 'men']) }}">{{_t('shop_men')}}</a></li> --}}
{{--                            <li><a href="{{ route('customer.products', ['type' => 'women']) }}">{{_t('shop_women')}}</a></li> --}}
{{--                            <li><a href="{{ route('customer.services.index') }}">{{_t('service', 2)}}</a></li> --}}
                        </ul>
                    </div>
                </div>
                <div class="col-lg-3">
                    <div class="footer-widget widget widget_nav_menu">
                        <h5 class="widget-title">{{_t('customer_care')}}</h5>
                        <ul>
{{--                        <li><a href="{{ route('customer.about') }}">{{_t('about_us')}}</a></li> --}}
                            <li><a href="{{ route('customer.contactus') }}">{{_t('contact_us')}}</a></li>
                            <li><a href="{{ route('customer.terms') }}">{{_t('terms_condition')}}</a></li>
                            <li><a href="{{ url('').'#section-faq' }}">{{_t('faq')}}</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="footer-widget widget">
                        <h5 class="widget-title">{{_t('newsletter')}}</h5>
                        <p>
                            {{$subscribe->description ?? ''}}
                        </p>
                        <form action="{{route('subscriber.store')}}" class="mt-4">
                            <input type="email" placeholder="{{_t('your_email_address')}}" name="email" id="email"
                                onfocus="this.placeholder = ''" onblur="this.placeholder = 'Your Email Address'"
                                required />
                            <button type="submit"><span>&rharu;</span></button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    @if (session('success'))
        <div class="alert alert-success alert-dismissible fade show m-5" style="width: 300px; position: absolute; top: 50px; right: 0" role="alert">
            {{ session('success') }}
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    @endif

    <div class="copyright-area">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-12 d-md-flex justify-content-between">
                    <div class="copyright-logo align-self-center">
                        <a href="index.html"><img src="assets/img/logo/logo2.png" alt="" /></a>
                    </div>
                    <div class="copyright-content align-self-center text-center">
                        {{$footer->text ?? '@copyright'}}
                    </div>
                    <div class="copyright-link align-self-center">
                        <ul>
                            <li><a href="{{$footer->facebook ?? '#'}}">facebook</a></li>
                            <li><a href="{{$footer->instagram ?? '#'}}">instagram</a></li>
                            <li><a href="{{$footer->twitter ?? '#'}}">twitter</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</footer>
<!-- Footer End -->
