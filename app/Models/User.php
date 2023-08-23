<?php

namespace App\Models;

use League\Glide\Server;
use App\Helpers\Notifiable;
use App\Traits\Restrictable;
use Illuminate\Support\Facades\App;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;

class User extends Authenticatable
{
    use HasFactory;
    use Notifiable;
    use Restrictable;
    use SoftDeletes;

    protected $casts = ['owner' => 'boolean', 'active' => 'boolean'];
    protected $fillable = [
        'name', 'username', 'password', 'email', 'phone', 'owner', 'photo_path', 'salary', 'can_sms', 'view_all', 'edit_all', 'active',
    ];

    public function account()
    {
        return $this->belongsTo(Account::class);
    }

    public function assignedTo()
    {
        return $this->hasMany(Order::class, 'assigned_to');
    }

    public function expenses()
    {
        return $this->hasMany(Expense::class);
    }

    public function isDemoUser()
    {
        return 'owner@tecdiary.com' === $this->email || 'tailor@tecdiary.com' === $this->email;
    }

    public function orders()
    {
        return $this->hasMany(Order::class);
    }

    public function photoUrl(array $attributes)
    {
        if ($this->photo_path) {
            $server = App::make(Server::class);
            // $server->setSourcePathPrefix('storage');
            return $server->getSourcePath($this->photo_path . '?' . http_build_query($attributes));
        }
    }

    public function resolveRouteBinding($value, $field = null)
    {
        return $this->where($this->getRouteKeyName(), $value)->withTrashed()->first();
    }

    public function routeNotificationForVonage($notification)
    {
        return $this->phone_number;
    }

    public function salaries()
    {
        return $this->hasMany(Salary::class, 'staff_id', 'id');
    }

    public function scopeFilter($query, array $filters)
    {
        $query->when($filters['search'] ?? null, function ($query, $search) {
            $query->where(function ($query) use ($search) {
                $query->where('name', 'like', '%' . $search . '%')
                    ->orWhere('email', 'like', '%' . $search . '%');
            });
        })->when($filters['role'] ?? null, function ($query, $role) {
            'owner' == $role ? $query->owner() : $query->staff();
        })->when($filters['trashed'] ?? null, function ($query, $trashed) {
            if ('with' === $trashed) {
                $query->withTrashed();
            } elseif ('only' === $trashed) {
                $query->onlyTrashed();
            }
        });
    }

    public function scopeOwner($query)
    {
        $query->where('owner', 1);
    }

    public function scopeStaff($query)
    {
        $query->whereNull('owner')->orWhere('owner', 0);
    }

    protected static function boot()
    {
        parent::boot();
        static::creating(function ($model) {
            if (!$model->account_id) {
                $model->account_id = auth()->user()->account_id ?? 1;
            }
        });
    }
}
