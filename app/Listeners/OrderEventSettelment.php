<?php

namespace App\Listeners;

use App\Events\OrderEvent;
use Illuminate\Support\Facades\Log;
use Illuminate\Contracts\Queue\ShouldQueue;

class OrderEventSettelment implements ShouldQueue
{
    public function failed(OrderEvent $event, $exception)
    {
        Log::error('OrderEvent failed!', ['order_id' => $event->order->id, 'Error' => $exception]);
    }

    public function handle(OrderEvent $event)
    {
        $payments = $event->order->customer->payments()->received()->latest()->limit(10)->get();
        $pay_amount = $event->order->grand_total;
        foreach ($payments as $payment) {
            $used = $payment->orders->sum('pivot.amount');
            if ($used < $payment->amount) {
                $balance = $payment->amount - $used;
                if ($balance >= $pay_amount) {
                    $event->order->payments()->save($payment, ['amount' => $pay_amount]);
                    $event->order->update(['paid' => 1]);
                    break;
                } elseif ($balance >= 0 && $pay_amount >= $balance) {
                    $pay_amount -= $balance;
                    $event->order->payments()->save($payment, ['amount' => $balance]);
                }
            }
        }
    }
}
