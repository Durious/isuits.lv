@foreach ($clothes_list as $clothes_item)
    <div class="{{$clothes_item_classname}}">
        <div class="single-cart-item">
            <div class="single-cart-image">
                <img class="image-item-01 item-active div-lazy-loader"
                     data-src="{{ asset('/storage/product/' . $clothes_item->main_photo) }}"
                     alt="" />
                <img class="image-item-02 div-lazy-loader"
                     data-src="{{ asset('/storage/product/' . ($clothes_item->sub_photos ? explode(',', $clothes_item->sub_photos)[0] : $clothes_item->main_photo)) }}"
                     alt="" />
                <div class="image-dots">
                    <div class="dot-01"></div>
                    <div class="dot-02 active"></div>
                </div>
            </div>
            <span class="love-icon">
                @if($clothes_item->likedBy->contains(Auth::guard('customer')->user()))
                    <i class="fa fa-heart text-primary"></i>
                @else
                    <i class="fa fa-heart"></i>
                @endif
            </span>

            <div class="single-cart-content">
                <div class="cart-content-left">
                    <ul class="cart-rating">
                        @php
                            $product = App\Models\Product::find($clothes_item->id);
                            $reviewCnt = $product->product_reviews()->count();
                            $averageRate = $product->averageRate();
                        @endphp
                        @for($i = 0; $i < $averageRate; $i++)
                            <li><i class="fa fa-star"></i></li>
                        @endfor
                        @for($i = 0; $i < 5- $averageRate; $i++)
                            <li class="diff-color"><i class="fa fa-star"></i></li>
                        @endfor

                        <span style='margin-left: 20px'>{{ $reviewCnt . ($reviewCnt > 1 ? " reviews" : " review") }}</span>
                    </ul>
                    <h5>{{ $clothes_item->name }}</h5>
                </div>

                <div class="cart-content-right">
                    <span class="current-price">€{{ number_format($clothes_item->price, 2) }}</span>
                </div>
            </div>

            <div class="single-cart-button">
                <a href="javascript:void(0);" class="cart-button"
                   onclick="addToCart({{ $clothes_item->id }}, event)">{{_t('add_to_cart')}}</a>
                <a href="{{ route('customer.products.details', ['product' => $clothes_item->id]) }}"
                   class="compare-button">{{_t('product_details')}}</a>
            </div>
        </div>
    </div>
@endforeach
