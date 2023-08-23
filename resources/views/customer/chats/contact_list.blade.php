<div class='noti-list'>
    @php
        $notifications = Auth::guard('customer')->user()->notifications;
    @endphp

    @foreach($notifications as $notification)
        <div>
            @php
                $id = $notification->id;
            @endphp

            <span style="display: {{$notification->read_at == '' ? 'inline-block' : 'none'}}"
                  class="noti-is-new badge badge-pill badge-danger ml-2" id='{{'new-badge-' . $id}}'>New</span>
            <span style="display: {{$notification->read_at != '' ? 'inline-block' : 'none'}}" class="noti-created-time last-time ml-auto"
                  id='{{'read-time-' . $id}}'>
                            {{get_time_ago(strtotime($notification->created_at), false)}}
                </span>

            <div class="alert alert-info">
                <div
                    style="cursor: pointer; color: blue; overflow: hidden; text-overflow: ellipsis; white-space: nowrap"
                    type="button" data-toggle="collapse"
                    data-target="{{'#notification' . $id}}">{{implode(",", $notification->data)}}</div>
                <div id="{{'notification' . $id}}"
                     class="notification-collapse collapse mt-2">{{implode(",", $notification->data)}}</div>
                <span style='display: none'>{{$notification->id}}</span>
            </div>

        </div>
    @endforeach
    @if(count($notifications) === 0)
        <div class="empty-noti alert alert-info" role="alert">
            No notifications
        </div>
    @endif
</div>
