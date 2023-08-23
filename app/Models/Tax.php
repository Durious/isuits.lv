<?php

namespace App\Models;

class Tax extends Base
{
    protected $casts = ['state' => 'boolean', 'same' => 'boolean', 'compound' => 'boolean'];

    protected $fillable = ['name', 'code', 'rate', 'description', 'compound', 'recoverable', 'state', 'same'];

    public function orders()
    {
        return $this->belongsToMany(Order::class);
    }

    public function scopeFilter($query, array $filters)
    {
        $query->when($filters['search'] ?? null, function ($query, $search) {
            $query->where(function ($query) use ($search) {
                $query->where('code', 'like', '%' . $search . '%')
                    ->orWhere('name', 'like', '%' . $search . '%')
                    ->orWhere('description', 'like', '%' . $search . '%');
            });
        })->when($filters['trashed'] ?? null, function ($query, $trashed) {
            if ($trashed === 'with') {
                $query->withTrashed();
            } elseif ($trashed === 'only') {
                $query->onlyTrashed();
            }
        });
    }
}
