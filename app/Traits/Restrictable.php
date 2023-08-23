<?php

namespace App\Traits;

trait Restrictable
{
    public static function scopeMine($query)
    {
        $user = auth()->user();
        if (!$user && !$user->owner && !$user->view_all) {
            return $query->where('user_id', $user->id);
        }
    }

    public static function scopeMyOrders($query)
    {
        $user = auth()->user();
        if (!$user && !$user->owner && !$user->view_all) {
            return $query->where('user_id', $user->id)->orWhere('assigned_to', $user->id);
        }
    }
}
