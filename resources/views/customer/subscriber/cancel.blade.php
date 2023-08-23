@extends('customer.layout.index')

@section('title', 'Unsubscribe')

@php
$story = json_decode($frontend_setting->story ?? 'null');
$about_service = json_decode($frontend_setting->about_service ?? 'null');
@endphp

@section('body_class', 'about-page')

@section('css_style')
<link rel="stylesheet" href="{{asset('customer/css/slick.css')}}" />
@endsection

@section('container')
    <section class="template-breadcrumb">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="banner-title">
                        <h1>Unsubscribe</h1>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <div style='text-align: center; margin-top: 30px'>
        <div class="col-lg-6" style='margin: auto'>
            <div class="footer-widget widget">
                <h3>We are sad for your unsubscribing.</h3>
                <form action="{{route('subscriber.unsubscribe')}}" class="mt-4">
                    <input type="email" placeholder="Your Email Address" name="email" id="email"
                           onfocus="this.placeholder = ''" onblur="this.placeholder = 'Your Email Address'"
                           required />
                    <button type="submit"><span>&rharu;</span></button>
                </form>
            </div>
        </div>
    </div>
@endsection
