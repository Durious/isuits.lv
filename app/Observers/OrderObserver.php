<?php

namespace App\Observers;

use App\Models\Order;

class OrderObserver
{
    public function created(Order $order)
    {
        $balance = $order->customer->journal->getBalanceInDollars();
        $ajt = $order->customer->journal->creditDollars($order->grand_total, 'order_created')->referencesObject($order);
        $order->disableLogging();
        $temp = $order->getEventDispatcher();
        $order->unsetEventDispatcher();
        $order->update(['transaction_id' => $ajt->id]);
        $order->setEventDispatcher($temp);
        if ($balance < 0) {
            event(new \App\Events\OrderEvent($order));
        }
        if (notDemo()) {
            $order->customer->notify(new \App\Notifications\OrderCreated($order));
        }
    }

    public function deleted(Order $order)
    {
        $order->customer->journal
            ->debitDollars($order->grand_total, 'order_deleted')
            ->referencesObject($order);
    }

    public function forceDeleted(Order $order)
    {
        $order->taxes()->detach();
        $order->services()->delete();
    }

    public function restored(Order $order)
    {
        $order->customer->journal
            ->creditDollars($order->grand_total, 'order_updated')
            ->referencesObject($order);
    }

    public function updated(Order $order)
    {
        if (!$order->wasRecentlyCreated) {
            if ($order->isDirty('grand_total')) {
                $order->customer->journal
                    ->debitDollars($order->getOriginal('grand_total'), 'order_editing')
                    ->referencesObject($order);

                $order->customer->journal
                    ->creditDollars($order->grand_total, 'order_updated')
                    ->referencesObject($order);
            }
            if ($order->isDirty('status') && notDemo()) {
                $order->customer->notify(new \App\Notifications\OrderStatusUpdated($order));
            }
        }
    }
}
