@extends('customer.layout.index')

@section('title', 'Products')

@section('body_class', 'cart-page')

@section('css_style')
<link rel="stylesheet" href="{{ asset('customer/custom/css/product_details.css') }}" />
@endsection

@section('container')
<!-- Banner Starts -->
<section class="cart-banner">
    <div class="container">
        <div class="row" id="product_description">
            <div class="col-lg-3 align-self-end order-2 order-lg-1">
                <div class="cart-banner-left">
                    <div class="left-title mb-5">
                        <h3>{{ $product->name }}</h3>
                        <h4>{{ $product->category->name }} / {{ $product->type }}</h4>
                    </div>
                    <div class="price mb-5">
                        <h2>€{{ number_format($product->price, 2) }}</h2>
                    </div>
                    <div class="quantity mb-5">
                        <h4>{{_t('quantity')}}</h4>
                        <ul>
                            <li>
                                <span id="btn_quantity_minus"><i class="ti-minus"></i></span>
                            </li>
                            <li><span id="product_quantity">1</span></li>
                            <li>
                                <span id="btn_quantity_plus"><i class="ti-plus"></i></span>
                            </li>
                        </ul>
                    </div>
                    <div class="left-image d-flex small-slider">
                        <div class="image mr-4" style="background-image: url({{ asset('/storage/product/' . $product->main_photo) }})">
                            <div class="hover-state">
                                <a href="{{ asset('/storage/product/' . $product->main_photo) }}"><i class="fa fa-search"></i></a>
                            </div>
                        </div>
                        @foreach ($product->sub_photos as $item)
                        <div class="image mr-4" style="background-image: url({{ asset('/storage/product/' . $item) }})">
                            <div class="hover-state">
                                <a href="{{ asset('/storage/product/' . $item) }}"><i class="fa fa-search"></i></a>
                            </div>
                        </div>
                        @endforeach
                    </div>
                </div>
            </div>
            <div class="col-lg-4 order-1 order-lg-2">
                <div class="banner-image big-slider">
                    <div class="cart-page-banner-bg" id="customization_main_photo">
                        <img src="{{ asset('/storage/product/' . $product->main_photo) }}" alt="product-main-photo" />
                    </div>
                    <div class="cart-page-banner-bg" id="customization_preview" style="display: none">
                        <img src="{{ asset('/storage/product/' . $product->main_photo) }}" alt="product-main-photo" />
                    </div>
                </div>
            </div>
            <div class="col-lg-5 order-3">
                <div class="banner-right mb-5">
                    <div class="tab-accordion picks-tab mt-70">
                        <div class="tab">
                            <ul>
                                <li class="tab-one active">
                                    <h6>{{_t('details')}}</h6>
                                </li>
                                <li class="tab-second">
                                    <h6>{{_t('size')}}</h6>
                                </li>
                                <li class="tab-third" style="min-width: 190px;">
                                    <h6>{{_t('comments')}}/{{_t('reviews')}}</h6>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="tab-content">
                        <div class="tab-one-content lost active">
                            <div class="right-top">
                                <h6>{{ $product->name }}</h6>
                                <p class="mt-4 mb-5">
                                    {!! nl2br($product->description) !!}
                                </p>
                            </div>                            
                        </div>
                        <div class="tab-second-content lost">
                            <table>
                                <thead>
                                    <tr>
                                        <th>{{_t('size')}}</th>
                                        <th>{{_t('small')}}</th>
                                        <th>{{_t('medium')}}</th>
                                        <th>{{_t('large')}}</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>To fit burst</td>
                                        <td>{{$product->small_burst}} cm</td>
                                        <td>{{$product->medium_burst}} cm</td>
                                        <td>{{$product->large_burst}} cm</td>
                                    </tr>
                                    <tr>
                                        <td>To fit waist</td>                                        
                                        <td>{{$product->small_waist}} cm</td>
                                        <td>{{$product->medium_waist}} cm</td>
                                        <td>{{$product->large_waist}} cm</td>
                                    </tr>
                                    <tr>
                                        <td>To fit hips</td>                                        
                                        <td>{{$product->small_hips}} cm</td>
                                        <td>{{$product->medium_hips}} cm</td>
                                        <td>{{$product->large_hips}} cm</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="tab-third-content lost">
                            @include('customer.products.product_comments')
                            @if(Auth::guard('customer')->check() && !$product->product_comments()->where('customer_id', Auth::guard('customer')->id())->first())
                            <div class="product-comment-form d-none">
                                <form action="{{route('customer.products.save_comment')}}" method="POST">
                                    @csrf
                                    <input type="hidden" name="product_id" value="{{$product->id}}" />                                    
                                    <div class="mb-3">
                                        <textarea name="comment" rows="4" placeholder="{{_t('Comment')}}"></textarea>
                                    </div>
                                    <div>
                                        <button type="button" class="common-button" id="btn-cancel-comment">Cancel</button>
                                        <button type="submit" class="common-button ml-3">Submit</button>
                                    </div>
                                </form>
                            </div>
                            @endif

                            @include('customer.products.product_reviews')
                            @if(Auth::guard('customer')->check() && !$product->product_reviews()->where('customer_id', Auth::guard('customer')->id())->first())
                            <div class="product-review-form d-none">
                                <form action="{{route('customer.products.save_review')}}" method="POST">
                                    @csrf
                                    <div class="d-flex align-items-center mb-3">
                                        <h4 class="text-capital mr-3 mb-0">rate us</h4>
                                        <span id="rate" data-stars="0"></span>
                                    </div>
                                    <input type="hidden" name="product_id" value="{{$product->id}}" />
                                    <div class="mb-3">
                                        <input type="text" min="0" max="5" name="title" placeholder="{{_t('title')}}" />
                                    </div>
                                    <div class="mb-3">
                                        <textarea name="content" rows="4" placeholder="{{_t('Content')}}"></textarea>
                                    </div>
                                    <div>
                                        <button type="button" class="common-button" id="btn-cancel-review">Cancel</button>
                                        <button type="submit" class="common-button ml-3">Submit</button>
                                    </div>
                                </form>
                            </div>
                            @endif
                        </div>
                    </div>
                    <div>
                        <div class="right-button mt-40 mb-5">
                            @if (count((array) $tag_list))
                            <a href="#" class="template-btn2 on2" id="btn_product_customize">
                                {{_t('customize_product')}}<span>&rharu;</span>
                            </a>
                            @endif
                            <div class="customized-alert" style="display: none;">
                                <div class="d-flex justify-content-between align-items-center">
                                    {{_t('customized_success')}}
                                    <button id="btn_cancel_customize">{{_t('cancel')}}</button>
                                </div>
                            </div>
                            <a href="#" class="template-btn2 on1 mt-3" id="btn_add_to_cart">
                                {{_t('add_to_cart')}} <span>&rharu;</span>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row" style="display: none;" id="customization_wizard">
            <div class="col-lg-5">
                <div id="product-main-photo-image" class="custom-field-main-photo">
                    <img src="{{ asset('/storage/product/' . $product->main_photo) }}" alt="product-main-photo" />
                </div>
                <div id="customization-preview-image" class="custom-field-main-photo d-none">
                    <div id="customfield-preview-container" class="customfield-preview-container">
                        <img id="product-customization-preview" alt="product-customization-preview" />
                    </div>
                </div>
            </div>
            <div class="col-lg-6 offset-lg-1">
                <form id="customization_form" class="mt-5" style="margin-top: 20% !important;">
                    <div class="customization-wizard">
                        @php
                        $index = 0;
                        @endphp
                        <div class="step-title-list">
                            <a class="step-action" onclick="moveToPrevCustomizeStep()">{{_t('prev')}}</a>
                            @foreach ($tag_group_list as $key => $tag_group_item)
                            <a class="step-title" href="#" id="step_title_{{ $index++ }}" preview="{{ $tag_group_item['preview'] }}">
                                <span>{{ substr($tag_group_item['name'], 1) }}</span>
                            </a>
                            @endforeach
                            <a class="step-action" onclick="moveToNextCustomizeStep()">{{_t('next')}}</a>
                        </div>
                        @php
                        $index = 0;
                        @endphp
                        @foreach ($tag_group_list as $tag_group_item)
                        <div class="step-item" id="step_item_{{ $index++ }}">
                            @foreach ($tag_list[$tag_group_item['name']] as $custom_field)
                            <div class="custom-field {{ $custom_field->type }}">
                                <h4 class="text-center">{{ $custom_field->name }}</h4>
                                @php
                                $form_name = $custom_field->name;
                                $option_list = json_decode($custom_field->options);
                                @endphp
                                @if ($custom_field->type === 'Radio')
                                <div class="text-center">{{ $custom_field->description }}</div>
                                <div class="pt-3">
                                    @foreach ($option_list as $key => $option_item)
                                    <div class="radio-button">
                                        <input type="radio" {{ $key === 0 ? 'checked' : '' }} id="{{ $form_name . '_' . $option_item->name }}" title="{{ $option_item->description }}" name="{{ $form_name }}" value="{{ $option_item->name }}" />
                                        <label for="{{ $form_name . '_' . $option_item->name }}">{{ $option_item->name }}</label>
                                    </div>
                                    @endforeach
                                </div>
                                @elseif($custom_field->type === 'ImageRadio')
                                <div class="text-center">{{ $custom_field->description }}</div>
                                <div class="pt-3 row">
                                    @foreach ($option_list as $key => $option_item)
                                    <div class="col-6 col-sm-4 col-md-3 col-lg-4 col-xl-3">
                                        <div class="p-3">
                                            <div class="image-radio-button">
                                                <input type="radio" {{ $key === 0 ? 'checked' : '' }} id="{{ $form_name . '_' . $option_item->name }}" name="{{ $form_name }}" title="{{ $option_item->description }}" preview="{{ $option_item->preview ?? '' }}" onchange="drawPreview()" value="{{ $option_item->name }}" />
                                                <label for="{{ $form_name . '_' . $option_item->name }}">
                                                    <img src="{{ asset('/storage/customfield/' . $option_item->file) }}" />
                                                    <span>{{ $option_item->name }}</span>
                                                    <span class="check-mark">&#10003;</span>
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                    @endforeach
                                </div>
                                @elseif($custom_field->type === 'Text')
                                <div class="pt-3">
                                    <input type="text" class="custom-field-input" name="{{ $form_name }}" value="" placeholder="{{ $custom_field->description }}" />
                                </div>
                                @elseif($custom_field->type === 'Number')
                                <div class="pt-3">
                                    <input type="number" class="custom-field-input" name="{{ $form_name }}" value="" placeholder="{{ $custom_field->description }}" />
                                </div>
                                @elseif($custom_field->type === 'TextArea')
                                <div class="pt-3">
                                    <textarea class="custom-field-textarea" name="{{ $form_name }}" rows="4" placeholder="{{ $custom_field->description }}"></textarea>
                                </div>
                                @endif
                            </div>
                            @endforeach
                        </div>
                        @endforeach

                        <div class="d-flex bottom-action-list">
                            <a class="template-btn" id="btn_customize_prev_step" onclick="moveToPrevCustomizeStep()">
                                <span>&lharu;</span> {{_t('prev')}}
                            </a>
                            <a class="template-btn ml-auto" id="btn_customize_next_step" onclick="moveToNextCustomizeStep()">
                                {{_t('next')}} <span>&rharu;</span>
                            </a>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>
<!-- Banner End -->

@include('customer.products.product_related')
@endsection

@section('js_script')
<script>
    let customized = false;
    let step = 0;
    let maxStep = {{ $index - 1 }};
    let quantity = 1;
    let loginState = {{ Auth::guard('customer') -> guest() ? 'false' : 'true' }};
    let product_id = {{ $product -> id }};
</script>
<script src="{{ asset('customer/custom/js/product-details.js') }}"></script>
@endsection