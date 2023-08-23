<?php

namespace App\Models;

use App\Helpers\Notifiable;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class OrderService extends Model
{
    use HasFactory;

    use Notifiable;

    protected $fillable = ['name', 'code', 'qty', 'price', 'amount', 'service_id', 'measurement_id'];

    protected $hidden = ['created_at', 'updated_at'];

    protected $with = ['measurement', 'service'];

    public function measurement()
    {
        return $this->belongsTo(Measurement::class);
    }

    public function order()
    {
        return $this->belongsTo(Order::class);
    }

    public function service()
    {
        return $this->belongsTo(Service::class);
    }
}
