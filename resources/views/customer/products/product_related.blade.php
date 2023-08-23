<!-- Related Section Starts -->
<section class="related-section section-padding-top3">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <h2>{{_t('related')}}</h2>
            </div>
        </div>
        <div class="row mt-5">
            <div class="col-lg-9">
                <div class="related-slider owl-carousel">
                    @include('customer.components.product_list', ['clothes_item_classname' => 'single-slide', 'clothes_list' => $related])
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Related Section End -->
