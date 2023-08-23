<div class="product-reviews" style='position: relative'>
    <div class="slider-area owl-carousel product-comments">
        @foreach ($product->product_comments as $item)
        <div class="single-slide">
            <div class="d-flex">
                <div class="pl-4">
                    <div class="review-content comment-content">
                        &quot;{{ $item->comment }}&quot;
                    </div>
                    <div class="d-flex justify-content-between mt-3">
                        <span class="review-customer">-By {{ $item->customer->name }}</span>
                        <span class="review-date" style="margin-left: 10px;">{{ get_time_ago(strtotime($item->created_at)) }}</span>
                    </div>
                </div>
            </div>
        </div>
        @endforeach
    </div>
    @if(Auth::guard('customer')->check() && !$product->product_comments()->where('customer_id', Auth::guard('customer')->id())->first())
    <div class="d-flex align-items-center mt-3">
        @if(count($product->product_comments) === 0)
        <div>No Comments</div>
        @endif
        <button class="common-button ml-auto" id="btn-write-comment">Write Comment</button>
    </div>
    @endif
</div>