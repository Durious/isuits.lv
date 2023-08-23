<?php

namespace App\Models;

class MeasurementField extends Base
{
    public $casts = ['options' => 'array'];

    protected $fillable = ['type', 'name', 'order', 'required', 'options', 'description'];

    public function measurements()
    {
        return Measurement::where('extra_attributes', 'like', '%' . $this->name . '%');
    }

    public function scopeFilter($query, array $filters)
    {
        $query->when($filters['search'] ?? null, function ($query, $search) {
            $query->where(function ($query) use ($search) {
                $query->where('name', 'like', '%' . $search . '%')
                    ->orWhere('type', 'like', '%' . $search . '%')
                    ->orWhere('description', 'like', '%' . $search . '%')
                    ->orWhereHas('services', function ($query) use ($search) {
                        $query->where('code', 'like', '%' . $search . '%')
                            ->orWhere('name', 'like', '%' . $search . '%');
                    });
            });
        })->when($filters['trashed'] ?? null, function ($query, $trashed) {
            if ($trashed === 'with') {
                $query->withTrashed();
            } elseif ($trashed === 'only') {
                $query->onlyTrashed();
            }
        });
    }

    public function services()
    {
        return $this->belongsToMany(Service::class);
    }
}
