<?php

namespace App\Models;

use App\Helpers\Notifiable;
use App\Traits\AccountingJournal;

use Illuminate\Foundation\Auth\User as Authenticatable;

class Customer extends Authenticatable
{
    use AccountingJournal;
    use Notifiable;

    protected $fillable = ['name', 'password', 'email', 'phone', 'address', 'description', 'opening_balance'];

    public function account()
    {
        return $this->belongsTo(Account::class);
    }

    public function customer_measure()
    {
        return $this->hasOne(CustomerMeasure::class);
    }

    public function measurements()
    {
        return $this->hasMany(Measurement::class);
    }

    public function product_orders()
    {
        return $this->hasMany(ProductOrder::class);
    }

    public function likes()
    {
        return $this->belongsToMany(Product::class, 'favorites');
    }

    public function shipping_addresses()
    {
        return $this->hasMany(ShippingAddress::class);
    }

    public function billing_addresses()
    {
        return $this->hasMany(BillingAddress::class);
    }

    public function carts()
    {
        return $this->hasMany(Cart::class)->whereNull('product_order_id');
    }

    public function total_price()
    {
        return $this->carts->sum(function ($cart) {
            return $cart->quantity * $cart->unit;
        });
    }

    public function orders()
    {
        return $this->hasMany(Order::class);
    }

    public function payments()
    {
        return $this->hasMany(Payment::class);
    }

    public function routeNotificationForNexmo($notification)
    {
        return $this->phone;
    }

    public function scopeFilter($query, array $filters)
    {
        $query->when($filters['search'] ?? null, function ($query, $search) {
            $query->where('name', 'like', '%' . $search . '%')
                ->orWhere('email', 'like', '%' . $search . '%')
                ->orWhere('phone', 'like', '%' . $search . '%');
        })->when($filters['trashed'] ?? null, function ($query, $trashed) {
            if ('with' === $trashed) {
                $query->withTrashed();
            } elseif ('only' === $trashed) {
                $query->onlyTrashed();
            }
        });
    }

    public function via()
    {
        return ['database', 'mail'];
    }
}
