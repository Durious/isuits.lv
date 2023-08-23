<?php

namespace App\Http\Controllers\Customer;

use Auth;
use Validator;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use App\Http\Controllers\Controller;

class MirrorsizeController extends Controller
{
    public function show_modal() 
    {
        try {
            $user = Auth::guard('customer')->user();
            if($user->mirrorsize_id) {
                return view('customer.components.mirrorsize_modal');
            }
            $response = Http::post(
                'https://api.mysize.mirrorsize.com/api/ms_initialize_user', 
                [
                    'gender' => $user->gender,
                    'productname' => 'get_measured',
                    'apiKey' => env('MIRRORSIZE_API_KEY', 'test_mirrorsize_api_key'),
                    'merchantid' => env('MIRRORSIZE_MERCHANT_ID', 'info@mirrorsize.test')
                ]
            );
            $response = $response->json();
            if($response['message'] === 'SUCCESS') {
                $user->mirrorsize_id = $response['userId'];
                $user->save();
                return view('customer.components.mirrorsize_modal');
            } else {
                return response('An unexpected error occured. Try again!', 500);
            }
        } catch (\Exception $e) {
            return response('An unexpected error occured. Try again!', 500);
        }
    }

    public function set_measure(Request $request)
    {
        try {
            $user = Auth::guard('customer')->user();
            $rules = [
                'dob'           => 'required|date',
                'height'        => 'required|integer',
                'weight'        => 'required|integer',
                'mobilemodel'   => 'required',
                'fitType'       => 'required',
                'frontImage'    => 'required',
                'sideImage'     => 'required'
            ];

            $validator = Validator::make($request->all(), $rules);

            if ($validator->fails()) {
                return response()->json([
                    'success' => false,
                    'error' => $validator->errors()->toArray()
                ]);
            }

            $response = Http::post(
                'https://api.mysize.mirrorsize.com/api/ms_measurement_process', 
                [
                    'userId'        => $user->mirrorsize_id,
                    'angle'         => 90,
                    'height'        => $request->height * 10,
                    'weight'        => $request->weight,
                    'age'           => Carbon::parse($request->dob)->diffInYears(Carbon::now()),
                    'gender'        => $user->gender,
                    'productname'   => 'get_measured',
                    'emailId'       => $user->email,
                    'userName'      => $user->name,
                    'userMobile'    => $user->phone,
                    'apiKey'        => env('MIRRORSIZE_API_KEY', 'test_mirrorsize_api_key'),
                    'frontImage'    => $request->frontImage,
                    'sideImage'     => $request->sideImage,
                    'merchantid'    => env('MIRRORSIZE_MERCHANT_ID', 'info@mirrorsize.test'),
                    'mobilemodel'   => $request->mobilemodel,
                    'fitType'       => $request->fitType,
                ]
            );
            $response = $response->json();
            
            if(($response['status'] ?? '') === 'complete') {
                return response()->json([
                    'success'   => true,
                    'data'      => [
                        'dob'   => $request->dob,
                        'height'=> $request->height,
                        'weight'=> $request->weight,
                    ]
                ]);
            }
            return response()->json([
                'success' => false,
                'error' => $response['message']
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'error' => 'An unexpected error occured. Try again!'
            ]);
        }
    }

    public function get_measure(Request $request)
    {
        try{
            $user = Auth::guard('customer')->user();
            $response = Http::post(
                'https://api.mysize.mirrorsize.com/api/ms_getRecommendation', 
                [
                    'apiKey'        => env('MIRRORSIZE_API_KEY', 'test_mirrorsize_api_key'),
                    'apparelName'   => 'Measurement',
                    'brandName'     => 'ISuits',
                    'gender'        => $user->gender,
                    'merchantid'    => env('MIRRORSIZE_MERCHANT_ID', 'info@mirrorsize.test'),
                    'productname'   => 'get_measured',
                    'userId'        => $user->mirrorsize_id,
                ]
            );
            $response = $response->json();
            if($response['message'] === 'SUCCESS') {
                if($user->customer_measure) {
                    $customer_measure = $user->customer_measure;
                } else {
                    $customer_measure = new CustomerMeasure();
                    $customer_measure->customer_id = $user->id;
                    $customer_measure->biceps = 0;
                    $customer_measure->wrist = 0;
                    $customer_measure->stomach = 0;
                    $customer_measure->waistline = 0;
                    $customer_measure->thigh = 0;
                    $customer_measure->inside_length = 0;
                }
                $customer_measure->dob = $request->dob;
                $customer_measure->height = $request->height;
                $customer_measure->weight = $request->weight;
                $customer_measure->chest = round($response['measurementData']['chest'], 1);
                $customer_measure->neck = round($response['measurementData']['upperNeck'], 1);
                $customer_measure->shoulder = round($response['measurementData']['shoulderAcross'], 1);
                $customer_measure->back_length = round($response['measurementData']['centerBackLength'], 1);
                $customer_measure->arm_length = round($response['measurementData']['armsLength'], 1);
                $customer_measure->hip = round($response['measurementData']['hip'], 1);
                $customer_measure->save();

                return response()->json([
                    'success' => true
                ]);
            }
            return response()->json([
                'success' => false,
                'error' => $response['message']
            ]);
        } catch (\Exception $e) {
            dd($e);
            return response()->json([
                'success' => false,
                'error' => 'An unexpected error occured. Try again!'
            ]);
        }
    }
}
