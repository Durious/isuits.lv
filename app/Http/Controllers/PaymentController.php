<?php

namespace App\Http\Controllers;

use Inertia\Inertia;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;
use App\Http\Resources\PaymentCollection;
use App\Models\{Customer, Order, Payment};
use App\Helpers\{PayUPayment, StripePayment};

class PaymentController extends Controller
{
    public function ajax(Payment $payment)
    {
        $payment->load(['account', 'customer']);
        return $payment;
    }

    public function create()
    {
        return Inertia::render('Payments/Create', [
            'icustomers' => Customer::selectRaw('id as value, name as label, id')->with('measurements')->take(20)->get(),
        ]);
    }

    public function delete(Payment $payment)
    {
        $payment->forceDelete();
        return redirect()->to('/payments')->with('success', __('model_deleted', ['model' => __choice('Payment', 1)]));
    }

    public function destroy(Payment $payment)
    {
        $payment->delete();
        return back()->with('success', __('model_deleted', ['model' => __choice('Payment', 1)]));
    }

    public function edit(Payment $payment)
    {
        $this->authorize('update', $payment);
        return Inertia::render('Payments/Edit', [
            'payment' => [
                'id'          => $payment->id,
                'date'        => $payment->date,
                'reference'   => $payment->reference,
                'amount'      => $payment->amount,
                'gateway'     => $payment->gateway,
                'received'    => $payment->received,
                'description' => $payment->description,
                'created_at'  => $payment->created_at,
                'customer_id' => $payment->customer_id,
                'deleted_at'  => $payment->deleted_at,
                'customer'    => $payment->customer->only('id', 'name', 'phone'),
            ],
        ]);
    }

    public function form(Request $request)
    {
        return $request->validate([
            'date'        => 'required|date',
            'reference'   => 'nullable|max:50',
            'amount'      => 'required|numeric',
            'gateway'     => 'nullable|string',
            'received'    => 'nullable|boolean',
            'description' => 'nullable|max:250',
            'token'       => 'required_if:gateway,Stripe',
            'token_id'    => 'required_if:gateway,Stripe',
            // 'customer_id' => 'nullable|exists:customers,id',
            'customer_id' => ['required', Rule::exists('customers', 'id')->where(function ($query) {
                $query->where('account_id', auth()->user()->account_id);
            })],
            // 'order_id'    => 'nullable|exists:orders,id',
            'order_id' => ['nullable', Rule::exists('orders', 'id')->where(function ($query) {
                $query->where('account_id', auth()->user()->account_id);
            })],
        ]);
    }

    public function index(Request $request)
    {
        $filters = $request->all('search', 'start_date', 'end_date', 'trashed', 'gateway', 'received');
        return Inertia::render('Payments/Index', [
            'filters'  => $filters,
            'payments' => new PaymentCollection(
                Payment::with('customer')->filter($filters)->latest('date')->paginate()->withQueryString()
            ),
        ]);
    }

    public function orderPayments(Order $order)
    {
        return $order->payments;
    }

    public function payu_capture(Request $request)
    {
        return (new PayUPayment())->capture($request);
    }

    public function payu_request(Request $request, Payment $payment)
    {
        return (new PayUPayment())->request($payment);
    }

    public function restore(Payment $payment)
    {
        $payment->restore();
        return back()->with('success', __('model_restored', ['model' => __choice('Payment', 1)]));
    }

    public function show(Request $request, Payment $payment, $hash)
    {
        if (!$request->hasValidSignature() || $payment->hash != $hash) {
            abort(404);
        }

        $payment->load(['account', 'customer']);
        return Inertia::render('Payments/Show', [
            'modal'   => false,
            'payment' => $payment->toArray(),
        ]);
    }

    public function status(Request $request, Payment $payment)
    {
        $this->authorize('update', $payment);
        if ($payment->received) {
            return back()->with('error', __('Payment has been already received.'));
        }
        $user = $request->user();
        if ($user && ($user->owner || $user->id == $payment->user_id)) {
            $payment->update(['received' => 1]);
            return back()->with('success', __('model_marked', ['model' => __choice('Payment', 1), 'status' => __('Received')]));
        }
        return response()->json(['success' => false]);
    }

    public function store(Request $request)
    {
        $v = $this->form($request);
        if ('Stripe' == $v['gateway']) {
            $charge = (new StripePayment())->charge($v);
            if ($charge['error']) {
                return response()->json(['success' => false, 'message' => __('Stripe payment failed') . '! ' . $charge['message']], 422);
            }
            $v['gateway_transaction_id'] = $charge['data']->id;
        }
        $payment = Payment::create($v);
        return response()->json([
            'success' => true,
            'id'      => $payment->id,
            'payu'    => 'PayU' == $v['gateway'],
            'message' => __('model_created', ['model' => __choice('Payment', 1)]),
        ]);
    }

    public function update(Request $request, Payment $payment)
    {
        $this->authorize('update', $payment);
        $v = $this->form($request);
        $payment->update($v);
        return back()->with('success', __('model_updated', ['model' => __choice('Payment', 1)]));
    }
}
