<!-- cart-popup-starts -->
<div class="cart-popup" id="cart-popup">
    @php
        $carts = Auth::guard('customer')->user()->carts;
        $total_price = 0;
    @endphp
    <div class="cart-content">
        <span class="cross-icon"><i class="lnr lnr-cross"></i></span>
        <div class="cart-title text-center">
            <h2>{{_t('cart')}}</h2>
            <h6 class="text-right">{{count($carts)}} {{_t('item', count($carts))}}</h6>
        </div>
        <div class="cart-items" id="cart_items">
            @foreach($carts as $key => $cart_item)
                <div class="single-item d-flex justify-content-between py-3 {{$key !== 0 ? 'border-top' : ''}}">
                    <div class="item-left d-flex">
                        <div 
                            class="item-image"
                            style="background-image: url('{{asset('/storage/product/'.$cart_item->product->main_photo)}}')"
                        ></div>
                        <div class="item-name align-self-center">
                            <h6>{{$cart_item->product->name}}</h6>
                            <div>
                                @if(json_decode($cart_item->customization))
                                    @foreach(json_decode($cart_item->customization) as $key => $customization_item)
                                        <div>{{$key}}: <strong>{{$customization_item}}</strong></div>
                                    @endforeach
                                @endif
                            </div>
                        </div>
                    </div>
                    
                    <div class="item-right d-flex align-items-center">
                        <div class="item-price">
                            <h6>€{{number_format($cart_item->unit, 2)}} &times; {{$cart_item->quantity}}</h6>
                        </div>
                        <div class="item-icon ml-3" onclick="deleteCart({{$cart_item->id}})">
                            <i class="fa fa-trash-o"></i>
                        </div>
                    </div>
                </div>
            @php
                $total_price += $cart_item->unit * $cart_item->quantity;
            @endphp
            @endforeach
        </div>

        <div class="total-price text-right mt-3">
            <h4>{{_t('total')}}</h4>
            <h3>€{{ number_format($total_price, 2) }}</h3>
        </div>

        <div class="cart-buttons mt-4 mt-xl-5">
            {{-- <a href="#" class="template-btn2 off2 mb-4">View Cart <span>&rharu;</span></a> --}}
            <a href="{{route('customer.checkout')}}" class="template-btn2 off1">{{_t('checkout')}} <span>&rharu;</span></a>
        </div>
    </div>
</div>
<!-- cart-popup-end -->
