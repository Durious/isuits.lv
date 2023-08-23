<?php

namespace App\Observers;

use App\Models\ProductOrder;
use Illuminate\Support\Facades\Log;

class ProductOrderObserver
{
    public function created(ProductOrder $order)
    {
        if (notDemo()) {
            $order->customer->notify(new \App\Notifications\ProductOrderCreated($order));
        }
    }

    public function deleted(ProductOrder $order)
    {

    }

    public function forceDeleted(ProductOrder $order)
    {
    }

    public function restored(ProductOrder $order)
    {
    }

    public function updated(ProductOrder $order)
    {
        $changes = $order->getChanges();
        $order->customer->notify(new \App\Notifications\ProductOrderUpdated($order, $changes));
    }
}
