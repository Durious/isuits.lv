<?php

namespace App\Http\Controllers\Customer;

use Auth;
use Validator;
use App\Models\Product;
use App\Models\Customer;
use App\Models\CustomerMeasure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use App\Http\Controllers\Controller;

class ProfileController extends Controller
{
    public function index() 
    {
        $user = Auth::guard('customer')->user();
        $product_orders = $user->product_orders;
        return view('customer.profile.index')
            ->with('order_statuses', explode(',', $user->account->order_statuses))
            ->with('service_orders', $user->orders()->orderBy('delivery_date', 'desc')->get())
            ->with('product_orders', $user->product_orders()->orderBy('created_at', 'desc')->get());
    }

    public function update(Request $request)
    {
        $rules = ['name' => 'required'];

        $validator = Validator::make($request->all(), $rules);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'error' => $validator->errors()->toArray()
            ]);
        }

        Customer::where('id', Auth::guard('customer')->user()->id)
            ->update($request->except('_token'));

        return response()->json(['success' => true]);
    }

    public function change_password(Request $request)
    {
        $rules = [
            'old_password'  => 'required',
            'new_password'  => 'required',
            'confirm_password'  => 'required|same:new_password'
        ];

        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'error' => $validator->errors()->toArray()
            ]);
        }

        $user = Auth::guard('customer')->user();
        if (!Hash::check($request->old_password, $user->password)) {
            return response()->json([
                'success' => false,
                'error' => 'Password does not match.'
            ]);
        }

        $user->password = Hash::make($request->new_password);
        $user->save();
        return response()->json(['success' => true]);
    }

    public function change_photo(Request $request)
    {
        $rules = [
            'photo' => 'required|image',
        ];
        
        $validator = Validator::make($request->all(), $rules);
        
        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'error' => $validator->errors()->toArray()
            ]);
        }
        
        $imageName = time().'.'.$request->photo->extension();
        $request->photo->storeAs('public/profile', $imageName);

        $user = Auth::guard('customer')->user();
        $user->photo = $imageName;
        $user->save();

        return response()->json([
            'success'   => true,
            'photo'     => asset('storage/profile/'.$imageName)
        ]);
    }
}
