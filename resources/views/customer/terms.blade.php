@extends('customer.layout.index')

@section('title', 'Terms & Condition')

@section('body_class', 'terms-page')

@section('css_style')
    <link rel="stylesheet" href="{{ asset('customer/custom/css/terms.css') }}" />
@endsection

@section('container')
    <div class="terms-banner">
        <div class="container">
            <h2 class="text-white text-center">terms & condition</h2>
        </div>
    </div>
    <section class="section-terms container pt-5 mt-5">
        {!! $frontend_setting->terms !!}
    </section>
    @include('customer.components.follow_intagram')
@endsection
