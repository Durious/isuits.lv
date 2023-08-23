<?php

namespace App\Http\Controllers\Customer;

use App\Notifications\CustomerLogged;
use Auth;
use Validator;
use App\Models\Customer;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Hash;

class AuthController extends Controller
{
    public function login(Request $request)
    {
        $rules = [
            'email'   => 'required|email',
            'password' => 'required'
        ];

        $validator = Validator::make($request->all(), $rules);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'error' => $validator->errors()->toArray()
            ]);
        }

        if (Auth::guard('customer')->attempt(['email' => $request->email, 'password' => $request->password], $request->remember)) {
            Auth::guard('customer')->user()->notify(new CustomerLogged($request->ip(), $request->header('User-Agent')));

            return response()->json(array(
                'success' => true
            ));
        }

        return response()->json(array(
            'success' => false,
            'error' => 'These credentials do not match our records.'
        ));
    }

    public function signup(Request $request)
    {
        $rules = [
            'name'      => 'required',
            'email'     => 'required|email',
            'password'  => 'required|confirmed'
        ];

        $validator = Validator::make($request->all(), $rules);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'error' => $validator->errors()->toArray()
            ]);
        }

        $customer = Customer::where('email', $request->email)->first();

        if($customer) {
            return response()->json([
                'success' => false,
                'error' => 'The email address you have provided is already in use.'
            ]);
        }

        $user = new Customer;
        $user->name = $request->name;
        $user->email = $request->email;
        $user->password = Hash::make($request->password);
        $user->save();

        return response()->json(array(
            'success' => true
        ));
    }

    public function logout()
    {
        Auth::guard('customer')->logout();
        return redirect('/');
    }
}
