<!-- billing-modal -starts -->
<div class="custom-modal" id="billing-modal">
    <div class="">
        <div class="modal-custom-margin">
            <div class="custom-modal-container">
                @php
                    $billing_modal_info = $billing_modal_info ?? null;
                @endphp
                <form id="billing_address_form" action="{{ route('customer.billing_address.save') }}"
                    onsubmit="saveBillingAddress(event)" operation="{{ $billing_modal_info ? 'update' : 'create' }}">
                    <button class="close" type="button" onclick="closeModal('billing-modal')"><i
                            class="lnr lnr-cross"></i></button>
                    <div class="custom-modal-title">{{ _t('billing_address') }}</div>
                    <input type="hidden" value="{{ $billing_modal_info ? $billing_modal_info->id : '0' }}"
                        name="id" />
                    <div class="cutom-modal-body">
                        <div class="diffrent d-flex justify-content-between mb-4">
                            <div class="form-item half">
                                <h6>{{ _t('name') }}</h6>
                                <input type="text" placeholder="{{ _t('enter_x', ['x' => _t('name')]) }}"
                                    name="fname"
                                    value="{{ $billing_modal_info ? $billing_modal_info->fname : '' }}" />
                            </div>
                            <div class="form-item half">
                                <h6>{{ _t('surname') }}</h6>
                                <input type="text" placeholder="{{ _t('enter_x', ['x' => _t('surname')]) }}"
                                    name="lname"
                                    value="{{ $billing_modal_info ? $billing_modal_info->lname : '' }}" />
                            </div>
                        </div>
                        <div class="diffrent d-flex justify-content-between mb-4">
                            <div class="form-item half">
                                <h6>{{ _t('country') }}</h6>
                                <input type="text" placeholder="{{ _t('enter_x', ['x' => _t('country')]) }}"
                                    name="country"
                                    id="billing_country_selector"
                                    value="{{ $billing_modal_info ? $billing_modal_info->country : '' }}" />
                            </div>
                            <div class="form-item half">
                                <h6>{{ _t('state') }}</h6>
                                <input type="text" placeholder="{{ _t('enter_x', ['x' => _t('state')]) }}"
                                    name="state"
                                    value="{{ $billing_modal_info ? $billing_modal_info->state : '' }}" />
                            </div>
                        </div>
                        <div class="diffrent d-flex justify-content-between mb-4">
                            <div class="form-item half">
                                <h6>{{ _t('address') }}</h6>
                                <input type="text" placeholder="{{ _t('enter_x', ['x' => _t('address')]) }}"
                                    name="address"
                                    value="{{ $billing_modal_info ? $billing_modal_info->address : '' }}" />
                            </div>
                            <div class="form-item half">
                                <h6>{{ _t('zipcode') }}</h6>
                                <input type="text" placeholder="{{ _t('enter_x', ['x' => _t('zipcode')]) }}"
                                    name="zipcode"
                                    value="{{ $billing_modal_info ? $billing_modal_info->zipcode : '' }}" />
                            </div>
                        </div>
                        <div class="diffrent d-flex justify-content-between mb-4">
                            <div class="form-item half">
                                <h6>{{ _t('city') }}</h6>
                                <input type="text" placeholder="{{ _t('enter_x', ['x' => _t('city')]) }}"
                                    name="city"
                                    value="{{ $billing_modal_info ? $billing_modal_info->city : '' }}" />
                            </div>
                            <div class="form-item half">
                                <h6>{{ _t('vatcode') }}</h6>
                                <input type="text" placeholder="{{ _t('enter_x', ['x' => _t('vatcode')]) }}"
                                    name="vatcode"
                                    value="{{ $billing_modal_info ? $billing_modal_info->vatcode : '' }}" />
                            </div>
                        </div>
                        <div class="diffrent d-flex justify-content-between mb-4">
                            <div class="form-item half">
                                <h6>{{ _t('fiscalcode') }}</h6>
                                <input type="text" placeholder="{{ _t('enter_x', ['x' => _t('fiscalcode')]) }}"
                                    name="fiscalcode"
                                    value="{{ $billing_modal_info ? $billing_modal_info->fiscalcode : '' }}" />
                            </div>
                            <div class="form-item half">
                                <h6>{{ _t('recipientcode') }}</h6>
                                <input type="text" placeholder="{{ _t('enter_x', ['x' => _t('recipientcode')]) }}"
                                    name="recipientcode"
                                    value="{{ $billing_modal_info ? $billing_modal_info->recipientcode : '' }}" />
                            </div>
                        </div>
                        <div class="diffrent d-flex justify-content-between mb-4">
                            <div class="form-item half">
                                <h6>{{ _t('certified_email') }}</h6>
                                <input type="email" placeholder="{{ _t('enter_x', ['x' => _t('certified_email')]) }}"
                                    name="certified_email"
                                    value="{{ $billing_modal_info ? $billing_modal_info->certified_email : '' }}" />
                            </div>
                            <div class="form-item half">
                                <h6>{{ _t('taxcode') }}</h6>
                                <input type="text" placeholder="{{ _t('enter_x', ['x' => _t('taxcode')]) }}"
                                    name="taxcode"
                                    value="{{ $billing_modal_info ? $billing_modal_info->taxcode : '' }}" />
                            </div>
                        </div>
                        <div class="diffrent d-flex justify-content-between mb-4">
                            <div class="form-item">
                                <h6>{{ _t('more_info') }}</h6>
                                <input type="text" placeholder="{{ _t('enter_x', ['x' => _t('more_info')]) }}"
                                    name="other"
                                    value="{{ $billing_modal_info ? $billing_modal_info->other : '' }}" />
                            </div>
                        </div>
                    </div>
                    <div class="custom-modal-footer">
                        <button class="template-btn2 on1" type="submit">{{_t('save')}}</button>
                        <button class="template-btn2 on2 ml-4" type="button"
                            onclick="closeModal('billing-modal')">{{_t('cancel')}}</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- billing-modal -end -->
