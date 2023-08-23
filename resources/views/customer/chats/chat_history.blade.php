<div class="d-flex flex-column h-100 position-relative">
    @php
        $user_photo = $user->photo_path;
        if ($user_photo) {
            $photo_url = asset('storage/' . $user_photo);
        } else {
            $photo_url = asset('customer/img/profile-page/profile.jpg');
        }
        $showAlert = !$first_chat ||
            (!$first_chat->is_accepted && $first_chat->from_user) ||
            (!$first_chat->is_accepted && !$first_chat->from_user);
    @endphp
    <div class="tailor-item d-flex py-3 px-2 border mb-3" onclick="showTailorList()">
        <img src="{{ $photo_url }}" width="52" height="52" class="user-photo" alt="user-photo" />
        <div class="ml-4 mr-auto">
            <div class="user-name">{{$user->name}}</div>
            <div>{{$user->username}}</div>
        </div>
        <div class="d-flex align-items-center">
            <span class="lnr lnr-chevron-left"></span>
        </div>
    </div>
    <div class="chat-alert {{$showAlert ? '' : 'd-none'}}">
        @if(!$first_chat)
        <div class="alert alert-primary" role="alert" onclick="sayHi()">
            Say Hi!!!
        </div>
        @elseif(!$first_chat->is_accepted && $first_chat->from_user)
        <div class="alert alert-primary" role="alert" onclick="acceptRequest()">
            Accept the request
        </div>
        @elseif(!$first_chat->is_accepted && !$first_chat->from_user)
        <div class="alert alert-primary" role="alert">
            Waiting to accept
        </div>
        @endif
    </div>
    <div class="chat-content border">
        @foreach($chats as $key => $item)
            @php
                if ($item->from_user && $user->photo_path) {
                    $photo_url = asset('storage/' . $user->photo_path);
                } else if(!$item->from_user && $customer->photo){
                    $photo_url = asset('storage/profile/' . $customer->photo);
                } else {
                    $photo_url = asset('customer/img/profile-page/profile.jpg');
                }
                $user_name = $item->from_user ? $user->name : $customer->name;

                $is_same_thread = false;
                $prev_item = isset($chats[$key - 1]) ? $chats[$key - 1] : null;
            @endphp
            <div class="chat-log-item d-flex mb-2 {{$item->from_user ? 'chat-left' : 'chat-right'}}">
                <img src="{{$photo_url}}" width="30" height="30" class="rounded-circle" />
                <div class="w-100">
                    <p class="content mb-0">{!! nl2br($item->text) !!}</p>
                    <div class="{{$item->from_user ? 'text-left' : 'text-right'}}">
                        <span class="date">{{ date('m/d h:i A', strtotime($item->created_at)) }}</span>
                    </div>
                </div>
            </div>
        @endforeach
    </div>
    <div class="chat-send mt-3">
        <input type="hidden" id="chat_user_id" value="{{$user->id}}" />
        <textarea rows="1" id="chat_text" @disabled($showAlert)></textarea>
        <button type="button" @disabled($showAlert) onclick="submitChat()">Send</button>
    </div>
</div>