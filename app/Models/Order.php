<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Builder;

class Order extends Base
{
    public $assignUser = true;
    public $hasHash = true;
    public $hasReference = true;
    protected $dates = ['delivery_date'];
    protected $fillable = [
        'reference', 'customer_id', 'assigned_to', 'delivery_date', 'status', 'priority', 'note', 'discount',
        'paid', 'photo_path', 'discount_amount', 'tax_amount', 'total', 'grand_total',
    ];

    public function account()
    {
        return $this->belongsTo(Account::class);
    }

    public function assignedTo()
    {
        return $this->belongsTo(User::class, 'assigned_to');
    }

    public function customer()
    {
        return $this->belongsTo(Customer::class);
    }

    public function payments()
    {
        return $this->belongsToMany(Payment::class)->withPivot('amount');
    }

    public function scopeArrange($query, array $column)
    {
        if (!empty($column)) {
            return $query->orderBy($column['order_by'], $column['order_direction'] ?? 'asc');
        }
        return $query->latest();
    }

    public function scopeFilter($query, array $filters)
    {
        $query->when($filters['search'] ?? null, function ($query, $search) {
            $query->where(function ($query) use ($search) {
                $query->where('reference', 'like', '%' . $search . '%')
                    ->orWhereHas('customer', function ($query) use ($search) {
                        $query->where('name', 'like', '%' . $search . '%')
                            ->orWhere('phone', 'like', '%' . $search . '%');
                    })
                    ->orWhereHas('assignedTo', function ($query) use ($search) {
                        $query->where('name', 'like', '%' . $search . '%')
                            ->orWhere('phone', 'like', '%' . $search . '%');
                    });
            });
        })->when($filters['status'] ?? null, function ($query, $status) {
            $query->where('status', $status);
        })->when($filters['start_date'] ?? null, function ($query, $date) {
            $query->where('created_at', '>=', $date);
        })->when($filters['end_date'] ?? null, function ($query, $date) {
            $query->where('created_at', '<=', $date);
        })->when($filters['due_in'] ?? null, function ($query, $due_in) {
            if (in_array($due_in, [2, 7, 14, 30])) {
                $query->whereBetween('delivery_date', [now()->startOfDay(), now()->addDays($due_in)->endOfDay()])->orderBy('delivery_date');
            }
        })->when($filters['trashed'] ?? null, function ($query, $trashed) {
            if ('with' === $trashed) {
                $query->withTrashed();
            } elseif ('only' === $trashed) {
                $query->onlyTrashed();
            }
        });
    }

    public static function scopeOfCustomer($query, $customer_id)
    {
        return $query->where('customer_id', $customer_id);
    }

    public function scopeOfStatus($query, $status)
    {
        return $query->where('delivery_date', '<=', now()->addDays($days));
    }

    public static function scopePaid($query)
    {
        return $query->where('paid', 1);
    }

    public static function scopeUnpaid($query)
    {
        return $query->wherePaid('0')->orWhereNull('paid');
    }

    public function services()
    {
        return $this->hasMany(OrderService::class);
    }

    public function taxes()
    {
        return $this->belongsToMany(Tax::class)->withPivot('total_amount');
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    protected static function booted()
    {
        static::addGlobalScope('mine', function (Builder $builder) {
            $user = auth()->user();
            if ($user && !$user->owner && !$user->view_all) {
                return $builder->where('user_id', $user->id)->orWhere('assigned_to', $user->id);
            }
        });
    }
}
