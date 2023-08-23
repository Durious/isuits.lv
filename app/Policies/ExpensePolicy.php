<?php

namespace App\Policies;

use App\Models\User;
use App\Models\Expense;
use Illuminate\Auth\Access\HandlesAuthorization;

class ExpensePolicy
{
    use HandlesAuthorization;

    public function update(User $user, Expense $expense)
    {
        if ($user->owner) {
            return true;
        }
        if ($user->id == $expense->user_id) {
            return true;
        }
        if ($user->edit_all) {
            return true;
        }
        return false;
    }
}
