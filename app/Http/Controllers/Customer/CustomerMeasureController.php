<?php

namespace App\Http\Controllers\Customer;

use Auth;
use Validator;
use Illuminate\Http\Request;
use App\Models\CustomerMeasure;
use App\Http\Controllers\Controller;

class CustomerMeasureController extends Controller 
{
    public function save_measure(Request $request)
    {
        $rules = [
            'dob'           => 'required',
            'height'        => 'required',
            'weight'        => 'required',
            'chest'         => 'required',
            'neck'          => 'required',
            'shoulder'      => 'required',
            'back_length'   => 'required',
            'arm_length'    => 'required',
            'biceps'        => 'required',
            'wrist'         => 'required',
            'stomach'       => 'required',
            'waistline'     => 'required',
            'hip'           => 'required',
            'inside_length' => 'required',
            'thigh'         => 'required',
            'shoulder_type' => 'required',
            'chest_type'    => 'required',
            'stomach_type'  => 'required',
            'back_type'     => 'required',
            'rear_type'     => 'required',
            'fit'           => 'required'
        ];

        $validator = Validator::make($request->all(), $rules);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'error' => $validator->errors()->toArray()
            ]);
        }
        
        if(Auth::guard('customer')->user()->customer_measure) {
            $customer_measure = Auth::guard('customer')->user()->customer_measure;
        } else {
            $customer_measure = new CustomerMeasure();
            $customer_measure->customer_id = Auth::guard('customer')->user()->id;
        }
        
        $customer_measure->fill($request->all());
        $customer_measure->save();

        return response()->json(['success' => true]);
    }

    public function get_measure_modal()
    {
        return view('customer.components.measure_modal');
    }

    public function get_measure_container()
    {
        return view('customer.profile.measures');   
    }
}