<?php

namespace App\Models;

class ProductReview extends SoftDeleteModel
{
    public function product()
    {
        return $this->belongsTo(Product::class);
    }

    public function customer()
    {
        return $this->belongsTo(Customer::class)->select(['id', 'name', 'email', 'address', 'phone', 'photo']);
    }
}
