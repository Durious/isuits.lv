@extends('customer.layout.index')

@section('title', 'Service')

@section('body_class', 'service-page')

@section('css_style')
    <link rel="stylesheet" href="{{ asset('customer/custom/css/service.css') }}" />
@endsection

@section('container')
    <div class="service-banner">
        <div class="container">
            <h2 class="text-white text-center">{{_t('service', 2)}}</h2>
        </div>
    </div>
    <section class="section-service-list">
        <div class="container py-5">
            <div class="row py-5">
                @foreach($services as $service_item)
                    <div class="col-sm-6 col-lg-4">
                        <a class="service-item my-4" href="/services/create/{{$service_item->id}}"
                           onclick="gotoOrderServicePage(event)">
                            <div class="service-photo">
                                <img src="{{asset('/storage/service/'.$service_item->photo)}}" />
                            </div>
                            <div class="service-text">
                                <h6 class="mt-2">{{$service_item->name}}</h6>
                                <div>{{$service_item->description}}</div>
                                <ul class="service-rating">
                                    @php
                                        $service = App\Models\Service::find($service_item->id);
                                        $reviewCnt = $service->service_reviews()->count();
                                        $averageRate = $service->averageRate();
                                    @endphp
                                    @for($i = 0; $i < $averageRate; $i++)
                                        <li><i class="fa fa-star"></i></li>
                                    @endfor
                                    @for($i = 0; $i < 5- $averageRate; $i++)
                                        <li class="diff-color"><i class="fa fa-star"></i></li>
                                    @endfor

                                    <span style='margin-left: 20px'>{{ $reviewCnt . ($reviewCnt > 1 ? " reviews" : " review") }}</span>
                                </ul>

                            </div>
                        </a>
                    </div>
                @endforeach
            </div>
        </div>
    </section>

    @include('customer.components.follow_intagram')

@endsection

@section('js_script')
    <script>
        function gotoOrderServicePage(event) {
            var authenticated = {{Auth::guard('customer')->check() ? 'true' : 'false'}};
            if (!authenticated) {
                event.preventDefault();
                openLoginPopup();
            }
        }
    </script>
@endsection
