<!-- measure-modal -starts -->
<div class="custom-modal" id="measure-modal">
    <div class="">
        <div class="modal-custom-margin">
            <div class="custom-modal-container">
                <form id="customer_measure_form" action="{{ route('customer.measure.save') }}"
                    onsubmit="saveCustomerMeasure(event)">
                    <button class="close" type="button" onclick="closeModal('measure-modal')">
                        <i class="lnr lnr-cross"></i></button>
                    <div class="custom-modal-title">{{ _t('my_measure') }}</div>
                    <div class="cutom-modal-body">
                        <div class="mb-4">
                            <a href="#" class="btn-prev-measure mr-4" onclick="prevCustomerMeasureStep()">&lharu;
                                {{ _t('back') }}</a>
                            <span class="measure-current-step">1</span>/19
                        </div>
                        @php
                            $measure_modal_info = Auth::guard('customer')->user()->customer_measure ?? null;
                        @endphp
                        <div class="row customer-measure-input measure-step-0">
                            <div class="col-12">
                                <div class="diffrent d-flex justify-content-between mb-4">
                                    <div class="form-item">
                                        <h6>{{ _t('height') }}(Cm)</h6>
                                        <input type="number" step="0.01" name="height"
                                            value="{{ $measure_modal_info->height ?? null }}" />
                                    </div>
                                </div>
                                <div class="diffrent d-flex justify-content-between mb-4">
                                    <div class="form-item">
                                        <h6>{{ _t('weight') }}(Kg)</h6>
                                        <input type="number" step="0.01" name="weight"
                                            value="{{ $measure_modal_info->weight ?? null }}" />
                                    </div>
                                </div>
                                <div class="diffrent d-flex justify-content-between mb-4">
                                    <div class="form-item">
                                        <h6>{{ _t('dob') }}</h6>
                                        <input type="date" name="dob"
                                            value="{{ $measure_modal_info->dob ?? null }}" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row customer-measure-input measure-step-1">
                            <div class="col-sm-7">
                                <div class="form-item">
                                    <h6><strong>{{ _t('chest') }} {{ _t('circumference') }}</strong></h6>
                                    <input type="number" step="0.01" name="chest"
                                        value="{{ $measure_modal_info->chest ?? null }}" />
                                    <div class="mt-3">
                                        Measure the circumference around your chest, with the tape beneath your armpits,
                                        in line with your nipples. Make sure to hold the tape horizontally. Relax your
                                        arms at your sides and breathe normally, so as to get a correct chest
                                        measurement.
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-5">
                                <img src="/customer/img/profile-page/measure-page/chest.jpg" class="w-100" />
                            </div>
                        </div>
                        <div class="row customer-measure-input measure-step-2">
                            <div class="col-sm-7">
                                <div class="form-item">
                                    <h6><strong>{{ _t('neck') }} {{ _t('circumference') }}</strong></h6>
                                    <input type="number" step="0.01" name="neck"
                                        value="{{ $measure_modal_info->neck ?? null }}" />
                                    <div class="mt-3">
                                        Measure the circumference around your neck, with the tape slightly beneath
                                        Adam’s apple, making sure not to pull the tape measure tight. Don’t stretch your
                                        neck and don’t draw your chin downwards, stay relaxed.
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-5">
                                <img src="/customer/img/profile-page/measure-page/neck.jpg" class="w-100" />
                            </div>
                        </div>
                        <div class="row customer-measure-input measure-step-3">
                            <div class="col-sm-7">
                                <div class="form-item">
                                    <h6><strong>{{ _t('shoulder', 1) }} {{ _t('width') }}</strong></h6>
                                    <input type="number" step="0.01" name="shoulder"
                                        value="{{ $measure_modal_info->shoulder ?? null }}" />
                                    <div class="mt-3">
                                        Measure your shoulder width from the outside edge of the left shoulder
                                        (basically where the sleeve of your shirt starts), to the outside edge of the
                                        right shoulder. The tape shouldn’t be perfectly straight, but it should follow
                                        the natural curve of your back, touching the most prominent bone below your
                                        neck.
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-5">
                                <img src="/customer/img/profile-page/measure-page/shoulders.jpg" class="w-100" />
                            </div>
                        </div>
                        <div class="row customer-measure-input measure-step-4">
                            <div class="col-sm-7">
                                <div class="form-item">
                                    <h6><strong>{{ _t('back_length') }}</strong></h6>
                                    <input type="number" step="0.01" name="back_length"
                                        value="{{ $measure_modal_info->back_length ?? null }}" />
                                    <div class="mt-3">
                                        Low your head a little and measure from the most prominent bone below your neck,
                                        to the back of your crotch (1 cm below your rear). Use the measurement of a
                                        jacket that fits you, if you feel like: just measure the centre back seam of
                                        your jacket, without including the collar.
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-5">
                                <img src="/customer/img/profile-page/measure-page/backLength.jpg" class="w-100" />
                            </div>
                        </div>
                        <div class="row customer-measure-input measure-step-5">
                            <div class="col-sm-7">
                                <div class="form-item">
                                    <h6><strong>{{ _t('arm', 1) }} {{ _t('length') }}</strong></h6>
                                    <input type="number" step="0.01" name="arm_length"
                                        value="{{ $measure_modal_info->arm_length ?? null }}" />
                                    <div class="mt-3">
                                        Relax your arms and measure them in two different sessions: start from where you
                                        ended the shoulder measuring, in other words the outside edge of the shoulder
                                        (where the sleeve of your shirt starts), and measure to your elbow. Continue to
                                        measure from your elbow to just below your wrist bone, hugging the shape of your
                                        arm.
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-5">
                                <img src="/customer/img/profile-page/measure-page/arm.jpg" class="w-100" />
                            </div>
                        </div>
                        <div class="row customer-measure-input measure-step-6">
                            <div class="col-sm-7">
                                <div class="form-item">
                                    <h6><strong>{{ _t('bicep', 1) }} {{ _t('circumference') }}</strong></h6>
                                    <input type="number" step="0.01" name="biceps"
                                        value="{{ $measure_modal_info->biceps ?? null }}" />
                                    <div class="mt-3">
                                        Relax your arms at your sides and wrap the tape measure around the largest point
                                        of both of your biceps. Submit the largest value of the two.
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-5">
                                <img src="/customer/img/profile-page/measure-page/biceps.jpg" class="w-100" />
                            </div>
                        </div>
                        <div class="row customer-measure-input measure-step-7">
                            <div class="col-sm-7">
                                <div class="form-item">
                                    <h6><strong>{{ _t('wrist') }} {{ _t('circumference') }}</strong></h6>
                                    <input type="number" step="0.01" name="wrist"
                                        value="{{ $measure_modal_info->wrist ?? null }}" />
                                    <div class="mt-3">
                                        Wrap the tape measure around your wrist, just below your wrist bone. Submit the
                                        largest value of the two.
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-5">
                                <img src="/customer/img/profile-page/measure-page/wrist.jpg" class="w-100" />
                            </div>
                        </div>
                        <div class="row customer-measure-input measure-step-8">
                            <div class="col-sm-7">
                                <div class="form-item">
                                    <h6><strong>{{ _t('stomach') }} {{ _t('circumference') }}</strong></h6>
                                    <input type="number" step="0.01" name="stomach"
                                        value="{{ $measure_modal_info->stomach ?? null }}" />
                                    <div class="mt-3">
                                        Relax and don’t hold your breath (don’t suck in your stomach!). Wrap the tape
                                        around your stomach and in line with your belly button. Make sure to keep the
                                        tape measure horizontal.
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-5">
                                <img src="/customer/img/profile-page/measure-page/stomach.jpg" class="w-100" />
                            </div>
                        </div>
                        <div class="row customer-measure-input measure-step-9">
                            <div class="col-sm-7">
                                <div class="form-item">
                                    <h6><strong>{{ _t('waistline') }}</strong></h6>
                                    <input type="number" step="0.01" name="waistline"
                                        value="{{ $measure_modal_info->waistline ?? null }}" />
                                    <div class="mt-3">
                                        Measure four fingers down from your belly button, without holding your breath.
                                        Make sure to keep the tape measure horizontal and that your trousers don’t
                                        interfere with the measurement
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-5">
                                <img src="/customer/img/profile-page/measure-page/waistline.jpg" class="w-100" />
                            </div>
                        </div>
                        <div class="row customer-measure-input measure-step-10">
                            <div class="col-sm-7">
                                <div class="form-item">
                                    <h6><strong>{{ _t('hip', 1) }} {{ _t('circumference') }}</strong></h6>
                                    <input type="number" step="0.01" name="hip"
                                        value="{{ $measure_modal_info->hip ?? null }}" />
                                    <div class="mt-3">
                                        Wrap the tape measure around your hips, at the widest point of your buttocks,
                                        usually slightly above the crotch line, keeping the tape measure horizontal.
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-5">
                                <img src="/customer/img/profile-page/measure-page/hipBone.jpg" class="w-100" />
                            </div>
                        </div>
                        <div class="row customer-measure-input measure-step-11">
                            <div class="col-sm-7">
                                <div class="form-item">
                                    <h6><strong>{{ _t('inside_leg') }}</strong></h6>
                                    <input type="number" step="0.01" name="inside_length"
                                        value="{{ $measure_modal_info->inside_length ?? null }}" />
                                    <div class="mt-3">
                                        Take off your shoes and stand with your legs slightly wide apart. Measure from
                                        the highest centre point of the thigh (below the crotch line) to the floor,
                                        following the natural shape of the inside leg. Pull the tape just taut enough.
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-5">
                                <img src="/customer/img/profile-page/measure-page/insideLeg.jpg" class="w-100" />
                            </div>
                        </div>
                        <div class="row customer-measure-input measure-step-12">
                            <div class="col-sm-7">
                                <div class="form-item">
                                    <h6><strong>{{ _t('thigh') }} {{ _t('circumference') }}</strong></h6>
                                    <input type="number" step="0.01" name="thigh"
                                        value="{{ $measure_modal_info->thigh ?? null }}" />
                                    <div class="mt-3">
                                        Wrap the tape measure around your thigh just below your crotch and submit the
                                        largest value of the two. Make sure to keep the tape measure horizontal.
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-5">
                                <img src="/customer/img/profile-page/measure-page/thigh.jpg" class="w-100" />
                            </div>
                        </div>
                        <div class="row customer-measure-input measure-step-13">
                            <div class="col-sm-7">
                                <div class="form-item">
                                    <h6><strong>{{ _t('shoulder_type') }}</strong></h6>
                                    <select name="shoulder_type">
                                        <option value="high"
                                            {{ ($measure_modal_info->shoulder_type ?? '') === 'high' ? 'selected' : '' }}>
                                            {{ _t('high') }}</option>
                                        <option value="regular"
                                            {{ ($measure_modal_info->shoulder_type ?? '') === 'regular' ? 'selected' : '' }}>
                                            {{ _t('regular') }}</option>
                                        <option value="low"
                                            {{ ($measure_modal_info->shoulder_type ?? '') === 'low' ? 'selected' : '' }}>
                                            {{ _t('low') }}</option>
                                    </select>
                                    <div class="mt-3">
                                        Choose your shoulder type: high, regular, low.
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-5">
                                <img src="/customer/img/profile-page/measure-page/shoulderProfile.jpg"
                                    class="w-100" />
                            </div>
                        </div>
                        <div class="row customer-measure-input measure-step-14">
                            <div class="col-sm-7">
                                <div class="form-item">
                                    <h6><strong>{{ _t('chest_type') }}</strong></h6>
                                    <select name="chest_type">
                                        <option value="chiselled"
                                            {{ ($measure_modal_info->chest_type ?? '') === 'chiselled' ? 'selected' : '' }}>
                                            {{ _t('chiselled') }}</option>
                                        <option value="regular"
                                            {{ ($measure_modal_info->chest_type ?? '') === 'regular' ? 'selected' : '' }}>
                                            {{ _t('regular') }}</option>
                                        <option value="robust"
                                            {{ ($measure_modal_info->chest_type ?? '') === 'robust' ? 'selected' : '' }}>
                                            {{ _t('robust') }}</option>
                                    </select>
                                    <div class="mt-3">
                                        Choose your chest type: chiselled, regular, robust.
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-5">
                                <img src="/customer/img/profile-page/measure-page/bustProfile.jpg" class="w-100" />
                            </div>
                        </div>
                        <div class="row customer-measure-input measure-step-15">
                            <div class="col-sm-7">
                                <div class="form-item">
                                    <h6><strong>{{ _t('stomach') }} {{ _t('type') }}</strong></h6>
                                    <select name="stomach_type">
                                        <option value="flat"
                                            {{ ($measure_modal_info->stomach_type ?? '') === 'flat' ? 'selected' : '' }}>
                                            {{ _t('flat') }}</option>
                                        <option value="regular"
                                            {{ ($measure_modal_info->stomach_type ?? '') === 'regular' ? 'selected' : '' }}>
                                            {{ _t('regular') }}</option>
                                        <option value="protruding"
                                            {{ ($measure_modal_info->stomach_type ?? '') === 'protruding' ? 'selected' : '' }}>
                                            {{ _t('protruding') }}</option>
                                    </select>
                                    <div class="mt-3">
                                        Choose your stomach type: flat, regular, protruding. Don’t cheat!
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-5">
                                <img src="/customer/img/profile-page/measure-page/bellyProfile.jpg" class="w-100" />
                            </div>
                        </div>
                        <div class="row customer-measure-input measure-step-16">
                            <div class="col-sm-7">
                                <div class="form-item">
                                    <h6><strong>{{ _t('back_type') }}</strong></h6>
                                    <select name="back_type">
                                        <option value="straight"
                                            {{ ($measure_modal_info->back_type ?? '') === 'straight' ? 'selected' : '' }}>
                                            {{ _t('straight') }}</option>
                                        <option value="regular"
                                            {{ ($measure_modal_info->back_type ?? '') === 'regular' ? 'selected' : '' }}>
                                            {{ _t('regular') }}</option>
                                        <option value="curved"
                                            {{ ($measure_modal_info->back_type ?? '') === 'curved' ? 'selected' : '' }}>
                                            {{ _t('curved') }}</option>
                                    </select>
                                    <div class="mt-3">
                                        Choose your back type: straight, regular, curved.
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-5">
                                <img src="/customer/img/profile-page/measure-page/backProfile.jpg" class="w-100" />
                            </div>
                        </div>
                        <div class="row customer-measure-input measure-step-17">
                            <div class="col-sm-7">
                                <div class="form-item">
                                    <h6><strong>{{ _t('rear_type') }}</strong></h6>
                                    <select name="rear_type">
                                        <option value="flat"
                                            {{ ($measure_modal_info->rear_type ?? '') === 'flat' ? 'selected' : '' }}>
                                            {{ _t('flat') }}</option>
                                        <option value="regular"
                                            {{ ($measure_modal_info->rear_type ?? '') === 'regular' ? 'selected' : '' }}>
                                            {{ _t('regular') }}</option>
                                        <option value="protruding"
                                            {{ ($measure_modal_info->rear_type ?? '') === 'protruding' ? 'selected' : '' }}>
                                            {{ _t('protruding') }}</option>
                                    </select>
                                    <div class="mt-3">
                                        Choose your rear type: flat, regular, protruding.
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-5">
                                <img src="/customer/img/profile-page/measure-page/seatProfile.jpg" class="w-100" />
                            </div>
                        </div>
                        <div class="row customer-measure-input measure-step-18">
                            <div class="col-sm-7">
                                <div class="form-item">
                                    <h6><strong>{{ _t('fit') }}</strong></h6>
                                    <select name="fit">
                                        <option value="comfort"
                                            {{ ($measure_modal_info->fit ?? '') === 'comfort' ? 'selected' : '' }}>
                                            {{ _t('comfort') }}</option>
                                        <option value="regular"
                                            {{ ($measure_modal_info->fit ?? '') === 'regular' ? 'selected' : '' }}>
                                            {{ _t('regular') }}</option>
                                        <option value="slim"
                                            {{ ($measure_modal_info->fit ?? '') === 'slim' ? 'selected' : '' }}>
                                            {{ _t('slim') }}</option>
                                    </select>
                                    <div class="mt-3">
                                        Choose the fit you like the most: comfort, regular, slim.
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-5">
                                <img src="/customer/img/profile-page/measure-page/fit.jpg" class="w-100" />
                            </div>
                        </div>
                    </div>
                    <div class="custom-modal-footer">
                        <div>
                            <button class="template-btn2 on1 btn-next-measure mr-4 mt-3" type="button"
                                onclick="nextCustomerMeasureStep()">{{_t('next')}} &rharu;</button>
                            <button class="template-btn2 on1 btn-submit-measure mr-4 mt-3 d-none" type="submit">{{_t('save')}}</button>
                            <button class="template-btn2 on2 mt-3" type="button"
                                onclick="closeModal('measure-modal')">{{_t('cancel')}}</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- measure-modal -end -->
