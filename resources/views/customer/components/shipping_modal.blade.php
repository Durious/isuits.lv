<!-- shipping-modal -starts -->
<div class="custom-modal" id="shipping-modal">
    <div class="">
        <div class="modal-custom-margin">
            <div class="custom-modal-container">
                @php
                $shipping_modal_info = $shipping_modal_info ?? null;
                @endphp
                <form 
                    id="shipping_address_form" 
                    action="{{route('customer.shipping_address.save')}}"
                    onsubmit="saveShippingAddress(event)"
                    operation="{{$shipping_modal_info ? 'update' : 'create'}}">
                    <button type="button" class="close" onclick="closeModal('shipping-modal')"><i class="lnr lnr-cross"></i></button>
                    <div class="custom-modal-title">{{_t('shipping_address')}}</div>
                    <input type="hidden" value="{{$shipping_modal_info ? $shipping_modal_info->id : '0'}}" name="id" />
                    <div class="cutom-modal-body">
                        <div class="diffrent d-flex justify-content-between mb-4">
                            <div class="form-item half">
                                <h6>{{_t('name')}}</h6>
                                <input 
                                    type="text" 
                                    placeholder="{{_t('enter_x', ['x' => _t('name')])}}"
                                    name="fname" 
                                    value="{{$shipping_modal_info ? $shipping_modal_info->fname : ''}}"
                                />
                            </div>
                            <div class="form-item half">
                                <h6>{{_t('surname')}}</h6>
                                <input 
                                    type="text" 
                                    placeholder="{{_t('enter_x', ['x' => _t('surname')])}}"
                                    name="lname" 
                                    value="{{$shipping_modal_info ? $shipping_modal_info->lname : ''}}"
                                />
                            </div>
                        </div>
                        <div class="diffrent d-flex justify-content-between mb-4">
                            <div class="form-item half">
                                <h6>{{_t('country')}}</h6>
                                <input 
                                    type="text" 
                                    placeholder="{{_t('enter_x', ['x' => _t('country')])}}"
                                    name="country" 
                                    id="shipping_country_selector"
                                    value="{{$shipping_modal_info ? $shipping_modal_info->country : ''}}"
                                />
                            </div>
                            <div class="form-item half">
                                <h6>{{_t('state')}}</h6>
                                <input 
                                    type="text" 
                                    placeholder="{{_t('enter_x', ['x' => _t('state')])}}"
                                    name="state" 
                                    value="{{$shipping_modal_info ? $shipping_modal_info->state : ''}}"
                                />
                            </div>
                        </div>
                        <div class="diffrent d-flex justify-content-between mb-4">
                            <div class="form-item">
                                <h6>{{_t('address')}}</h6>
                                <input 
                                    type="text" 
                                    placeholder="{{_t('enter_x', ['x' => _t('address')])}}"
                                    name="address"
                                    value="{{$shipping_modal_info ? $shipping_modal_info->address : ''}}"
                                />
                            </div>
                        </div>
                        <div class="diffrent d-flex justify-content-between mb-4">
                            <div class="form-item half">
                                <h6>{{_t('zipcode')}}</h6>
                                <input 
                                    type="text" 
                                    placeholder="{{_t('enter_x', ['x' => _t('zipcode')])}}"
                                    name="zipcode" 
                                    value="{{$shipping_modal_info ? $shipping_modal_info->zipcode : ''}}"
                                />
                            </div>
                            <div class="form-item half">
                                <h6>{{_t('city')}}</h6>
                                <input 
                                    type="text" 
                                    placeholder="{{_t('enter_x', ['x' => _t('city')])}}"
                                    name="city" 
                                    value="{{$shipping_modal_info ? $shipping_modal_info->city : ''}}"
                                />
                            </div>
                        </div>
                        <div class="diffrent d-flex justify-content-between mb-4">
                            <div class="form-item">
                                <h6>{{_t('phone_number')}}</h6>
                                <input 
                                    type="text" 
                                    placeholder="{{_t('enter_x', ['x' => _t('phone_number')])}}"
                                    name="phone"
                                    id="shipping_phone"
                                    style="padding-left: 55px"
                                    value="{{$shipping_modal_info ? $shipping_modal_info->phone : ''}}"
                                />
                            </div>
                        </div>
                        <div class="diffrent d-flex justify-content-between mb-4">
                            <div class="form-item">
                                <h6>{{_t('more_info')}}</h6>
                                <input 
                                    type="text" 
                                    placeholder="{{_t('enter_x', ['x' => _t('more_info')])}}"
                                    name="other" 
                                    value="{{$shipping_modal_info ? $shipping_modal_info->other : ''}}"
                                />
                            </div>
                        </div>
                    </div>
                    <div class="custom-modal-footer">
                        <button class="template-btn2 on1" type="submit">{{_t('save')}}</button>
                        <button class="template-btn2 on2 ml-4" type="button" onclick="closeModal('shipping-modal')">{{_t('cancel')}}</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- shipping-modal -end -->