<?php

namespace App\Providers;

use Illuminate\Foundation\Support\Providers\EventServiceProvider as ServiceProvider;

class EventServiceProvider extends ServiceProvider
{
    protected $listen = [
        'App\Events\PaymentEvent' => [
            'App\Listeners\PaymentEventSettlement',
        ],
        'App\Events\OrderEvent' => [
            'App\Listeners\OrderEventSettelment',
        ],
    ];

    public function boot()
    {
        parent::boot();
    }
}
