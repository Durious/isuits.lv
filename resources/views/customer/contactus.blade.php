@extends('customer.layout.index')

@section('title', 'Contact Us')

@section('body_class', 'contact-us-page')

@section('container')
<!-- Contact Form Starts -->
<section class="contact-form-area common-form common-input2">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="contact-title section-padding-top2">
                    <h2>{{_t('contact_us')}}</h2>
                    <h3>Hello. Let’s get in touch</h3>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-7">
                <div class="contact-bg">
                    <form action="#">
                        <h6>{{_t('full_name')}}</h6>
                        <input type="text" placeholder="e.i Annastasia Alatore" value="{{$account->name}}" readonly />

                        <h6>{{_t('email')}} {{_t('address')}}</h6>
                        <input type="email" placeholder="e.i User@gmail.com" value="{{ $account->email }}" readonly />

                        <h6>{{_t('message')}}</h6>
                        <textarea cols="30" rows="10"></textarea>

                        <button type="submit" class="template-btn2 off1">
                            {{_t('add')}} {{_t('your')}} {{_t('comment')}} <span>&rharu;</span>
                        </button>
                    </form>
                </div>
            </div>
            <div class="col-lg-5">
                <div class="contact-bg">
                    <form>
                    <h6>{{_t('address')}}</h6>
                    <input type="text" placeholder="" value="{{ $account->address }}" readonly />

                    <h6>Phones</h6>
                    <input type="text" placeholder="" value="{{ $account->phone}}" readonly />

                    <h6>Working Times</h6>
                    <input type="text" placeholder="" value="{{ $timezone }} 8:00 - 18:00" readonly />
                    </form>
                    
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Contact Form End -->

@include('customer.components.follow_intagram')
@endsection