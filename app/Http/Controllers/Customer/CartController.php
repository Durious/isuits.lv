<?php

namespace App\Http\Controllers\Customer;

use Auth;
use Validator;
use App\Models\Cart;
use App\Models\Product;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class CartController extends Controller
{
    public function index()
    {
        return view('customer.carts.index');
    }

    public function cart_list()
    {
        return view('customer.carts.cart-list');
    }

    public function update_quantity(Request $request, Cart $cart)
    {
        if($cart->quantity + $request->changed < 1)
            return response()->json([
                'success' => false,
                'error' => 'The quantity must be greater than 0 in order to proceed.'
            ]);
        $cart->quantity = $cart->quantity + $request->changed;
        $cart->save();
        return response()->json(['success' => true]);
    }

    public function popup_list()
    {
        $carts = Auth::guard('customer')->user()->carts()->with('product')->get();
        return response()->json([
            'success' => true,
            'carts' => $carts
        ]);
    }

    public function addcart(Request $request)
    {
        $rules = [
            'product_id'    => 'required|integer',
            'quantity'      => 'required|integer'
        ];

        $validator = Validator::make($request->all(), $rules);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'error' => $validator->errors()->toArray()
            ]);
        }        

        $cart = new Cart();
        $cart->customer_id = Auth::guard('customer')->user()->id;
        $cart->product_id = $request->product_id;
        $cart->customization = json_encode($request->customization);
        $cart->quantity = $request->quantity;
        $cart->unit = Product::find($request->product_id)->price;

        $cart->save();

        return response()->json(['success' => true]);
    }

    public function delete(Cart $cart)
    {
        $cart->delete();
        return response()->json(['success' => true]);
    }
}
