<?php

namespace App\Models;

class Cart extends SoftDeleteModel
{
    public function product()
    {
        return $this->belongsTo(Product::class);
    }

    public function product_order()
    {
        return $this->belongsTo(ProductOrder::class);
    }

    public function customer()
    {
        return $this->belongsTo(Customer::class);
    }
}
