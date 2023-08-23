<?php

namespace App\Observers;

use App\Models\Customer;
use App\Models\Product;
use App\Models\Subscriber;
use App\Notifications\ProductCreated;
use App\Util\SocketUtil;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Notification;

class ProductObserver
{
    public function created(Product $product)
    {
        if (notDemo()) {
            $customers = Customer::all();
            $subscribers = Subscriber::all();

            Notification::sendNow($customers, new ProductCreated($product));
            Notification::sendNow($subscribers, new ProductCreated($product));
        }
    }

    public function deleted(Product $product)
    {

    }

    public function forceDeleted(Product $product)
    {

    }

    public function restored(Product $product)
    {
    }

    public function updated(Product $product)
    {
    }
}
