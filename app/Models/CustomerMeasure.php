<?php

namespace App\Models;

class CustomerMeasure extends SoftDeleteModel
{
    protected $fillable = [
        'dob',
        'height',
        'weight',
        'chest',
        'neck',
        'shoulder',
        'back_length',
        'arm_length',
        'biceps',
        'wrist',
        'stomach',
        'waistline',
        'hip',
        'inside_length',
        'thigh',
        'shoulder_type',
        'chest_type',
        'stomach_type',
        'back_type',
        'rear_type',
        'fit'
    ];

    public function customer()
    {
        return $this->belongsTo(Customer::class);
    }
}
