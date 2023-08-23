<?php

namespace App\Models;

class BillingAddress extends SoftDeleteModel
{
    protected $fillable = [
        'fname', 
        'lname', 
        'country', 
        'state', 
        'address', 
        'zipcode', 
        'city', 
        'vatcode', 
        'fiscalcode', 
        'recipientcode',
        'taxcode',
        'certified_email',
        'other'
    ];

    public function customer()
    {
        return $this->belongsTo(Customer::class);
    }
}
