<?php

namespace App\Helpers;

class OrderPayment
{
    public static function create($order, $request)
    {
        if (($request->payment && $request->payment['amount'] > 0) || $request->add_payment) {
            $payment = $order->payments()->create([
                'order_id' => $order->id,
                'amount'   => $order->grand_total,
                'gateway'  => $request->payment['gateway'],
                'note'     => $request->payment['payment_details'] ?? null,

                // 'card_holder'      => $request->payment['card_holder'] ?? null,
                // 'expiry_date'      => $request->payment['expiry_date'] ?? null,
                // 'cheque_number'    => $request->payment['cheque_number'] ?? null,
                // 'gift_card_number' => $request->payment['gift_card_number'] ?? null,
                // 'card_number'      => isset($request->payment['card_number']) ? substr($request->payment['card_number'], -4) : null,
            ]);
            // $order->payments()->attach($payment->id, ['amount' => $payment->amount]);
            // if ($payment->received && formatDecimal($order->grand_total, 2) <= formatDecimal($payment->amount, 2)) {
            //     $order->disableLogging();
            //     $order->update(['paid' => 1]);
            // }
        }
    }
}
