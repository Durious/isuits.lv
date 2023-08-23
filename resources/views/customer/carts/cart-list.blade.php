<div class="cart-box my-3">
    @php
        $carts = Auth::guard('customer')->user()->carts;
        $total_price = 0;
    @endphp
    @foreach ($carts as $key => $cart_item)
        <div class="single-cart d-flex justify-content-between mb-5">
            <div class="cart-left d-flex">
                <div class="cart-image"
                    style="background-image: url('{{ asset('/storage/product/' . $cart_item->product->main_photo) }}')">
                </div>
                <div class="cart-text">
                    <h4>{{ $cart_item->product->name }}</h4>
                    @if(json_decode($cart_item->customization))
                        @foreach(json_decode($cart_item->customization) as $key => $customization_item)
                            <div>{{$key}}: <strong>{{$customization_item}}</strong></div>
                        @endforeach
                    @endif
                </div>
            </div>
            <div class="cart-center align-self-center">
                <div class="cart-quantity">
                    <ul>
                        <li>
                            <span onclick="updateCartQuantity({{$cart_item->id}}, -1)"><i class="ti-minus"></i></span>
                        </li>
                        <li><span>{{ $cart_item->quantity }}</span></li>
                        <li>
                            <span onclick="updateCartQuantity({{$cart_item->id}}, 1)"><i class="ti-plus"></i></span>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="cart-right d-flex align-self-center">
                <div class="cart-price">
                    <h4>€{{ number_format($cart_item->unit, 2) }}</h4>
                </div>
                <div class="cart-icon mr-120 cursor-pointer" onclick="deleteCart({{$cart_item->id}})">
                    <img src="{{asset('customer/img/cart-tab-page/icon-1.png')}}" alt="" />
                </div>
            </div>
        </div>
    @php
        $total_price += $cart_item->unit * $cart_item->quantity;
    @endphp
    @endforeach
    <!-- Estimation Section Starts -->
    <section class="estimation-section-main section-padding-top4">
        <div class="container">
            <div class="row estimation-section">
                <div class="col-lg-6">
                    <div class="estimation-left">
                        <div class="left-title">
                            <h4>{{_t('estimation')}}</h4>
                        </div>

                        <div class="left-text d-md-flex">
                            <div class="name">
                                <ul>
                                    <li>{{_t('order', 1)}}</li>
                                    <li>{{_t('bonus')}} / {{_t('discount')}}</li>
                                    <li>{{_t('tax', 2)}}</li>
                                </ul>
                            </div>
                            <div class="price">
                                <ul>
                                    <li>€{{$total_price}}</li>
                                    <li>$ 0</li>
                                    <li>$ 0</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="estimation-right text-right">
                        <div class="right-title">
                            <h4>{{_t('total')}}</h4>
                            <h3>€{{number_format($total_price, 2)}}</h3>
                            <a href="{{route('customer.checkout')}}" class="template-btn2 off1">{{_t('checkout')}}
                                <span>&rharu;</span></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Estimation Section End -->
</div>