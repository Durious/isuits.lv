@extends('customer.layout.index')

@section('title', 'Service')

@section('body_class', 'service-page')

@section('css_style')
    <link rel="stylesheet" href="{{ asset('customer/custom/css/service.css') }}" />
@endsection

@section('container')
    <div class="service-banner">
        <div class="container">
            <h2 class="text-white text-center">{{_t('order_service')}}</h2>
        </div>
    </div>
    <section class="section-service-form common-form common-input2">
        <div class="container">
            <div class="row">
                <div class="col-xl-4 offset-xl-1 col-lg-5">
                    <div class="common-form-bg mt-5">
                        <h4>{{ $service->name }}</h4>
                        <div class="mt-4">
                            {{ $service->description }}
                        </div>
                        <h5 class="mt-4">
                            <strong>{{_t('price')}}:</strong>
                            €{{ number_format($service->price, 2) }}
                        </h5>
                        @if(count($service->measurementFields) > 0)
                            <hr />
                            <div>
                                <h4 class="my-4">{{_t('your_measurement_info')}}</h4>
                                <form action="{{ route('customer.services.save_measurement') }}"
                                      id="save_service_measurement_form">
                                    @include('customer.service.form_list', [
                                        'fields' => $service->measurementFields,
                                        'customer_measure_list' => json_decode(
                                            $measurement ? $measurement->extra_attributes->toJson() : '[]',
                                            true),
                                    ])
                                    <button type="submit" class="template-btn2 on1 mt-4">
                                        {{_t('save_y', ['y' => _t('measurement', 1)])}}
                                    </button>
                                </form>
                            </div>
                        @endif

                        @include('customer.service.service_reviews')
                        @if(Auth::guard('customer')->check() && !$service->service_reviews()->where('customer_id', Auth::guard('customer')->id())->first())
                            <div class="service-review-form d-none">
                                <form action="{{route('customer.services.save_review')}}" method="POST">
                                    @csrf
                                    <div class="d-flex align-items-center mb-3">
                                        <h4 class="text-capital mr-3 mb-0">rate us</h4>
                                        <span id="rate" data-stars="0"></span>
                                    </div>
                                    <input type="hidden" name="service_id" value="{{$service->id}}" />
                                    <div class="mb-3">
                                        <input type="text" min="0" max="5" name="title" placeholder="{{_t('title')}}" />
                                    </div>
                                    <div class="mb-3">
                                        <textarea name="content" rows="4" placeholder="{{_t('Content')}}"></textarea>
                                    </div>
                                    <div>
                                        <button type="button" class="common-button" id="btn-cancel-review">Cancel
                                        </button>
                                        <button type="submit" class="common-button ml-3">Submit</button>
                                    </div>
                                </form>
                            </div>
                        @endif
                    </div>
                </div>
                <div class="col-lg-7">
                    <div class="contact-bg mt-5 pt-0">
                        <form action="{{route('customer.services.order')}}" id="create-order-form">
                            <input type="hidden" name="service_id" value="{{ $service->id }}" />
                            <div class="mb-5">
                                <h6>{{_t('delivery_date')}}</h6>
                                <input type="date" name="delivery_date" class="w-75" />
                            </div>
                            <div class="mb-5">
                                <h6>{{_t('quantity')}}</h6>
                                <input type="number" name="qty" class="w-75" value="1" />
                            </div>
                            <div class="mb-5">
                                <h6>{{_t('priority')}}</h6>
                                <select class="w-75" name="priority">
                                    <option value="1">{{_t('normal')}}</option>
                                    <option value="2">{{_t('high')}}</option>
                                    <option value="3">{{_t('urgent')}}</option>
                                </select>
                            </div>
                            <div class="mb-5">
                                <h6>{{_t('photo')}}</h6>
                                <input type="file" name="photo" class="w-75" />
                            </div>
                            <div class="mb-5">
                                <h6>{{_t('comment')}}</h6>
                                <textarea name="note" class="w-75" rows="3"></textarea>
                            </div>
                            <button type="submit" class="template-btn2 off1">
                                {{_t('order_now')}}<span>&rharu;</span>
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>
@endsection

@section('js_script')
    <script>
        $('#create-order-form').submit(function(event) {
            event.preventDefault();
            var url = $(this).attr('action');
            var formData = $(this).serializeArray();
            $.ajax({
                url: url,
                method: 'POST',
                data: formData,
                success: function(response) {
                    if (response.success) {
                        toastr.success('Your measureent info for service is saved successfully.');
                    } else {
                        if (typeof response.error === 'string') {
                            toastr.error(response.error);
                        } else if (typeof response.error === 'object') {
                            toastr.error(Object.values(response.error)[0]);
                        } else {
                            toastr.error('An unexpected error occured, try again');
                        }
                    }
                },
            });
        });
        $('#save_service_measurement_form').submit(function(event) {
            event.preventDefault();
            var url = $(this).attr('action');
            var formData = $(this).serializeArray();

            const checkboxList = document.querySelectorAll('#save_service_measurement_form input[type="checkbox"]');

            const groupedCheckboxes = {};
            checkboxList.forEach(function(checkbox) {
                const name = checkbox.getAttribute('name');
                const value = checkbox.value;
                const checked = checkbox.checked;

                if (!groupedCheckboxes[name]) {
                    formData = formData.filter(item => item.name !== name);
                    groupedCheckboxes[name] = {};
                }

                groupedCheckboxes[name][value] = checked;
            });
            Object.keys(groupedCheckboxes).forEach(key => {
                formData.push({
                    name: key,
                    value: JSON.stringify(groupedCheckboxes[key]),
                });
            });
            formData = formData.map(item => ({
                [item.name]: item.value,
            }));
            $.ajax({
                url: url,
                method: 'POST',
                data: {
                    service_id: {{ $service->id }},
                    extra_attributes: JSON.stringify(formData),
                },
                success: function(response) {
                    if (response.success) {
                        toastr.success('Your measurement info for service is saved successfully.');
                    } else {
                        toastr.error('An unexpected error occurred, try again');
                    }
                },
            });
        });

        $('#btn-write-review').on('click', function() {
            $('.service-reviews').addClass('d-none');
            $('.service-review-form').removeClass('d-none');
        });

        $('#btn-cancel-review').on('click', function() {
            $('.service-reviews').removeClass('d-none');
            $('.service-review-form').addClass('d-none');
        });

        $.ratePicker("#rate", {
            max :5,
            rate :function (stars){
                console.log(stars)
            }
        });
    </script>
@endsection
