<?php

namespace App\Http\Controllers;

use Validator;
use App\Models\Customer;
use App\Models\ProductOrder;
use Illuminate\Http\Request;
use App\Models\ShippingAddress;
use App\Models\BillingAddress;

class CustomerInfoController extends Controller
{
    public function showMeasurement(Request $request, $id)
    {
        $customer = Customer::find($id);
        $customer_measure = $customer->customer_measure;
        return json_encode($customer_measure);
    }

    public function showAddress(Request $request, $id)
    {
        $order = ProductOrder::find($id);
        return json_encode([
            'shipping_address' => $order->shipping_address,
            'billing_address' => $order->billing_address
        ]);
    }

    public function setShippingDefault(Request $request)
    {
        $customer = Customer::find($request->customer_id);
        $shipping_address_id = $request->shipping_address_id;
        $customer->shipping_addresses()->update(['is_default' => false]);
        ShippingAddress::where('id', $shipping_address_id)->update(['is_default' => true]);
        return back()->with('success', __('default_address_success'));
    }

    public function saveShipping(Request $request, $id)
    {
        $rules = [
            'id'        => 'required|integer',
            'fname'     => 'required',
            'lname'     => 'required',
            'country'   => 'required',
            'address'   => 'required',
            'zipcode'   => 'required',
            'city'      => 'required',
            'phone'     => 'required'
        ];

        $validator = Validator::make($request->all(), $rules);

        if ($validator->fails()) {
            return redirect()->back()->withErrors($validator);
        }
        
        if($request->id > 0)
            $shipping_address = ShippingAddress::find($request->id);
        else
            $shipping_address = new ShippingAddress();
        
        $shipping_address->fill($request->all());
        $shipping_address->customer_id = $id;
        $shipping_address->save();
        return back()->with('success', __('model_updated', ['model' => __choice('shipping_address', 1)]));
    }

    public function deleteShipping($id)
    {
        ShippingAddress::find($id)->delete();
        return back()->with('success', __('model_deleted', ['model' => __choice('shipping_address', 1)]));
    }

    public function setBillingDefault(Request $request)
    {
        $customer = Customer::find($request->customer_id);
        $billing_address_id = $request->billing_address_id;
        $customer->billing_addresses()->update(['is_default' => false]);
        BillingAddress::where('id', $billing_address_id)->update(['is_default' => true]);
        return back()->with('success', __('default_address_success'));
    }

    public function saveBilling(Request $request, $id)
    {
        $rules = [
            'id'                => 'required|integer',
            'fname'             => 'required', 
            'lname'             => 'required', 
            'country'           => 'required', 
            'address'           => 'required', 
            'zipcode'           => 'required', 
            'city'              => 'required', 
            'vatcode'           => 'required', 
            'fiscalcode'        => 'required', 
            'recipientcode'     => 'required',
            'taxcode'           => 'required',
            'certified_email'   => 'required'
        ];

        $validator = Validator::make($request->all(), $rules);

        if ($validator->fails()) {
            return redirect()->back()->withErrors($validator);
        }
        
        if($request->id > 0)
            $billing_address = BillingAddress::find($request->id);
        else
            $billing_address = new BillingAddress();
        
        $billing_address->fill($request->all());
        $billing_address->customer_id = $id;
        $billing_address->save();
        return back()->with('success', __('model_updated', ['model' => __choice('billing_address', 1)]));
    }

    public function deleteBilling($id)
    {
        BillingAddress::find($id)->delete();
        return back()->with('success', __('model_deleted', ['model' => __choice('billing_address', 1)]));
    }
}
