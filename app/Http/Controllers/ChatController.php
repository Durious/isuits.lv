<?php

namespace App\Http\Controllers;

use DB;
use Auth;
use Inertia\Inertia;
use App\Models\Chat;
use App\Models\Customer;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;

class ChatController extends Controller
{
    public function index()
    {
        $chat_customers = Chat::select(
                'customers.id', 
                'customers.name', 
                'customers.email', 
                'customers.photo', 
                DB::raw('MAX(chats.created_at) as last_time'), 
                DB::raw('SUBSTRING_INDEX(GROUP_CONCAT(chats.text ORDER BY chats.created_at DESC SEPARATOR \'!!\'), \'!!\', 1) as last_text'),
                DB::raw('SUM(CASE WHEN chats.is_read = false AND chats.from_user = 0 THEN 1 ELSE 0 END) as unread')
            )
            ->join('customers', 'customers.id', '=', 'chats.customer_id')
            ->where('chats.user_id', Auth::guard('web')->id())
            ->orderBy('last_time', 'desc')
            ->groupBy('customers.id')
            ->get();

        $customers = Customer::select('id','name','email','photo')->get();
            
        return Inertia::render('Chats/Index', [
            'icustomers1' => $chat_customers,
            'icustomers2' => $customers
        ]);
    }

    public function show($customer_id)
    {
        $chats = Chat::where('user_id', Auth::guard('web')->id())
            ->where('customer_id', $customer_id);
        $chats->update(['is_read' => true]);

        return response()->json([
            'chats' => $chats->get(),
            'first_chat' => $chats->first()
        ]);
    }

    public function send(Request $request, $customer_id)
    {
        $first_chat = Chat::where('user_id', Auth::guard('web')->id())
            ->where('customer_id', $customer_id)
            ->first();
        $chat = new Chat();
        $chat->user_id = Auth::guard('web')->id();
        $chat->customer_id = $customer_id;
        $chat->text = $request->text;
        $chat->is_read = false;
        $chat->is_accepted = $first_chat ? $first_chat->is_accepted : false;
        $chat->from_user = true;
        $chat->save();

        $this->sendSocketRequest($customer_id);

        return response()->json([
            'success' => true
        ]);
    }

    public function accept(Request $request, $customer_id)
    {
        Chat::where('user_id', Auth::guard('web')->id())
            ->where('customer_id', $customer_id)
            ->update(['is_accepted' => true]);
        
        $this->sendSocketRequest($customer_id);
        
        return response()->json([
            'success' => true
        ]);
    }

    public function sendSocketRequest($customer_id)
    {
        $response = Http::post(env('SOCKET_SERVER_URL', 'http://localhost:3000').'/send_to_customer', [
            'customer_id' => $customer_id
        ]);
        return true;
    }
}
