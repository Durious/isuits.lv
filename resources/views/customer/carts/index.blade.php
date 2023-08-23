@extends('customer.layout.index')

@section('title', 'Carts')

@section('body_class', 'cart-tab-page')

@section('css_style')
    <link rel="stylesheet" href="{{ asset('customer/custom/css/carts.css') }}" />
@endsection

@section('container')
    <section class="section-cart-list">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="checkout-title section-padding-top2">
                        <h2 class="mb-5">{{_t('carts')}}</h2>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <div class="cart-section bg-white py-4">
                        <div class="qty-price text-center mt-5">
                            <ul>
                                <li class="right-margin">
                                    <h4>{{_t('qty')}}</h4>
                                </li>
                                <li>
                                    <h4>{{_t('price')}}</h4>
                                </li>
                            </ul>
                        </div>
                        <div id="cart-list">
                            @include('customer.carts.cart-list')                        
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
@endsection

@section('js_script')
    <script src="{{ asset('customer/custom/js/carts.js') }}"></script>
@endsection