<?php

namespace App\Http\Controllers;

use Validator;
use Inertia\Inertia;
use App\Models\Customer;
use Illuminate\Http\Request;
use App\Http\Resources\{CustomerCollection, TransactionCollection};

class CustomerController extends Controller
{
    public function index(Request $request)
    {
        $filters = $request->all('search', 'trashed');
        return Inertia::render('Customers/Index', [
            'filters'   => $filters,
            'customers' => new CustomerCollection(
                Customer::with('journal')
                    ->with('customer_measure')
                    ->filter($filters)
                    ->latest()
                    ->paginate()
                    ->withQueryString()
            ),
        ]);
    }

    public function create()
    {
        return Inertia::render('Customers/Create');
    }

    public function delete(Customer $customer)
    {
        $customer->forceDelete();
        return redirect()->to('/customers')->with('success', __('model_deleted', ['model' => __choice('Customer', 1)]));
    }

    public function destroy(Customer $customer)
    {
        if ($customer->orders()->exists() || $customer->payments()->exists()) {
            return back()->with('error', __('model_can_not_deleted', ['model' => __choice('Customer', 1), 'data' => __choice('Order', 2)]));
        }
        $customer->delete();
        return back()->with('success', __('model_deleted', ['model' => __choice('Customer', 1)]));
    }

    public function edit(Customer $customer)
    {
        return Inertia::render('Customers/Edit', [
            'customer' => [
                'id'           => $customer->id,
                'name'         => $customer->name,
                'email'        => $customer->email,
                'phone'        => $customer->phone,
                'address'      => $customer->address,
                'deleted_at'   => $customer->deleted_at,
                'description'  => $customer->description,
                'measurements' => $customer->measurements()->with('service:id,name')->orderBy('name')->get()->map->only('id', 'name', 'measurement', 'service'),
                'shipping_addresses' => $customer->shipping_addresses,
                'billing_addresses' => $customer->billing_addresses,
            ],
        ]);
    }

    public function form(Request $request)
    {
        return $request->validate([
            'name'            => 'required|max:250',
            'phone'           => 'required|max:50',
            'address'         => 'nullable|max:250',
            'description'     => 'nullable|max:250',
            'opening_balance' => 'nullable|numeric',
            'email'           => 'nullable|max:50|email',
            'ajax'            => 'nullable',
        ]);
    }

    public function restore(Customer $customer)
    {
        $customer->restore();
        return back()->with('success', __('model_restored', ['model' => __choice('Customer', 1)]));
    }

    public function sms(Request $request, Customer $customer)
    {
        $user = $request->user();
        if (!$user->owner && !$user->can_sms) {
            return back()->with('success', __('You are not allowed to access the resource.'));
        }
        $v = $request->validate(['text' => 'required|string']);
        log_activity(__('User is trying to send sms.'), ['sms' => $v['text'], 'user' => $user], $customer);
        if (notDemo()) {
            $result = false;
            try {
                $customer->notify(new \App\Notifications\SendSMS($customer, $v['text']));
                log_activity(__('User has sent sms.'), ['sms' => $v['text'], 'user' => $user], $customer);
                $result = true;
            } catch (\Exception $e) {
                $error = $e->getMessage();
            }
            return response()->json(['success' => $result, 'error' => $error ?? '']);
        }
        return response()->json(['success' => false, 'error' => __('This actions is not allowed on the demo.')]);
    }

    public function store(Request $request)
    {
        $v = $this->form($request);
        $c = Customer::create($v);
        if ($v['ajax'] ?? false) {
            return response()->json($c);
        }
        return redirect()->route('customers')->with('success', __('model_created', ['model' => __choice('Customer', 1)]));
    }

    public function transactions(Request $request, Customer $customer)
    {
        if (!$request->user()->owner) {
            return back()->with('error', __('You are not allowed to access the resource.'));
        }
        $filters = $request->all('search');
        return Inertia::render('Customers/Transactions', [
            'filters'      => $filters,
            'transactions' => new TransactionCollection(
                $customer->journal->transactions()->filter($filters)->latest()->paginate()->withQueryString()
            ),
        ]);
    }

    public function update(Request $request, Customer $customer)
    {
        $v = $this->form($request);
        $customer->update($v);
        return back()->with('success', __('model_updated', ['model' => __choice('Customer', 1)]));
    }

    public function save_measure(Request $request, Customer $customer)
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
            return redirect()->back()->withErrors($validator);
        }
        
        if($customer->customer_measure) {
            $customer_measure = $customer->customer_measure;
        } else {
            $customer_measure = new CustomerMeasure();
            $customer_measure->customer_id = $customer->id;
        }
        
        $customer_measure->fill($request->all());
        $customer_measure->save();
        return back()->with('success', __('model_updated', ['model' => _t('Customer Measure')]));
    }
}
