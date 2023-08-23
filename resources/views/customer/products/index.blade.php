@extends('customer.layout.index')

@section('title', 'Products')

@section('body_class', 'shop-page')

@section('css_style')
    <link rel="stylesheet" href="{{ asset('customer/css/slick.css') }}" />
@endsection

@section('container')
    <!-- Banner Starts -->
    <section class="shop-banner section-padding-bottom2">
        <div class="container-fluid pr-0">
            <div class="row">
                <div class="col-lg-4 align-self-center">
                    <div class="shop-title">
                        <h1>{{_t('shop_by_category')}}</h1>
                    </div>
                </div>
                <div class="col-lg-8">
                    <div class="shop-right">
                        <div class="fashion-shop-slider">
                            @foreach ($categories as $item)
                                <div class="single-slide">
                                    <div class="slide-image">
                                        <div class="image-bg"
                                            style="background-image: url({{ asset('/storage/category/' . $item->photo) }})">
                                            <div class="hover-state">
                                                <a
                                                    href="{{ route('customer.products', ['type' => $type, 'category' => $item->id]) }}">{{_t('select')}}</a>
                                                <span>{{ $item->name }}</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            @endforeach
                        </div>

                        <div class="controler-wrapper">
                            <div class="active-controler">1</div>
                            <div class="progressbar">
                                <span class="home-slider-progress"></span>
                                <span class="home-slider-progress-active"></span>
                                <span class="devider">/</span>
                            </div>
                            <div class="total-controler">&nbsp;&nbsp;{{ count($categories) }}</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Banner End -->

    <!-- Shop Content Starts -->
    <section class="shop-content">
        <div class="container">
            <div class="row">
                <div class="col-lg-3">
                    @include('customer.products.product-search-panel')
                </div>

                <div class="col-lg-9">
                    <div class="shop-items-top d-flex justify-content-between">
                        <div><span>{{ count($products) }} {{_t('item', count($products))}}</span></div>
                        <div class="dropdown">
                            <button class="drop-btn dropdown-toggle" type="button" id="dropdownMenuButton"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                {{_t('sort_by')}}
                            </button>
                            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownMenuButton">
                                <a class="dropdown-item"
                                    href="{{ route(
                                        'customer.products',
                                        [
                                            'type' => $type,
                                            'sort' => 'name',
                                            'sort_dir' => $sort === 'name' ? 'desc' : 'asc',
                                        ] + request()->except('sort', 'page'),
                                    ) }}">
                                    {{_t('title')}}
                                </a>
                                <a class="dropdown-item"
                                    href="{{ route(
                                        'customer.products',
                                        [
                                            'type' => $type,
                                            'sort' => 'price',
                                            'sort_dir' => $sort === 'price' ? 'desc' : 'asc',
                                        ] + request()->except('sort', 'page'),
                                    ) }}">
                                    {{_t('price')}}
                                </a>
                            </div>
                        </div>
                    </div>

                    <div class="shop-items">
                        <div class="row">
                            @include('customer.components.product_list', ['clothes_item_classname' => 'col-lg-4 col-md-6', 'clothes_list' => $products])
                        </div>
                        {{ $products->links('customer.components.pagination') }}
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Shop Content End -->

    @include('customer.components.follow_intagram')
@endsection
