<div class="login-content">
    <span class="cross-icon"><i class="lnr lnr-cross"></i></span>
    <div class="cart-title text-center">
        <h2>Login</h2>
    </div>

    <form action="{{route('customer.login')}}" method="POST" id="login_form">
        @csrf
        <div class="alert alert-danger mb-5 login-alert" style="display: none;"></div>
        <div class="input-group mb-40">
            <div class="input-group-prepend">
                <span class="input-group-text" id="basic-addon1"><i class="fa fa-envelope-o"></i></span>
            </div>
            <input type="email" name="email" class="form-control" placeholder="Ferracini@example.com" aria-label="Username"
                aria-describedby="basic-addon1" />
        </div>
        <div class="input-group mb-3">
            <div class="input-group-prepend">
                <span class="input-group-text" id="basic-addon2"><i class="fa fa-lock"></i></span>
            </div>
            <input type="password" name="password" class="form-control" placeholder="**********" aria-label="password"
                aria-describedby="basic-addon2" />
        </div>
        <div class="text-right">
            <a href="#" class="when-click-forgot-password">Forgot Password?</a>
        </div>
        <button type="submit" class="template-btn2 mt-5">
            Login <span>&rharu;</span>
        </button>
    </form>

    <div class="login-bottom text-center">
        <p>
            You don't have an account?
            <a href="#" class="when-click-signup">Sign up</a>
        </p>
    </div>
</div>