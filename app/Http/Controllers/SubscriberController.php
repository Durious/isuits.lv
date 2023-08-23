<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Subscriber;
use Illuminate\Support\Facades\Log;

class SubscriberController extends Controller
{
    public function store(Request $request)
    {
        $validator = \Validator::make($request->all(), [
            'email' => 'required|email|unique:subscribers,email'
        ]);

        if ($validator->fails()) {
            return redirect()->back()->with('error', 'You already subscribed.');
        } else {
            Subscriber::create([
                'email' => $request->input('email')
            ]);

            return redirect()->back()->with('success', 'Thank you for subscribing!');
        }
    }

    public function cancel(Request $request)
    {
        return view('customer.subscriber.cancel');
    }

    public function unsubscribe(Request $request)
    {
        $subscriber = Subscriber::where('email', $request->input('email'))->first();

        if ($subscriber) {
            $subscriber->delete();
            return redirect()->back()->with('success', 'Unsubscribed successfully.');
        } else {
            return redirect()->back()->with('error', 'Email not found.');
        }
    }
}
