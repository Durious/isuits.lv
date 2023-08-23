<?php

namespace App\Policies;

use App\Models\User;
use App\Models\Order;
use Illuminate\Auth\Access\HandlesAuthorization;

class OrderPolicy
{
    use HandlesAuthorization;

    public function before($user)
    {
        return $user->owner ? true : null;
    }

    public function update(User $user, Order $order)
    {
        return ($user->id == $order->user_id || $user->edit_all);
    }

    public function view(User $user, Order $order)
    {
        return ($user->id == $order->user_id || $user->id == $order->assigned_to || $user->view_all);
    }
}
