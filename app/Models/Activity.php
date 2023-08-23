<?php

namespace App\Models;

use Spatie\Activitylog\Models\Activity as ActivityModel;

class Activity extends ActivityModel
{
    protected static function boot()
    {
        parent::boot();
        static::creating(function ($model) {
            if (!$model->account_id) {
                $model->account_id = auth()->user()->account_id ?? (Account::first()->id ?? null);
            }
        });
    }

    public function scopeFilter($query, array $filters)
    {
        $query->when($filters['search'] ?? null, function ($query, $search) {
            $query->where(function ($query) use ($search) {
                $query->where('log_name', 'like', '%' . $search . '%')
                    ->orWhere('description', 'like', '%' . $search . '%')
                    ->orWhere('subject_id', 'like', '%' . $search . '%')
                    ->orWhere('subject_type', 'like', '%' . $search . '%')
                    ->orWhereHasMorph('causer', '*', function ($query) use ($search) {
                        $query->where('name', 'like', '%' . $search . '%')
                            ->orWhere('phone', 'like', '%' . $search . '%');
                    });
            });
        });
    }
}
