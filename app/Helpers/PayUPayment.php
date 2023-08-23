<?php

namespace App\Helpers;

use App\Models\Payment;
use Tzsk\Payu\Facades\Payu;
use Tzsk\Payu\Concerns\Customer;
use Tzsk\Payu\Concerns\Attributes;
use Illuminate\Support\Facades\Log;
use Tzsk\Payu\Concerns\Transaction;

class PayUPayment
{
    public $account;

    public function __construct()
    {
        $this->account = env('PAYU_DEFAULT_GATEWAY', 'biz');
    }

    public function capture()
    {
        $transaction = Payu::via($this->account)->capture();
        Log::info('Capture PayUPayment response', ['payment' => $transaction->response]);

        if ($transaction->successful()) {
            $payment = $transaction->paidFor;
            // $transaction->response('bank_ref_num');
            // $payment = Payment::findOrFail($transaction->response('udf1'));
            $payment->update(['received' => 1, 'gateway_transaction_id' => $transaction->response('mihpayid')]);
            return redirect()->route('payments')->with('success', __('model_created.', ['model' => __choice('Payment', 1)]));
        }

        return redirect()->route('payments')->with('error', __('PayU payment ' . $transaction->status . '! gateway response has been logged to latest log file in storage/logs/ folder.'));
    }

    public function request($payment)
    {
        $customer = Customer::make()->firstName($payment->customer->name)
            ->phone($payment->customer->phone)->email($payment->customer->email);
        $attributes  = Attributes::make()->udf1($payment->id)->udf2($payment->customer->id);
        $transaction = Transaction::make()->id($payment->reference)->charge($payment->amount)
            ->for($payment->description)->against($payment)->with($attributes)->to($customer);
        return Payu::initiate($transaction)->via($this->account)->redirect(route('payu.capture'));
    }

    public function verify($transaction)
    {
        if (!$transaction->verified()) {
            $response = $transaction->verify($transaction);
            Log::info('Verify PayUPayment payment id ' . $transaction, ['data' => $transaction->response]);
            return $response->status;
        }
        return 'Already Verified';
    }
}
