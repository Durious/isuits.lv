<?php

namespace App\Observers;

use App\Models\Customer;

class CustomerObserver
{
    public function created(Customer $customer)
    {
        $customer->initJournal();
        $customer->refresh()->journal->creditDollars($customer->opening_balance ?? 0, 'opening_balance');
    }

    public function deleted(Customer $customer)
    {
        $customer->measurements->each->delete();
    }

    public function forceDeleted(Customer $customer)
    {
        $customer->measurements()->withTrashed()->forceDelete();
    }

    public function restored(Customer $customer)
    {
        $customer->measurements()->withTrashed()->restore();
    }
}
