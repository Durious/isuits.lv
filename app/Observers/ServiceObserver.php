<?php

namespace App\Observers;

use App\Models\Customer;
use App\Models\Service;
use App\Models\Subscriber;
use App\Notifications\ServiceCreated;
use Illuminate\Support\Facades\Notification;

class ServiceObserver
{
    public function created(Service $service)
    {
        if (notDemo()) {
            $customers = Customer::all();

            $subscribers = Subscriber::all();

            Notification::sendNow($customers, new ServiceCreated($service));
            Notification::sendNow($subscribers, new ServiceCreated($service));
        }
    }

    public function deleted(Service $service)
    {

    }

    public function forceDeleted(Service $service)
    {

    }

    public function restored(Service $service)
    {
    }

    public function updated(Service $service)
    {
    }
}
