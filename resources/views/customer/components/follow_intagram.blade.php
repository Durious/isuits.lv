@if($instagram_list)
    <!-- Instagram Starts -->
    <section class="instagram-area section-padding-top3">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-title text-center">
                        <h2>{{_t('follow_our_instagram')}}</h2>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12 px-0">
                    <div class="instagram-slider owl-carousel">
                        @foreach($instagram_list as $item)
                            <div
                                class="single-slide slide-1 div-lazy-loader"
                                data-src="{{asset('/storage/frontend/'.$item->image)}}">
                            </div>
                        @endforeach
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Instagram End -->
@endif
