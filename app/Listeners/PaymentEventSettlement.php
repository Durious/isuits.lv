<?php

namespace App\Listeners;

use App\Models\Order;
use App\Events\PaymentEvent;
use Illuminate\Support\Facades\Log;
use Illuminate\Contracts\Queue\ShouldQueue;

class PaymentEventSettlement implements ShouldQueue
{
    public function failed(PaymentEvent $event, $exception)
    {
        Log::error('PaymentEvent failed!', ['payment_id' => $event->payment->id, 'Error' => $exception]);
    }

    public function handle(PaymentEvent $event)
    {
        if ($event->deleting) {
            $event->payment->orders()->detach();
            $event->payment->orders->each(function ($order) {
                // $order->payments()->detach();
                $order->update(['paid' => null]);
            });
        } else {
            if ($event->payment->order_id) {
                $order = Order::find($event->payment->order_id);
                if ($order) {
                    $order->payments()->attach($event->payment->id, ['amount' => $event->payment->amount]);
                    $paid_amount = $order->payments->isEmpty() ? 0 : $order->payments->sum('amount');
                    $paying_amount = $order->grand_total - $paid_amount;
                    if (!$order->paid && $paying_amount <= $event->payment->amount) {
                        $order->update(['paid' => 1]);
                    }
                }
            } else {
                if ($event->updating) {
                    $event->payment->orders()->detach();
                    $event->payment->orders->each(function ($order) {
                        // $order->payments()->detach();
                        $order->update(['paid' => null]);
                    });
                }
                $orders = Order::unpaid()->ofCustomer($event->payment->customer_id)->oldest()->get();
                $balance = $event->payment->amount;
                foreach ($orders as $order) {
                    $paid_amount = $order->payments ? $order->payments->sum('pivot.amount') : 0;
                    $paying_amount = $order->grand_total - $paid_amount;
                    if (0 == $balance) {
                        break;
                    } elseif ($paying_amount > 0 && $paying_amount <= $balance) {
                        $order->payments()->save($event->payment, ['amount' => $paying_amount]);
                        $order->update(['paid' => 1]);
                        $balance -= $paying_amount;
                    } elseif ($paying_amount > $balance) {
                        $order->payments()->save($event->payment, ['amount' => $balance]);
                        break;
                    }
                }
            }
        }
    }
}
