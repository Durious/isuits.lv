@extends('customer.layout.index')

@section('title', 'About Us')

@php
$story = json_decode($frontend_setting->story ?? 'null');
$about_service = json_decode($frontend_setting->about_service ?? 'null');
@endphp

@section('body_class', 'about-page')

@section('css_style')
<link rel="stylesheet" href="{{asset('customer/css/slick.css')}}" />
@endsection

@section('container')
    <!-- Banner Starts -->
    <section class="template-breadcrumb">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="banner-title">
                        <h1>{{_t('about_us')}}</h1>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Banner End -->

    <!-- Story Starts -->
    <section class="about-story">
        <div class="container">
            <div class="row">
                <div class="col-lg-7">
                    <div class="story-content section-padding-top2">
                        <div class="section-title">
                            <h2>{{_t('our_story')}}</h2>
                        </div>
                        <p class="mt-4">
                            {!! nl2br($story->description ?? '') !!}
                        </p>
                    </div>
                </div>
                <div class="col-lg-5">
                    <div class="story-image">
                        @if($story)
                            <div class="image-bg" style="background-image: url({{asset('/storage/frontend/'.$story->image)}})"></div>
                        @else
                            <div class="image-bg"></div>
                        @endif
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Story End -->

    <!-- Service Starts -->
    <section class="about-service section-padding-top">
        <div class="container">
            <div class="row">
                <div class="col-lg-5 align-self-center">
                    <div class="section-title">
                        <h2>{{_t('our_service_content')}}</h2>
                    </div>
                    <p>
                        {!! nl2br($about_service->description ?? '') !!}
                    </p>
                    <a href="#" class="template-btn3">{{_t('read_more')}} <span>&#8640;</span></a>
                </div>
                <div class="col-lg-5 offset-lg-2">
                    @if($about_service && $about_service->list)
                        @foreach($about_service->list as $item)
                        <div class="single-item d-flex my-5">
                            <div class="service-icon align-self-center">
                                <img src="{{asset('/storage/frontend/'.$item->icon)}}" alt="" style="min-width: 30px;"/>
                            </div>
                            <div class="service-content">
                                <h4>{{$item->title}}</h4>
                                <p>
                                    {{$item->description}}
                                </p>
                            </div>
                        </div>
                        @endforeach
                    @endif
                </div>
            </div>
        </div>
    </section>
    <!-- Service End -->

    @include('customer.components.follow_intagram')
@endsection
