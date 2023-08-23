<?php

namespace App\Models;

class ProductOrder extends Base
{
    public function customer()
    {
        return $this->belongsTo(Customer::class)->select(['id', 'name', 'email', 'address', 'phone']);
    }

    public function account()
    {
        return $this->belongsTo(Account::class);
    }

    public function carts()
    {
        return $this->hasMany(Cart::class);
    }

    public function total_price()
    {
        return $this->carts->sum(function ($cart) {
            return $cart->quantity * $cart->unit;
        });
    }

    public function shipping_address()
    {
        return $this->belongsTo(ShippingAddress::class);
    }

    public function billing_address()
    {
        return $this->belongsTo(BillingAddress::class);
    }
}
