<?php

namespace App\Http\Controllers\Customer;

use Auth;
use App\Models\ProductOrder;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class ProductOrderController extends Controller
{
    public function verify() {
        $carts = Auth::guard('customer')->user()->carts;
        if(count($carts) === 0) {
            return response()->json([
                'success' => false,
                'error' => 'There is no available carts.'
            ]);
        }
        $shipping_address = Auth::guard('customer')->user()->shipping_addresses()->where('is_default', true)->first();
        if(!$shipping_address) {
            return response()->json([
                'success' => false,
                'error' => 'There is no available shipping address.'
            ]);    
        }
        $billing_address = Auth::guard('customer')->user()->billing_addresses()->where('is_default', true)->first();
        if(!$billing_address) {
            return response()->json([
                'success' => false,
                'error' => 'There is no available billing address.'
            ]);    
        }
        $customer_measure = Auth::guard('customer')->user()->customer_measure;
        if(!$customer_measure) {
            return response()->json([
                'success' => false,
                'error' => 'There is no available anatomic measure.'
            ]);
        }

        return response()->json([
            'success' => true
        ]);
    }

    public function store(Request $request)
    {
        $order = new ProductOrder();
        $order->customer_id = Auth::guard('customer')->user()->id;
        $shipping_address = Auth::guard('customer')->user()->shipping_addresses()->where('is_default', true)->first();
        $billing_address = Auth::guard('customer')->user()->billing_addresses()->where('is_default', true)->first();
        $order->shipping_address_id = $shipping_address->id;
        $order->billing_address_id = $billing_address->id;
        $order->paid_status = $request->status;
        $order->reference = $request->reference;
        $order->gateway = $request->gateway;
        $order->save();

        Auth::guard('customer')->user()->carts()->update(['product_order_id' => $order->id]);

        return response()->json(['success' => true]);
    }

    public function update_paid(Request $request)
    {
        $order = ProductOrder::where('reference', $request->reference)->first();
        if(!$order) {
            return response()->json(['success' => false]);    
        }
        
        $order->paid_status = $request->status;
        $order->save();

        return response()->json(['success' => true]);
    }
}
