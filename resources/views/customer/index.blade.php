@extends('customer.layout.index')

@section('title', 'Welcome')

@php
    $slides = json_decode($frontend_setting->slides ?? 'null');
    $limiteds = json_decode($frontend_setting->limited ?? 'null');
    $discount = json_decode($frontend_setting->discount ?? 'null');
    $embrace = json_decode($frontend_setting->embrace ?? 'null');
    $testimonial = json_decode($frontend_setting->testimonial ?? 'null');
    $service = json_decode($frontend_setting->service ?? 'null');
    $galleries = json_decode($frontend_setting->galleries ?? 'null');
    $faq = json_decode($frontend_setting->faq ?? 'null');
@endphp

@section('css_style')
    <link rel="stylesheet" href="{{ asset('customer/custom/css/profile.css') }}" />
    <style>
        .video-area:after {
            background-image: url({{$embrace ? asset('storage/frontend/'.$embrace->image) : '/customer/img/home-1/video/video-bg.png'}});
        }
    </style>
@endsection

@section('container')
    @if($slides)
        <!-- Banner Starts -->
        <section class="banner-area">
            <div class="slider-area owl-carousel">
                @foreach($slides as $key => $slide)
                    <div class="single-slide">
                        <div class="container-fluid">
                            <div class="row">
                                <div class="col-lg-5">
                                    <div class="banner-left">
                                        <a href="{{$slide->url??"#"}}">
                                        <div
                                            class="banner-image div-lazy-loader"
                                            data-src="{{url('/storage/frontend/'.$slide->main_image)}}"
                                        >
                                            <span>{{str_pad($key + 1, 2, "0", STR_PAD_LEFT)}}</span>
                                        </div>
                                        </a>
                                        <div class="banner-icon">
                                            <ul>
                                                <li>
                                                    <a href="#"><i class="fa fa-facebook-official"></i></a>
                                                </li>
                                                <li>
                                                    <a href="#"><i class="fa fa-instagram"></i></a>
                                                </li>
                                                <li>
                                                    <a href="#"><i class="fa fa-twitter"></i></a>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6 offset-lg-1 align-self-center">
                                    <div class="banner-right">
                                        <div class="banner-right-top d-md-flex justify-content-between">
                                            <div class="banner-content align-self-end">
                                                <h2>{{_t($slide->main_title)}}</h2>
                                                <p class="different">{{_t($slide->sub_title)}}</p>
                                            </div>
                                            <div class="right-img div-lazy-loader"
                                                 data-src="{{url('/storage/frontend/'.$slide->sub_image)}}"></div>
                                        </div>
                                        <div class="banner-middle-content">
                                            <p>
                                                {{_t($slide->description)}}
                                            </p>
                                            <span>R</span>
                                        </div>
                                        <div class="banner-btn">
                                            <a href="{{ route('customer.products', ['type' => 'women']) }}"
                                               class="template-btn mr-4">{{_t('shop_women')}}</a>
                                            <a href="{{ route('customer.products', ['type' => 'men']) }}"
                                               class="template-btn tb-2 mt-sm-3">{{_t('shop_men')}}</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                @endforeach
            </div>
        </section>
        <!-- Banner End -->
    @endif

    @if($limiteds)
        <!-- Collection Starts -->
        <!-- <section class="collection-area section-padding-both2"> -->
    
            <div class="floating-icon" id="service_info_item">
                @if(Auth::guard('customer')->check())
                    <div class="floating-icon__is floating-icon-info floating-icon-1">
                        <span class="ti-shopping-cart"></span>
                    </div>
                    <!--floating-icon-is-->
                    <div class="floating-icon__is floating-icon-message floating-icon-2">
                        <span class="ti-comment-alt"></span>
                    </div>
                    <!--floating-icon-is-->
                @else
                    <div class="floating-icon__is floating-icon-location floating-icon-3">
                        <span class="ti-world"></span>
                    </div>
                    <!--floating-icon-is-->
                @endif
            </div>
            <!--floating-icon-->
            <section class="banner-area">
                <div class="slider-area owl-carousel">
                @foreach($limiteds as $limited)
                <div class="single-slide">
                    <div class="container-fluid">
                    <div class="row">
                        <div class="col-lg-7 align-self-center">
                            <div class="collection-content">
                                <div class="section-title">
                                    <h2 class="collection-h2">{{_t('Limited')}} {{_t('Edition')}} <br />{{_t('Collection')}}</h2>
                                    <p class="different">{{_t($limited->name)}}</p>
                                </div>
                                <p>
                                    {{_t($limited->description)}}
                                </p>
                                <div class="btn-margin-top">
                                    <a href="#" class="template-btn2">{{_t('Explore')}} {{_t('Collection')}} <span>&rharu;</span></a>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 offset-lg-1 fadeInRight">
                            <!-- <div class="collection-image"> -->
                            <div class="banner-right" style="width: 80%; height: 100vh;">
                                <a href="{{$limited->url}}">
                                    <!-- <div class="collection-bg div-lazy-loader" -->
                                    <div class="banner-image div-lazy-loader"
                                        data-src="{{asset('/storage/frontend/'.$limited->image)}}">
                                    </div>
                                </a>
                            </div>
                        <!-- </div> -->
                        </div>
                    </div>
                    </div>
                </div>
                    
                @endforeach
                </div>
            </section>
            
        <!-- </section> -->
        <!-- Collection End -->
    @endif

    <!-- Categories Starts -->
    <section class="categories-area">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-12 pr-0">
                    <div class="section-title text-center">
                        <h2>{{_t('Categories')}}</h2>
                    </div>
                    <div class="categories-item d-lg-flex justify-content-center">
                        @foreach ($categories as $category_item)
                            <div class="single-item fadeIn" data-wow-duration=".8s" data-wow-delay=".4s">
                                <div class="item-image div-lazy-loader"
                                     data-src="{{asset('/storage/category/'.$category_item->photo)}}"></div>
                                <div class="item-content">
                                    <h5>
                                        <a href="{{route('customer.products', ['type' => 'all', 'category' => $category_item->id])}}">
                                            {{_t('Shop')}} {{_t('for')}} {{_t($category_item->name)}}</a></h5>
                                    <a href={{route('customer.products', ['type' => 'all', 'category' => $category_item->id])}}">{{$category_item->description}}</a>
                            </div>
                        </div>
                        @endforeach
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Categories End -->

    @if($discount)
    <!-- Discount Starts -->
    <section class=" discount-area">
                                    <div class="container">
                                        <div class="row">
                                            <div class="col-lg-4 fadeInLeft">
                                                <div class="discount-content">
                                                    <div class="section-title">
                                                        <h2>{{_t($discount->title)}}</h2>
                                                    </div>
                                                    <p>{{$discount->description}}</p>
                                                    <div class="btn-margin-top mb-5 mb-lg-0">
                                                        <a href="#" class="template-btn2">{{_t('view')}} {{_t('items')}}
                                                            <span>&rharu;</span></a>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-7 offset-lg-1 fadeInRight">
                                                <div class="discount-image">
                                                    <div class="d-flex justify-content-between">
                                                        <div class="image-bg image-1 div-lazy-loader"
                                                             data-src="{{asset('/storage/frontend/'.$discount->image1)}}"></div>
                                                        <div class="image-bg image-2 div-lazy-loader"
                                                             data-src="{{asset('/storage/frontend/'.$discount->image2)}}"></div>
                                                        <div class="image-bg image-3 div-lazy-loader"
                                                             data-src="{{asset('/storage/frontend/'.$discount->image3)}}"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
    </section>
    <!-- Discount End -->
    @endif

    @if($embrace)
        <!-- Video Starts -->
        <section class="video-area section-padding-both">
            <div class="container">
                <div class="row">
                    <div class="col-lg-4 offset-lg-8">
                        <div class="video-content">
                            <div class="section-title">
                                <h2>{{_t('Embrace')}} {{_t('The')}} <br />{{_t('New')}} {{_t('Generation')}}</h2>
                            </div>
                            <p>{{$embrace->description}}</p>
                            <a href="#" class="template-btn3">{{_t('Check')}} {{_t('It')}} {{_t('Out')}} <span>&#8640;</span></a>
                        </div>
                    </div>
                    <div class="video-icon">
                        <a href="https://www.youtube.com/watch?v=bJ3RJlmGn6k" class="button-video"><i
                                class="fa fa-play"></i></a>
                    </div>
                </div>
            </div>
        </section>
        <!-- Video End -->
    @endif

    <!-- Picks Starts -->
    <section class="picks-area section-padding-both">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-title text-center">
                        <h2>{{_t('Top')}} {{_t('Picks')}} {{_t('For')}} {{_t('You')}}</h2>
                    </div>
                </div>
            </div>

            <div class="row">
                @include('customer.components.product_list', ['clothes_item_classname' => 'col-lg-3 col-md-6', 'clothes_list' => $top_picks])
            </div>

            <div class="text-center">
                <a href="#" class="template-btn2">{{_t('view')}} {{_t('items')}} <span>&rharu;</span></a>
            </div>
        </div>
    </section>
    <!-- Picks End -->

    @if($testimonial)
        <!-- Client Starts -->
        <section class="client-area">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="section-title">
                            <h2>{{_t('Client')}} <br />{{_t('Testimonials')}}</h2>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-9 pl-0">
                        <div class="client-slider owl-carousel">
                            @foreach($testimonial as $item)
                                <div class="single-slide">
                                    <div class="slide-top d-flex">
                                        <div class="slide-image">
                                            <img class="div-lazy-loader"
                                                 data-src="{{asset('/storage/frontend/'.$item->photo)}}" alt="" />
                                        </div>
                                        <div class="slide-content align-self-center">
                                            <h4>{{$item->name}}</h4>
                                            <h6 class="diff-h6">{{$item->position}}</h6>
                                        </div>
                                    </div>
                                    <div class="slide-bottom">
                                        <p>{{$item->description}}</p>
                                    </div>
                                </div>
                            @endforeach
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Client End -->
    @endif

    @if($service)
        <!-- Services Starts -->
        <section class="services-area section-padding-both3">
            <div class="container">
                <div class="row">
                    @foreach($service as $item)
                        <div class="col-lg-3 col-md-6 fadeIn" data-wow-duration=".8s" data-wow-delay=".2s">
                            <div class="single-item mb-5 mb-lg-0">
                                <img class="div-lazy-loader" data-src="{{asset('/storage/frontend/'.$item->icon)}}"
                                     alt="" />
                                <h5 class="my-4">{{_t($item->title)}}</h5>
                                <p>{{$item->description}}</p>
                            </div>
                        </div>
                    @endforeach
                </div>
            </div>
        </section>
        <!-- Services End -->
    @endif

    @if($galleries)
        <!-- Gallery Starts  -->
        <section class="gallery-area section-padding-bottom">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="section-title text-center">
                            <h2>{{_t('our_gallery')}}</h2>
                        </div>
                    </div>
                </div>
                <div class="gallery-slider owl-carousel">
                    @foreach($galleries as $key => $gallery)
                        <div class="single-item text-center">
                            <div class="item-image">
                                <img class="div-lazy-loader" data-src="{{asset('/storage/frontend/'.$gallery->images[0])}}"
                                    alt="" />
                            </div>
                            <div class="item-content text-center">
                                <h6>{{ $gallery->sub_title }}</h6>
                                <h5>{{ $gallery->main_title }}</h5>
                            </div>
                            @php
                            $images = $gallery->images;
                            @endphp
                            <div class="hover-state">
                                @foreach($images as $k => $image)
                                <a href="{{asset('/storage/frontend/'.$image)}}">
                                    <i class="fa fa-arrows-alt"></i>
                                </a>
                                @endforeach
                            </div>
                        </div>
                    @endforeach
                </div>
            </div>
        </section>
        <!-- Gallery End -->
    @endif

    @if($subscribe)
        <!-- Newsletter Starts -->
        <div
            class="newsletter-area section-padding-both div-lazy-loader"
            data-src="{{asset('/storage/frontend/'.$subscribe->image)}}">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6">
                        <div class="section-title">
                            <h2>subscribe to our newsletter</h2>
                        </div>
                        <p>{{$subscribe->description}}</p>
                        <form action="{{route('subscriber.store')}}">
                            <input type="email" name="email" class="common-input"
                                   placeholder="Enter Your Email Address Here"
                                   onfocus="this.placeholder = ''"
                                   onblur="this.placeholder = 'Enter Your Email Address Here'"
                                   required />
                            <button type="submit"><span>&rharu;</span></button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!-- Newsletter End -->
    @endif

    @if($faq)
        <!-- FAQ Starts -->
        <section class="accordion-area pt-5 mt-5" id="section-faq">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="section-title text-center">
                            <h2>Frequently Asked Question</h2>
                        </div>
                    </div>
                </div>
                <div class="faq-section">
                    <div class="row">
                        <div class="col-lg-8 mx-auto">
                            <div class="accordion-wrapper" id="accordionExample">
                                @foreach($faq as $i => $item)
                                    <div class="card">
                                        <div class="card-header" id="headingOne">
                                            <p class="mb-0">
                                                <a
                                                    href="#"
                                                    role="button"
                                                    data-toggle="collapse"
                                                    data-target="#collapse_{{$i}}"
                                                    aria-expanded="false"
                                                    aria-controls="collapse_{{$i}}"
                                                >
                                                    {{$item->title}}
                                                </a>
                                            </p>
                                        </div>
                                        <div
                                            id="collapse_{{$i}}"
                                            class="collapse"
                                            aria-labelledby="heading_{{$i}}"
                                            data-parent="#accordionExample"
                                        >
                                            <div class="card-body">
                                                {{$item->description}}
                                            </div>
                                        </div>
                                    </div>
                                @endforeach
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- FAQ End -->
    @endif

    @include('customer.components.follow_intagram')
@endsection

@section('js_script')
    {{--    <script src="//code.jivosite.com/widget/BNuCEYWjbW" async></script>--}}
    <!--Start of Tawk.to Script-->
    <script type="text/javascript">
        var Tawk_API = Tawk_API || {}, Tawk_LoadStart = new Date();
        (function() {
            var s1 = document.createElement('script'), s0 = document.getElementsByTagName('script')[0];
            s1.async = true;
            s1.src = 'https://embed.tawk.to/64665c6cad80445890edc095/1h0nti2s7';
            s1.charset = 'UTF-8';
            s1.setAttribute('crossorigin', '*');
            s0.parentNode.insertBefore(s1, s0);
        })();
    </script>
    <!--End of Tawk.to Script-->
@endsection

