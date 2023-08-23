<!-- promotion-popup-starts -->
<div class="promotion-popup" id="promotion-popup">
    <div class="container">
        <div class="row modal-custom-margin">
            <div class="col-lg-6 px-0">
                <div class="modal-image"></div>
            </div>
            <div class="col-lg-6 px-0">
                <div class="modal-right text-center">
                    <span class="cross-icon"><i class="lnr lnr-cross"></i></span>
                    <h2>Be the First <br />to know</h2>
                    @if (session('success'))
                        <div class="alert alert-success alert-dismissible fade show" style="width: 300px; margin: auto" role="alert">
                            {{ session('success') }}
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    @endif
                    @if (session('error'))
                        <div class="alert alert-warning alert-dismissible fade show" style="width: 300px; margin: auto" role="alert">
                            {{ session('error') }}
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    @endif
                    <p class="mt-4 mb-5">
                        Sign up for emails to get our latest style <br />news before
                        everybody else
                    </p>
                    <form action="{{route('subscriber.store')}}">
                        <input type="email" placeholder="Enter Email Address Here" name="email" id="email"
                               onfocus="this.placeholder = ''" onblur="this.placeholder = 'Your Email Address'"
                               required />
                        <button type="submit"><span>&rharu;</span></button>
                    </form>

                    <label>Prevent This Pop-up
                        <input type="checkbox" id="checkbox_promotion_popup" />
                        <span class="checkmark"></span>
                    </label>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- promotion-popup-end -->
