@php
    $measure = Auth::guard('customer')->user()->customer_measure ?? null;
@endphp
<div class="row">
    <div class="col-12">
        @if ($measure)
            <div>
                <div class="row mb-5">
                    <div class="col-12">
                        <strong>{{_t('measure_updated_at_x', ['x' => $measure->updated_at])}}</strong>
                    </div>
                </div>
                <div class="row mb-3 border-bottom">
                    <div class="col-6 col-md-4 mb-3">
                        <strong>{{_t('dob')}}</strong><br />{{ $measure->dob }}
                    </div>
                    <div class="col-6 col-md-4 mb-3">
                        <strong>{{_t('height')}}</strong><br />{{ $measure->height }} cm
                    </div>
                    <div class="col-6 col-md-4 mb-3">
                        <strong>{{_t('weight')}}</strong><br />{{ $measure->weight }} kg
                    </div>
                </div>
                <div class="row mb-3 border-bottom">
                    <div class="col-6 col-md-4 mb-3">
                        <strong>{{_t('chest')}}</strong><br />{{ $measure->chest }} cm
                    </div>
                    <div class="col-6 col-md-4 mb-3">
                        <strong>{{_t('neck')}}</strong><br />{{ $measure->neck }} cm
                    </div>
                    <div class="col-6 col-md-4 mb-3">
                        <strong>{{_t('shoulder', 2)}}</strong><br />{{ $measure->shoulder }} cm
                    </div>
                    <div class="col-6 col-md-4 mb-3">
                        <strong>{{_t('back_length')}}</strong><br />{{ $measure->back_length }} cm
                    </div>
                    <div class="col-6 col-md-4 mb-3">
                        <strong>{{_t('arm', 2)}}</strong><br />{{ $measure->arm_length }} cm
                    </div>
                    <div class="col-6 col-md-4 mb-3">
                        <strong>{{_t('bicep', 2)}}</strong><br />{{ $measure->biceps }} cm
                    </div>
                    <div class="col-6 col-md-4 mb-3">
                        <strong>{{_t('wrist')}}</strong><br />{{ $measure->wrist }} cm
                    </div>
                    <div class="col-6 col-md-4 mb-3">
                        <strong>{{_t('stomach')}}</strong><br />{{ $measure->stomach }} cm
                    </div>
                    <div class="col-6 col-md-4 mb-3">
                        <strong>{{_t('waistline')}}</strong><br />{{ $measure->waistline }} cm
                    </div>
                    <div class="col-6 col-md-4 mb-3">
                        <strong>{{_t('hip', 2)}}</strong><br />{{ $measure->hip }} cm
                    </div>
                    <div class="col-6 col-md-4 mb-3">
                        <strong>{{_t('inside_leg')}}</strong><br />{{ $measure->inside_length }} cm
                    </div>
                    <div class="col-6 col-md-4 mb-3">
                        <strong>{{_t('thigh')}}</strong><br />{{ $measure->thigh }} cm
                    </div>
                </div>
                <div class="row mb-3">
                    <div class="col-6 col-md-4 mb-3">
                        <strong>{{_t('shoulder_type')}}</strong><br /><span
                            class="text-capitalize">{{ $measure->shoulder_type }}</span>
                    </div>
                    <div class="col-6 col-md-4 mb-3">
                        <strong>{{_t('chest_type')}}</strong><br /><span
                            class="text-capitalize">{{ $measure->chest_type }}</span>
                    </div>
                    <div class="col-6 col-md-4 mb-3">
                        <strong>{{_t('stomach')}}</strong><br /><span class="text-capitalize">{{ $measure->stomach_type }}</span>
                    </div>
                    <div class="col-6 col-md-4 mb-3">
                        <strong>{{_t('back_type')}}</strong><br /><span class="text-capitalize">{{ $measure->back_type }}</span>
                    </div>
                    <div class="col-6 col-md-4 mb-3">
                        <strong>{{_t('rear_type')}}</strong><br /><span class="text-capitalize">{{ $measure->rear_type }}</span>
                    </div>
                    <div class="col-6 col-md-4 mb-3">
                        <strong>{{_t('fit')}}</strong><br /><span class="text-capitalize">{{ $measure->fit }}</span>
                    </div>
                </div>
            </div>
        @else
            <div class="alert alert-warning">
                <strong>{{_t('warning')}}!</strong> {{_t('no_measurement')}}
            </div>
        @endif
    </div>
</div>
<div class="row text-left">
    <div class="col-12">
        <button type="button" class="template-btn2 on2 mr-4 mt-3" onclick="openCustomerMeasureModal(event)">
            {{_t('set')}} {{_t('manually')}}
        </button>
        <button type="button" class="template-btn2 on2 mt-3" onclick="openCustomerMirrorsizeModal(event)">
            {{_t('set')}} {{_t('automatically')}}
        </button>
    </div>
</div>
