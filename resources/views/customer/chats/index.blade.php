<!-- live-chat-popup-starts -->
<div class="live-chat-popup" id="live-chat-popup">
    <div class="live-chat-content live-chat-part-1" style='padding-top: 40px'>
        <div style='text-align: right'>
            <span class="cross-icon" id="noti-read-all" style='position: initial; margin-right: 10px;'><i class="lnr lnr-eye"></i></span>
            <span class="cross-icon" id="noti-detail" style='position: initial; margin-right: 10px;'><i class="lnr lnr-list"></i></span>
            <span class="cross-icon" style='position: initial; margin-right: 20px;'><i class="lnr lnr-cross"></i></span>
        </div>

        <div class="cart-title text-center" style='padding-top: 20px'>
            <h2>Notifications</h2>
        </div>

        <div id="tailor-list" style='overflow: auto'>
            <div id="search-loading" class="d-none">
                <div class="w-100 d-flex">
                    <div class="spinner-border my-5 mx-auto p-3"></div>
                </div>
            </div>
            <div id="search-list" class="d-none"></div>
            <div id="contact-list">
                @include('customer.chats.contact_list')
            </div>
        </div>
        <div id="chat-history" class="d-none">
        </div>
    </div>
</div>
<!-- live-chat-popup-end -->
