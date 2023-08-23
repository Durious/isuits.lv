<?php

namespace App\Policies;

use App\Models\User;
use App\Models\Payment;
use Illuminate\Auth\Access\HandlesAuthorization;

class PaymentPolicy
{
    use HandlesAuthorization;

    public function before($user)
    {
        return $user->owner ? true : null;
    }

    public function update(User $user, Payment $payment)
    {
        return ($user->id == $payment->user_id || $user->edit_all);
    }

    public function view(User $user, Payment $payment)
    {
        return ($user->id == $payment->user_id || $user->view_all);
    }
}
