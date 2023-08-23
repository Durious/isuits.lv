@extends('customer.layout.index')

@section('title', 'Unsubscribe')

@php
    $story = json_decode($frontend_setting->story ?? 'null');
    $about_service = json_decode($frontend_setting->about_service ?? 'null');
@endphp

@section('body_class', 'about-page')

@section('css_style')
    <link rel="stylesheet" href="{{asset('customer/css/slick.css')}}" />
@endsection

@section('container')
    <div style='text-align: center; margin-top: 30px'>
        <div class="container">
            <div class="row justify-content-center">

                @if (session('success'))
                    <div class="alert alert-success alert-dismissible fade show m-5"
                         style="width: 300px; position: absolute; top: 50px; right: 0" role="alert">
                        {{ session('success') }}
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                @endif

                <div class="col-md-8">
                    @php
                        $notifications = Auth::guard('customer')->user()->notifications;
                    @endphp

                    <div class="card">
                        <div class="card-header"><h3>Notifications</h3></div>
                        <div class="card-body" style='min-height: 500px'>
                            @if ($notifications->count() > 0)
                                <ul class="list-group">
                                    @foreach ($notifications as $notification)
                                        <li class="list-group-item{{ $notification->read_at ? '' : ' font-weight-bold' }}">
                                            {{implode(",", $notification->data)}}
                                            <div class="d-flex justify-content-between align-items-center mt-2">
                                                <span class="text-muted small">{{ $notification->created_at->format('H:i, F j, Y') }}</span>
                                                <form id="delete-notification-form-{{ $notification->id }}" action="{{ route('notification.delete', $notification->id) }}"
                                                      method="post">
                                                    @csrf
                                                    @method('DELETE')
                                                    <button type="button" class="btn btn-sm btn-danger" onClick="deleteNotification('{{ $notification->id }}')">Delete</button>
                                                </form>
                                            </div>
                                        </li>
                                    @endforeach
                                </ul>
                            @else
                                <p>No notifications found.</p>
                            @endif
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection

@section("js_script")

    <script>
        function deleteNotification(notificationId) {
            Swal.fire({
                title: 'Are you sure?',
                text: 'You won\'t be able to revert this!',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, delete it!',
            }).then((result) => {
                if (result.isConfirmed) {
                    $('#delete-notification-form-' + notificationId).submit();
                }
            });
        }
    </script>

@endsection
