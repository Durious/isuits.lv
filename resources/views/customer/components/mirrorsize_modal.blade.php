<!-- mirrorsize-modal -starts -->
<div class="custom-modal" id="mirrorsize-modal">
    <div class="">
        <div class="modal-custom-margin">
            <div class="custom-modal-container">
                <form action="{{route('customer.mirrorsize.set_measure')}}" method="POST" onsubmit="handleMirrorsizeSubmit(event)">
                    <button class="close" type="button" onclick="closeModal('mirrorsize-modal')">
                        <i class="lnr lnr-cross"></i></button>
                    <div class="custom-modal-title">{{ _t('my_measures') }}</div>
                    <div class="cutom-modal-body">
                        <div class="diffrent d-flex justify-content-between mb-4">
                            <div class="form-item">
                                <h6>{{_t('dob')}}</h6>
                                <input type="date" name="dob" />
                            </div>
                        </div>
                        <div class="diffrent d-flex justify-content-between mb-4">
                            <div class="form-item half">
                                <h6>{{_t('weight')}}(kg)</h6>
                                <input type="number" name="weight"/>
                            </div>
                            <div class="form-item half">
                                <h6>{{_t('height')}}(cm)</h6>
                                <input type="number" name="height"/>
                            </div>
                        </div>
                        <div class="diffrent d-flex justify-content-between mb-4">
                            <div class="form-item half">
                                <h6>{{_t('mobile_model')}}</h6>
                                <input type="text" placeholder="Iphone7" name="mobilemodel"/>
                            </div>
                            <div class="form-item half">
                                <h6>{{_t('fit')}} {{_t('type')}}</h6>
                                <select name="fitType">
                                    <option value="tightfit">{{_t('tight')}}</option>
                                    <option value="loosefit">{{_t('loose')}}</option>
                                </select>
                            </div>
                        </div>
                        <div class="diffrent d-flex justify-content-between mb-4">
                            <div class="form-item">
                                <h6>{{_t('front_image')}}</h6>
                                <input type="file" name="frontImage" />
                            </div>
                        </div>
                        <div class="diffrent d-flex justify-content-between mb-4">
                            <div class="form-item">
                                <h6>{{_t('side_image')}}</h6>
                                <input type="file" name="sideImage" />
                            </div>
                        </div>
                    </div>
                    <div class="custom-modal-footer">
                        <div>
                            <button class="template-btn2 on2" type="submit">{{_t('submit')}}</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- mirrorsize-modal -end -->
