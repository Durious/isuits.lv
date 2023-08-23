<?php

namespace App\Http\Controllers\Customer;

use Auth;
use Validator;
use App\Models\User;
use App\Models\Chat;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Http;

class ChatController extends Controller
{
    public function get_chats($user_id)
    {
        $user = User::find($user_id);
        $customer = Auth::guard('customer')->user();
        $chats = Chat::where('customer_id', Auth::guard('customer')->id())
            ->where('user_id', $user_id);
        $chats->update(['is_read' => true]);

        return view('customer.chats.chat_history')
            ->with('user', $user)
            ->with('customer', $customer)
            ->with('chats', $chats->get())
            ->with('first_chat', $chats->first());
    }

    public function get_contacts()
    {
        return view('customer.chats.contact_list');
    }

    public function search_tailor(Request $request)
    {
        $user_list = array();
        if($request->search) {
            $search = $request->search;
            $user_list = User::where('active', true)
                ->where(function($query) use ($search) {
                    $query->where('email', 'like', $search)
                        ->orWhere('name', 'like', '%'.$search.'%')
                        ->orWhere('username', 'like', '%'.$search.'%');
                })
                ->get();
        }
        
        return view('customer.chats.user_list')
            ->with('user_list', $user_list);
    }

    public function send(Request $request, $user_id)
    {
        $first_chat = Chat::where('customer_id', Auth::guard('customer')->id())
            ->where('user_id', $user_id)
            ->first();
        $chat = new Chat();
        $chat->customer_id = Auth::guard('customer')->id();
        $chat->user_id = $user_id;
        $chat->text = $request->message;
        $chat->is_read = false;
        $chat->is_accepted = $first_chat ? $first_chat->is_accepted : false;
        $chat->from_user = false;
        $chat->save();

        $this->sendSocketRequest($user_id);

        return response()->json([
            'success' => true
        ]);
    }

    public function accept(Request $request, $user_id)
    {
        Chat::where('customer_id', Auth::guard('customer')->id())
            ->where('user_id', $user_id)
            ->update(['is_accepted' => true]);
        
        $this->sendSocketRequest($user_id);
        
        return response()->json([
            'success' => true
        ]);
    }

    public function sendSocketRequest($user_id)
    {
        $response = Http::post(env('SOCKET_SERVER_URL', 'http://localhost:3000').'/send_to_user', [
            'user_id' => $user_id
        ]);
        return true;
    }
}
