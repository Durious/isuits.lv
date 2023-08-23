<?php

namespace App\Providers;

use Illuminate\Foundation\Support\Providers\AuthServiceProvider as ServiceProvider;

class AuthServiceProvider extends ServiceProvider
{
    protected $policies = [
        'App\Models\Order'   => 'App\Policies\OrderPolicy',
        'App\Models\Expense' => 'App\Policies\ExpensePolicy',
        'App\Models\Payment' => 'App\Policies\PaymentPolicy',
    ];

    public function boot()
    {
        $this->registerPolicies();
    }
}
