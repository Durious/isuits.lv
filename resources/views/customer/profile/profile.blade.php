<div class="contact-bg">
    <div class="form-border">
        <div class="form-title">
            <h4>{{_t('details_x', ['x' => _t('profile')])}}</h4>
        </div>
        <form action="{{ route('customer.profile.update') }}" method="POST" id="profile_form">
            @csrf
            <div class="alert alert-danger mb-5 profile-alert" style="display: none;"></div>
            <div class="diffrent d-flex justify-content-between">
                <div>
                    <h6>{{_t('fullname')}}</h6>
                    <input type="text" placeholder="John Doe" name="name"
                        value="{{ Auth::guard('customer')->user()->name }}" required />
                </div>
                <div>
                    <h6>{{_t('phone')}}</h6>
                    <input type="text" placeholder="+1234567890" name="phone"
                        value="{{ Auth::guard('customer')->user()->phone }}" />
                </div>
            </div>

            <div class="diffrent d-flex justify-content-between">
                <div>
                    <h6>{{_t('address')}}</h6>
                    <input type="text" placeholder="Enter your address..." name="address"
                        value="{{ Auth::guard('customer')->user()->address }}" />
                </div>
                <div>
                    <h6>{{_t('state')}}</h6>
                    <input type="text" placeholder="Enter your state..." name="state"
                        value="{{ Auth::guard('customer')->user()->state }}" />
                </div>
            </div>

            <div>
                <h6>{{_t('description')}}</h6>
                <textarea placeholder="Enter your description..." name="description" rows="4">{{ Auth::guard('customer')->user()->description }}</textarea>
            </div>

            <div class="form-button">
                <button type="submit" class="template-btn2 on1">
                    {{_t('save_y', ['y' => _t('change', 2)])}}<span class="custom-icon"></span>
                </button>
            </div>
        </form>
    </div>
</div>