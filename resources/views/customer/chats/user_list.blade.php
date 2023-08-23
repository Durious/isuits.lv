<div>
    @foreach($user_list as $user_item)
        @php
            $user_photo = $user_item->photo_path;
            if ($user_photo) {
                $photo_url = asset('storage/' . $user_photo);
            } else {
                $photo_url = asset('customer/img/profile-page/profile.jpg');
            }
        @endphp
        <div class="tailor-item d-flex py-3 px-2 border mb-2" onclick="showChatHistory({{$user_item->id}})">
            <img src="{{ $photo_url }}" width="60" height="60" class="user-photo" alt="user-photo" />
            <div class="ml-4 mr-auto">
                <div class="user-name">{{$user_item->name}}</div>
                <div>{{$user_item->username}}</div>
            </div>
            <div class="d-flex align-items-center">
                <span class="lnr lnr-chevron-right"></span>
            </div>
        </div>
    @endforeach
    @if(count($user_list) === 0)
        <div class="alert alert-info" role="alert">
            There were no results, Try a new search.
        </div>
    @endif
</div>