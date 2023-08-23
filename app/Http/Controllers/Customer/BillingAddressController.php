<?php

namespace App\Http\Controllers\Customer;

use Auth;
use Validator;
use Illuminate\Http\Request;
use App\Models\BillingAddress;
use App\Http\Controllers\Controller;

class BillingAddressController extends Controller
{
    public function index(Request $request)
    {
        $selectable = $request->selectable === 'true';
        return view('customer.profile.billing_list')
            ->with('selectable', $selectable);
    }

    public function show($id)
    {
        if($id !== 0) {
            $billing_modal_info = BillingAddress::find($id);
        } else {
            $billing_modal_info = null;
        }
        return view('customer.components.billing_modal')
            ->with('billing_modal_info', $billing_modal_info);
    }

    public function save(Request $request)
    {
        $rules = [
            'fname'             => 'required', 
            'lname'             => 'required', 
            'address'           => 'required', 
            'city'              => 'required', 
            'state'             => 'required', 
            'country'           => 'required', 
            'zipcode'           => 'required', 
            'vatcode'           => 'required', 
            'fiscalcode'        => 'required', 
            'recipientcode'     => 'required',
            'taxcode'           => 'required',
            'certified_email'   => 'required'
        ];

        $validator = Validator::make($request->all(), $rules);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'error' => $validator->errors()->toArray()
            ]);
        }
        
        if($request->id > 0)
            $billing_address = BillingAddress::find($request->id);
        else
            $billing_address = new BillingAddress();

        $billing_address->fill($request->all());
        $billing_address->customer_id = Auth::guard('customer')->user()->id;
        $billing_address->save();

        return response()->json(['success' => true]);
    }

    public function delete($id)
    {
        BillingAddress::find($id)->delete();
        return response()->json(['success' => true]);
    }

    public function setDefault($id)
    {
        Auth::guard('customer')->user()->billing_addresses()->update(['is_default' => false]);
        BillingAddress::where('id', $id)->update(['is_default' => true]);
        return response()->json(['success' => true]);
    }
}
