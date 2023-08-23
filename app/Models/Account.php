<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Account extends Model
{
    use HasFactory;

    protected $casts = ['email_enabled' => 'boolean', 'sms_enabled' => 'boolean', 'stripe' => 'boolean', 'payu' => 'boolean'];
    protected $guarded = ['id'];

    public function contacts()
    {
        return $this->hasMany(Contact::class);
    }

    public function customers()
    {
        return $this->hasMany(Customer::class);
    }

    public function expenses()
    {
        return $this->hasMany(Expense::class);
    }

    public function logs()
    {
        return $this->hasMany(Activity::class);
    }

    public function measurementFields()
    {
        return $this->hasMany(MeasurementField::class);
    }

    public function measurements()
    {
        return $this->hasMany(Measurement::class);
    }

    public function orders()
    {
        return $this->hasMany(Order::class);
    }

    public function payments()
    {
        return $this->hasMany(Payment::class);
    }

    public function salaries()
    {
        return $this->hasMany(Salary::class);
    }

    public function services()
    {
        return $this->hasMany(Service::class);
    }

    public function taxes()
    {
        return $this->hasMany(Tax::class);
    }

    public function users()
    {
        return $this->hasMany(User::class);
    }

    public function via()
    {
        if ($this->email_enabled && $this->sms_enabled) {
            return ['mail', 'vonage', 'database'];
        } elseif ($this->email_enabled) {
            return ['mail', 'database'];
        } elseif ($this->sms_enabled) {
            return ['vonage', 'database'];
        }
        return ['database'];
    }
}
