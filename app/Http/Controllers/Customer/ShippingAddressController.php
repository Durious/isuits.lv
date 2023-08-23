<?php

namespace App\Http\Controllers\Customer;

use Auth;
use Validator;
use Illuminate\Http\Request;
use App\Models\ShippingAddress;
use App\Http\Controllers\Controller;

class ShippingAddressController extends Controller
{
    public function index(Request $request)
    {
        $selectable = $request->selectable === "true";
        return view('customer.profile.shipping_list')
            ->with('selectable', $selectable);
    }

    public function show($id)
    {
        if($id !== 0) {
            $shipping_modal_info = ShippingAddress::find($id);
        } else {
            $shipping_modal_info = null;
        }
        return view('customer.components.shipping_modal')
            ->with('shipping_modal_info', $shipping_modal_info);
    }

    public function save(Request $request)
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
            return response()->json([
                'success' => false,
                'error' => $validator->errors()->toArray()
            ]);
        }
        
        if($request->id > 0)
            $shipping_address = ShippingAddress::find($request->id);
        else
            $shipping_address = new ShippingAddress();
        
        $shipping_address->fill($request->all());
        $shipping_address->customer_id = Auth::guard('customer')->user()->id;
        $shipping_address->save();

        return response()->json(['success' => true]);
    }

    public function delete($id)
    {
        ShippingAddress::find($id)->delete();
        return response()->json(['success' => true]);
    }

    public function setDefault($id)
    {
        Auth::guard('customer')->user()->shipping_addresses()->update(['is_default' => false]);
        ShippingAddress::where('id', $id)->update(['is_default' => true]);
        return response()->json(['success' => true]);
    }
}
