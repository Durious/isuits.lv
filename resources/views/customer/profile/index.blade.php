@extends('customer.layout.index')

@section('title', 'Profile')

@section('body_class', 'profile-page')

@section('css_style')
    <link rel="stylesheet" href="{{ asset('customer/custom/css/profile.css') }}" />
@endsection

@section('container')
    <!-- Banner Starts -->
    <div class="profile-banner"></div>
    <!-- Banner End -->

    <!-- Profile Area Starts -->
    <section class="profile-area">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="profile-image">
                        @php
                            $user_photo = Auth::guard('customer')->user()->photo;
                            if ($user_photo) {
                                $photo_url = asset('storage/profile/' . $user_photo);
                            } else {
                                $photo_url = asset('customer/img/profile-page/profile.jpg');
                            }
                        @endphp
                        <div class="image" id="profile_photo">
                            <img src="{{ $photo_url }}" alt="user-profile-photo" />
                            <div class="overlay-photo-edit">
                                <i class="fa fa-pencil"></i>
                            </div>
                        </div>
                        <input type="file" class="d-none" id="profile_photo_input">
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-12">
                    <div class="profile-title">
                        <h2>{{_t('my_account')}}</h2>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-2 pr-0">
                    <div class="profile-tab">
                        <div class="tab-accordion">
                            <div class="tab">
                                <ul>
                                    <li class="tab-one active">
                                        <a href="#tab-one"><h6><i class="fa fa-user-o"></i> {{_t('profile')}}</h6></a>
                                    </li>
                                    <li class="tab-second">
                                        <a href="#tab-second"><h6><i class="fa fa-key"></i> {{_t('password')}}</h6></a>
                                    </li>
                                    <li class="tab-three">
                                        <a href="#tab-three"><h6><i class="fa fa-map"></i> {{_t('address')}}</h6></a>
                                    </li>
                                    <li class="tab-four">
                                        <a href="#tab-four"><h6><i class="fa fa-ticket"></i> {{_t('measure', 1)}}</h6></a>
                                    </li>
                                    <li class="tab-five">
                                        <a href="#tab-five"><h6><i class="fa fa-shopping-cart"></i> {{_t('order', 1)}}</h6></a>
                                    </li>
                                    <li class="tab-six">
                                        <a href="#tab-six"><h6><i class="fa fa-heart-o"></i> {{_t('saved_products')}}</h6></a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-10 pl-0">
                    <div class="tab-content">
                        <div class="tab-one-content lost active">
                            @include('customer.profile.profile')
                        </div>
                        <div class="tab-second-content lost">
                            @include('customer.profile.change_password')
                        </div>
                        <div class="tab-three-content lost">
                            <div class="contact-bg">
                                <div class="form-border">
                                    <div class="form-title">
                                        <h4>{{_t('address')}}</h4>
                                    </div>
                                    <div class="user-address-list">
                                        <h6>{{_t('shipping_address')}}</h6>
                                        <div id="shipping-list">
                                            @include('customer.profile.shipping_list')
                                        </div>
                                        <h6 class="mt-5">{{_t('billing_address')}}</h6>
                                        <div id="billing-list">
                                            @include('customer.profile.billing_list')
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="tab-four-content lost">
                            <div class="contact-bg2">
                                <div class="form-border">
                                    <div class="form-title">
                                        <h4>{{_t('my_measures')}}</h4>
                                    </div>
                                    <div id="customer-measure-container">
                                        @include('customer.profile.measures')
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="tab-five-content lost">
                            <div class="contact-bg2">
                                <div class="form-border p-5">
                                    <ul class="nav nav-pills">
                                        <li class="nav-item">
                                          <a class="nav-link font-weight-bold active" data-toggle="tab" href="#product_orders">{{_t('product_orders')}}</a>
                                        </li>
                                        <li class="nav-item">
                                          <a class="nav-link font-weight-bold" data-toggle="tab" href="#service_orders">{{_t('service_orders')}}</a>
                                        </li>
                                      </ul>
                                      <div class="tab-content">
                                        <div class="tab-pane container py-5 px-0 active h-scroll-table" id="product_orders">
                                            @include('customer.profile.product_orders')
                                        </div>
                                        <div class="tab-pane container py-5 px-0 h-scroll-table" id="service_orders">
                                            @include('customer.profile.service_orders')
                                        </div>
                                      </div>
                                </div>
                            </div>
                        </div>
                        <div class="tab-six-content lost">
                            <div class="contact-bg2">
                                <div style='border: 1px solid black'>
                                    <div style='overflow: scroll; padding: 0; margin: 40px 20px'>
                                        <div class="form-title">
                                            <h4>{{_t('my_favorites')}}</h4>
                                        </div>
                                        <table class="profile-table">
                                            <thead>
                                                <tr>
                                                    <th>{{_t('photo')}}</th>
                                                    <th>{{_t('name')}}</th>
                                                    <th>{{_t('category')}}</th>
                                                    <th>{{_t('type')}}</th>
                                                    <th class="text-right">{{_t('price')}}</th>
                                                    <th class="text-right">{{_t('action')}}</th>
                                                </tr>
                                            </thead>
                                            <tbody id="customer-favorites-container">
                                                @include('customer.profile.favorites')
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Profile Area End -->

    @include('customer.components.follow_intagram')
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
    <script src="{{ asset('customer/custom/js/profile.js') }}"></script>
    <script src="{{ asset('customer/custom/js/shipping-address.js') }}"></script>
    <script src="{{ asset('customer/custom/js/billing-address.js') }}"></script>
    <script src="{{ asset('customer/custom/js/measure-modal.js') }}"></script>
    <script src="{{ asset('customer/custom/js/mirrorsize-modal.js') }}"></script>
    <script>
        var hash = window.location.hash.substr(1);
        if(hash) {
            $('.tab-accordion li').removeClass('active');
            $('.tab-content .lost').removeClass('active');
            $(`.tab-accordion li.${hash}`).addClass('active');
            $(`.tab-content .lost.${hash}-content`).addClass('active');
        }
        function removeFavorite(product_id) {
            $.ajax({
                url: "/products/favorite/" + product_id,
                method: 'DELETE',
                data: {
                    product_id,
                },
                success: function(response) {
                    toastr.success('Remove favorite successfully.');
                    $('#customer-favorites-container').html(response);
                }
            });
        }
    </script>
@endsection
