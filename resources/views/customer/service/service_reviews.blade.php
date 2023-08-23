<div class="service-reviews" style='position: relative'>
    <div class="owl-carousel">
        @foreach ($service->service_reviews as $item)
            <div class="d-flex">
                @php
                    $user_photo = $item->customer->photo;
                    if ($user_photo) {
                        $photo_url = asset('storage/profile/' . $user_photo);
                    } else {
                        $photo_url = asset('customer/img/profile-page/profile.jpg');
                    }
                @endphp
                <img src="{{ $photo_url }}" class="user-photo" alt="user-photo" />
                <div class="pl-4">
                    <h5 class="review-title">{{ $item->title }}</h5>
                    <div class="review-ratings">
                        <span
                            class="badge badge-warning mr-3">{{ number_format((float) $item->rate, 1, '.', '') }}</span>
                        @php
                            $full_stars = floor($item->rate);
                            $half_stars = round($item->rate - $full_stars, 1) >= 0.5 ? 1 : 0;
                        @endphp
                        @for ($i = 0; $i < $full_stars; $i++)
                            <i class="fa fa-star"></i>
                        @endfor
                        @if ($half_stars)
                            <i class="fa fa-star-half-o"></i>
                        @endif
                        @for ($i = 0; $i < 5 - $full_stars - $half_stars; $i++)
                            <i class="fa fa-star diff-star"></i>
                        @endfor
                    </div>
                    <div class="review-content">
                        &quot;{{ $item->content }}&quot;
                    </div>
                    <div class="d-flex justify-content-between mt-3">
                        <span class="review-customer">-By {{ $item->customer->name }}</span>
                        <span class="review-date">{{ get_time_ago(strtotime($item->created_at)) }}</span>
                    </div>
                </div>
            </div>
        @endforeach
    </div>
    @if(Auth::guard('customer')->check() && !$service->service_reviews()->where('customer_id', Auth::guard('customer')->id())->first())
        <div class="d-flex align-items-center mt-3">
            @if(count($service->service_reviews) === 0)
                <div>No reviews</div>
            @endif
            <button class="common-button ml-auto" id="btn-write-review">Write Review</button>
        </div>
    @endif

    @if(count($service->service_reviews) > 0)
        <i class="fa fa-long-arrow-left"
           style='bottom: 0px; left: 0px; position: absolute; font-size: 25px; color: #857d78; z-index: 1000'></i>
        <i class="fa fa-long-arrow-right"
           style='bottom: 0px; right: 0px; position: absolute; font-size: 25px; color: #857d78; z-index: 1000'></i>
    @endif
</div>
