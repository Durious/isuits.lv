<?php

namespace App\Models;

class ShippingAddress extends SoftDeleteModel
{
    protected $fillable = [
        'fname', 
        'lname', 
        'country', 
        'state', 
        'address', 
        'zipcode', 
        'city', 
        'phone', 
        'other'
    ];

    public function customer()
    {
        return $this->belongsTo(Customer::class);
    }
}
