<div class="contact-bg2">
    <div class="form-border">
        <div class="form-title">
            <h4>{{_t('change_x', ['x' => _t('password')])}}</h4>
        </div>
        <form action="{{ route('customer.password.update') }}" method="POST"
            id="password_form">
            @csrf
            <div class="alert alert-danger mb-5 password-alert" style="display: none;"></div>
            <h6>{{_t('current_pass')}}</h6>
            <input type="password" name="old_password" placeholder="e.i **********" />

            <h6 class="mt-4">{{_t('new_pass')}}</h6>
            <input type="password" name="new_password" placeholder="e.i **********" />

            <h6 class="mt-4">{{_t('confirm_pass')}}</h6>
            <input type="password" name="confirm_password" placeholder="e.i **********" />

            <div class="form-button">
                <button type="submit" class="template-btn2 on1">
                    {{_t('save_y', ['y' => _t('change', 2)])}}<span class="custom-icon"></span>
                </button>
            </div>
        </form>
    </div>
</div>