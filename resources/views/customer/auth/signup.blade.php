<div class="signup-content">
    <span class="cross-icon"><i class="lnr lnr-cross"></i></span>
    <div class="cart-title text-center">
        <h2>Sign Up</h2>
    </div>

    <form action="{{route('customer.signup')}}" method="POST" id="signup_form">
        @csrf
        <div class="alert alert-danger mb-5 signup-alert" style="display: none;"></div>
        <div class="input-group mb-4">
            <div class="input-group-prepend">
                <span class="input-group-text"><i class="fa fa-user-o"></i></span>
            </div>
            <input type="text" name="name" class="form-control" placeholder="Enter Username" />
        </div>
        <div class="input-group mb-4">
            <div class="input-group-prepend">
                <span class="input-group-text"><i class="fa fa-envelope-o"></i></span>
            </div>
            <input type="email" name="email" class="form-control" placeholder="Enter Email" />
        </div>
        <div class="input-group mb-4">
            <div class="input-group-prepend">
                <span class="input-group-text"><i class="fa fa-lock"></i></span>
            </div>
            <input type="password" name="password" class="form-control" placeholder="Create Password" />
        </div>
        <div class="input-group">
            <div class="input-group-prepend">
                <span class="input-group-text"><i class="fa fa-lock"></i></span>
            </div>
            <input type="password" name="password_confirmation" class="form-control" placeholder="Confirm Password" />
        </div>

        <button type="submit" class="template-btn2 mt-5">
            Sign Up <span>&rharu;</span>
        </button>

        {{-- 
            <div class="check-option mt-5">
                <input type="checkbox" id="checkbox" class="mb-3" />
                <label for="checkbox" class="ml-3">Accept Terms & Conditions</label>
            </div> 
        --}}
        {{-- 
            <button type="submit" class="template-btn2 on2">
                Login with Gmail <span>&rharu;</span>
            </button> 
        --}}
    </form>

    <div class="login-bottom text-center">
        <p>
            You don't have an account?
            <a href="#" class="when-click-login">Login </a>
        </p>
    </div>
</div>