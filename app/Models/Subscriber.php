<?php

namespace App\Models;

use App\Helpers\Notifiable;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Subscriber extends Model
{
    use HasFactory;

    use Notifiable;

    protected $fillable = ['email'];

    public function via()
    {
        return ['mail'];
    }
}
