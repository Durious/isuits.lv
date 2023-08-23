<?php

namespace App\Http\Controllers\Customer;

use App\Models\ProductReview;
use App\Models\ServiceReview;
use Auth;
use Validator;
use App\Models\Order;
use App\Models\Service;
use App\Models\Measurement;
use App\Models\OrderService;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class ServiceController extends Controller
{
    public function index()
    {
        return view('customer.service.index')
            ->with('services', Service::where('active', true)->get());
    }

    public function create($id)
    {
        $service = Service::with('measurementFields')->where('id', $id)->first();
        $measurement = Measurement::where('service_id', $service->id)
            ->where('customer_id', Auth::guard('customer')->user()->id)
            ->first();
        return view('customer.service.create')
            ->with('measurement', $measurement)
            ->with('service', $service);
    }

    public function save_measurement(Request $request)
    {
        $measurement = Measurement::where('service_id', $request->service_id)
            ->where('customer_id', Auth::guard('customer')->user()->id)
            ->first();
        $service = Service::find($request->service_id);
        if (!$measurement) {
            $measurement = new Measurement();
            $measurement->name = Auth::guard('customer')->user()->name . '\'s ' . $service->code;
            $measurement->service_id = $request->service_id;
            $measurement->customer_id = Auth::guard('customer')->user()->id;
        }
        $measurement->extra_attributes = json_decode($request->extra_attributes);
        $measurement->save();

        return response()->json([
            'success' => true
        ]);
    }

    public function order(Request $request)
    {
        $rules = [
            'service_id' => 'required|integer',
            'qty' => 'required|integer',
            'priority' => 'required|integer',
            'delivery_date' => 'required|date',
            'photo' => [
                'nullable',
                function ($attribute, $value, $fail) {
                    if (is_string($value)) {
                        return;
                    }
                    if (!is_uploaded_file($value)) {
                        return $fail('The ' . $attribute . ' must be an image file');
                    }
                    if (!in_array(strtolower($value->getClientOriginalExtension()), ['jpg', 'jpeg', 'png', 'gif'])) {
                        return $fail('The ' . $attribute . ' must be a JPG, JPEG, PNG, or GIF file');
                    }
                }
            ]
        ];

        $v = Validator::make($request->all(), $rules);

        if ($v->fails()) {
            return response()->json([
                'success' => false,
                'error' => $v->errors()->toArray()
            ]);
        }

        $measurement = Measurement::where('service_id', $request->service_id)
            ->where('customer_id', Auth::guard('customer')->user()->id)
            ->first();
        if (!$measurement) {
            return response()->json([
                'success' => false,
                'error' => 'Please set your measurement for service.'
            ]);
        }

        $service = Service::find($request->service_id);
        $order = new Order();
        $order->tax_amount = 0;
        $order->status = 'Pending';
        $order->priority = $request->priority;
        $order->note = $request->note;
        $order->delivery_date = $request->delivery_date;
        $order->total = $request->qty * $service->price;
        $order->grand_total = $request->qty * $service->price;
        $order->customer_id = Auth::guard('customer')->user()->id;

        if ($request->photo && is_uploaded_file($request->photo)) {
            $imageName = time() . '.' . $request->photo->extension();
            $request->photo->storeAs('public/service_order', $imageName);
            $order->photo_path = $imageName;
        }
        $order->save();

        $orderService = new OrderService();
        $orderService->code = $service->code;
        $orderService->name = $service->name;
        $orderService->qty = $request->qty;
        $orderService->price = $service->price;
        $orderService->amount = $request->qty * $service->price;
        $orderService->order_id = $order->id;
        $orderService->service_id = $service->id;
        $orderService->measurement_id = $measurement->id;
        $orderService->save();

        return response()->json([
            'success' => true
        ]);
    }

    public function save_review(Request $request)
    {
        $service_review = ServiceReview::where('service_id', $request->service_id)
            ->where('customer_id', Auth::guard('customer')->user()->id)
            ->first();
        if($service_review) {
            return back()->with('error', __('You already wrote a review about this service.'));
        }
        $service_review = new ServiceReview();
        $service_review->rate = $request->rate;
        $service_review->title = $request->title;
        $service_review->content = $request->content;
        $service_review->service_id = $request->service_id;
        $service_review->customer_id = Auth::guard('customer')->user()->id;
        $service_review->save();
        return back()->with('message', __('Save your review successfully.'));
    }
}
