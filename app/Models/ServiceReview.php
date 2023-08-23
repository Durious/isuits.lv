<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ServiceReview extends SoftDeleteModel
{
    public function service()
    {
        return $this->belongsTo(Service::class);
    }
    public function customer()
    {
        return $this->belongsTo(Customer::class)->select(['id', 'name', 'email', 'address', 'phone', 'photo']);
    }
}
