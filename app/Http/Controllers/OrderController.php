<?php

namespace App\Http\Controllers;

use Inertia\Inertia;
use App\Helpers\OrderHelper;
use Illuminate\Http\Request;
use App\Http\Requests\OrderRequest;
use App\Notifications\OrderCreated;
use App\Http\Resources\OrderCollection;
use Illuminate\Support\Facades\Storage;
use App\Models\{Customer, Order, Service, Tax, User};

class OrderController extends Controller
{
    public function ajax(Order $order)
    {
        $order->load(['account', 'customer', 'services', 'taxes', 'user:id,name', 'payments']);
        return $order;
    }

    public function create(Request $request)
    {
        return Inertia::render('Orders/Create', [
            'iservices'  => Service::with('measurementFields')->active()->take(20)->get(),
            'members'    => User::selectRaw('id as value, name as label')->staff()->take(20)->get(),
            'taxes'      => Tax::selectRaw('id as value, name as label, id, rate, compound')->take(20)->get(),
            'icustomers' => Customer::selectRaw('id as value, name as label, id')->with('measurements')->take(20)->get(),
        ]);
    }

    public function delete(Order $order)
    {
        if ($order->payments()->exists()) {
            return back()->with('error', __('model_can_not_deleted', ['model' => __choice('Order', 1), 'data' => __choice('Payment', 2)]));
        }
        $order->forceDelete();
        return redirect()->to('/orders')->with('success', __('model_deleted', ['model' => __choice('Order', 1)]));
    }

    public function destroy(Order $order)
    {
        $order->delete();
        return back()->with('success', __('model_deleted', ['model' => __choice('Order', 1)]));
    }

    public function edit(Order $order)
    {
        $this->authorize('update', $order);
        $customer = $order->customer->load('measurements');
        $customer->measurements->transform(function ($measurement) {
            $measurement->value = $measurement->id;
            $measurement->label = $measurement->name;
            return $measurement;
        });
        return Inertia::render('Orders/Edit', [
            'order' => [
                'id'              => $order->id,
                'created_at'      => $order->created_at,
                'reference'       => $order->reference,
                'amount'          => $order->amount,
                'paid'            => $order->paid,
                'note'            => $order->note,
                'status'          => $order->status,
                'priority'        => $order->priority,
                'discount'        => $order->discount,
                'deleted_at'      => $order->deleted_at,
                'photo_path'      => $order->photo_path,
                'discount_amount' => $order->discount_amount,
                'taxes'           => $order->taxes ? $order->taxes : [],
                'delivery_date'   => $order->delivery_date->format('Y-m-d'),
                'services'        => $order->services ? $order->services : [],
                'assigned_to'     => $order->assignedTo ? $order->assignedTo->only('id', 'name') : null,
                'customer'        => $customer,
            ],
            'iservices'  => Service::with('measurementFields')->active()->take(20)->get(),
            'members'    => User::selectRaw('id as value, name as label')->staff()->take(20)->get(),
            'taxes'      => Tax::selectRaw('id as value, name as label, id, rate, compound')->take(20)->get(),
            'icustomers' => Customer::selectRaw('id as value, name as label, id')->with('measurements')->take(20)->get(),
        ]);
    }

    public function email(Request $request, Order $order)
    {
        $result = false;
        try {
            $order->customer->notify(new OrderCreated($order));
            $result = true;
            $message = __('Order has been sent to the customer email address');
        } catch (\Exception $e) {
            $message = $e->getMessage();
        }
        return response()->json(['success' => $result, 'message' => $message]);
    }

    public function index(Request $request)
    {
        $filters = $request->all('status', 'start_date', 'end_date', 'due_in', 'search', 'trashed');
        return Inertia::render('Orders/Index', [
            'filters' => $filters,
            'orders'  => new OrderCollection(
                Order::with(['customer:id,name', 'user:id,name', 'assignedTo:id,name'])->myOrders()->filter($filters)->latest()->paginate()->withQueryString()
            ),
        ]);
    }

    public function photo($order, $secret)
    {
        $order = Order::withoutGlobalScopes()->find($order);
        list($user_id, $hash) = explode('--', $secret);

        if ($order->user_id != $user_id || $order->hash != $hash) {
            return redirect('/');
        }

        return response()->download(Storage::path($order->photo_path), $order->ref);
    }

    public function restore(Order $order)
    {
        $order->restore();
        return back()->with('success', __('model_restored', ['model' => __choice('Order', 1)]));
    }

    public function show(Request $request, $order, $hash)
    {
        $order = Order::withoutGlobalScopes()->find($order);
        if (!$request->hasValidSignature() || $order->hash != $hash) {
            abort(404);
        }

        $order = $order->load(['account', 'services', 'taxes', 'user:id,name', 'payments']);
        $customer = Customer::withoutGlobalScopes()->find($order->customer_id);
        $order->setRelation('customer', $customer);
        return Inertia::render('Orders/Show', [
            'modal' => false,
            'order' => $order->toArray(),
        ]);
    }

    public function status(Request $request, Order $order)
    {
        $this->authorize('update', $order);
        $v = $request->validate(['status' => 'required|in:Received,Preparing,Ready,Completed']);
        $user = $request->user();
        if ($user && ($user->owner || $user->id == $order->user_id || $user->id == $order->assigned_to)) {
            $order->update(['status' => $v['status']]);
            return back()->with('success', __('Order status has been successfully updated.'));
        }
        return response()->json(['success' => false]);
    }

    public function store(OrderRequest $request)
    {
        $form = $request->validated();
        $data = OrderHelper::prepare($form);
        $order = OrderHelper::orderTransaction($data);
        \App\Helpers\OrderPayment::create($order, $request);
        return redirect()->route('orders')->with('success', __('model_created', ['model' => __choice('Order', 1)]));
    }

    public function update(OrderRequest $request, Order $order)
    {
        $this->authorize('update', $order);
        $form = $request->validated();
        $data = OrderHelper::prepare($form);
        $order = OrderHelper::orderTransaction($data, $order);
        return back()->with('success', __('model_updated', ['model' => __choice('Order', 1)]));
    }
}
