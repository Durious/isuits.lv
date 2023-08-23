@extends('customer.layout.index')

@section('title', 'Checkout')

@section('body_class', 'checkout-page')

@section('css_style')
    <link rel="stylesheet" href="{{ asset('customer/custom/css/checkout.css') }}" />
@endsection

@section('container')

    @php
    $cart_list = Auth::guard('customer')->user()->carts;
    $total_price = Auth::guard('customer')->user()->total_price();
    @endphp
    <!-- Checkout Form Starts -->
    <section class="checkout-form">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="checkout-title section-padding-top2">
                        <h2>{{_t('checkout')}}</h2>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-7">
                    <div class="checkout-bg">
                        <div class="collapse-item border-bottom">
                            <a class="btn-collapse-title" data-toggle="collapse" data-target="#collapse_anatomic_measures"
                                aria-expanded="false" aria-controls="collapse_anatomic_measures">
                                <h3>Anatomic Measures</h3>
                                <div class="description">
                                    {{_t('please_select_x', ['x' => _t('measure')])}}
                                </div>
                            </a>
                            <div class="collapse" id="collapse_anatomic_measures">
                                <div class="collapse-content">
                                    <div id="customer-measure-container">
                                        @include('customer.profile.measures')
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="collapse-item border-bottom">
                            <a class="btn-collapse-title" data-toggle="collapse" data-target="#collapse_shipping"
                                aria-expanded="false" aria-controls="collapse_shipping">
                                <h3>{{_t('shipping_address')}}</h3>
                                <div class="description">
                                    {{_t('please_select_x', ['x' => _t('shipping')])}}
                                </div>
                            </a>
                            <div class="collapse" id="collapse_shipping">
                                <div class="collapse-content">
                                    <div id="shipping-list">
                                        @include('customer.profile.shipping_list', ['selectable' => true])
                                    </div>
                                    <input type="hidden" id="shipping_item_selectable" value="true" />
                                </div>
                            </div>
                        </div>
                        <div class="collapse-item border-bottom">
                            <a class="btn-collapse-title" data-toggle="collapse" data-target="#collapse_billing"
                                aria-expanded="false" aria-controls="collapse_billing">
                                <h3>{{_t('billing_address')}}</h3>
                                <div class="description">
                                    {{_t('please_select_x', ['x' => _t('billing')])}}
                                </div>
                            </a>
                            <div class="collapse" id="collapse_billing">
                                <div class="collapse-content">
                                    <div id="billing-list">
                                        @include('customer.profile.billing_list', ['selectable' => true])
                                    </div>
                                    <input type="hidden" id="billing_item_selectable" value="true" />
                                </div>
                            </div>
                        </div>
                        <div class="collapse-item pb-4">
                            <a class="btn-collapse-title" data-toggle="collapse" data-target="#collapse_payment"
                                aria-expanded="false" aria-controls="collapse_payment">
                                <h3>{{_t('payment')}}</h3>
                                <div class="description">
                                    {{_t('please_select_x', ['x' => _t('payment')])}}
                                </div>
                            </a>
                            <div class="collapse" id="collapse_payment">
                                <div class="collapse-content">
                                    <div class="d-flex align-items-start">
                                        <input type="radio" class="mt-1" name="payment_method" id="payment_monezium" value="Monezium"/>
                                        <label for="payment_monezium" class="ml-2">
                                            <h6>Monezium</h6>
                                        </label>
                                    </div>
                                    <div class="d-flex align-items-start mt-3">
                                        <input type="radio" class="mt-1" name="payment_method" id="payment_wire_transfer" value="Wire Transfer"/>
                                        <label for="payment_wire_transfer" class="ml-2">
                                            <h6>Wire Transfer</h6>
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="text-center" style="margin: 0px 10px;">
                            <button 
                                class="template-btn2 on1 w-100 text-uppercase" 
                                type="button" 
                                onclick="verifyCheckout()"
                            >
                                {{_t('confirm')}}
                            </button>
                            <div id="mt-payment-system"
                                class="d-none"
                                data-sitekey="{{env('MONEZIUM_SITE_KEY', 'test_monezium_site_key')}}"
                                data-siteurl="https://monezium.eu"
                                data-currency="EUR"
                                data-amount="{{$total_price}}"
                                data-shopkey="{{env('MONEZIUM_SHOP_KEY', 'test_monezium_shop_key')}}"
                                fn-success="onCheckoutPaySuccess"
                                fn-error="onCheckoutPayError">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xl-4 offset-xl-1 col-lg-5">
                    <div class="checkout-bg">
                        <h5 class="d-flex my-4">{{_t('your_order')}}: <span class="ml-auto">{{count($cart_list)}} {{_t('item', count($cart_list))}}</span></h5>
                        <hr/>
                        <h5 class="d-flex my-4">{{_t('shipping')}}: <span class="ml-auto">{{_t('free_charge')}}</span></h5>
                        <hr/>
                        <h5 class="d-flex my-4">{{_t('total_price')}}: <span class="ml-auto">€{{number_format($total_price, 2)}}</span></h5>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Checkout Form End -->
    <div id="section-shipping-modal">
        @include('customer.components.shipping_modal')
    </div>
    <div id="section-billing-modal">
        @include('customer.components.billing_modal')
    </div>
    <div id="section-measure-modal">
        @include('customer.components.measure_modal')
    </div>
    <div id="section-mirrorsize-modal">
        @include('customer.components.mirrorsize_modal')
    </div>
@endsection

@section('js_script')
    <script src="{{ asset('customer/custom/js/shipping-address.js') }}"></script>
    <script src="{{ asset('customer/custom/js/billing-address.js') }}"></script>
    <script src="{{ asset('customer/custom/js/measure-modal.js') }}"></script>
    <script src="{{ asset('customer/custom/js/mirrorsize-modal.js') }}"></script>
    <script src="https://monezium.eu/assets/api/payment.js"></script>
    <script src="{{ asset('customer/custom/js/checkout.js') }}"></script>
@endsection