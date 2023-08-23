<?php

namespace App\Http\Controllers;

use App\Models\Customer;
use App\Models\Subscriber;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class NotificationController extends Controller
{
    public function index()
    {
        return view('customer.notification.index');
    }

    public function read(Request $request)
    {
        $id = $request->input('id');

        $notification = Auth::guard('customer')->user()->notifications()->where('id', $id)->first();

        if ($notification) {
            $notification->markAsRead();
        }
    }

    public function readByIndex(Request $request) {
        $notifications = Auth::guard('customer')->user()->notifications()->get();

        $notifications[$notifications->count() - $request->input('index')]->markAsRead();
    }

    public function readAll()
    {
        Auth::guard('customer')->user()->unreadNotifications->markAsRead();
    }

    public function delete($id): \Illuminate\Http\RedirectResponse
    {
        $notification = Auth::guard('customer')->user()->notifications()->findOrFail($id);

        $notification->delete();

        return redirect()->back()->with('success', 'Notification has been deleted.');
    }
}
