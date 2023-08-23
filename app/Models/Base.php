<?php

namespace App\Models;

use Ulid\Ulid;
use App\Traits\LogActivity;
use App\Traits\Restrictable;
use Spatie\Activitylog\LogOptions;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Base extends Model
{
    use HasFactory;
    use LogActivity;
    use Restrictable;
    use SoftDeletes;

    public $assignUser = false;

    public $hasReference = false;

    protected $perPage = 10;

    protected static function boot()
    {
        parent::boot();
        static::creating(function ($model) {
            if (!$model->account_id) {
                $model->account_id = auth()->user()->account_id ?? 0;
            }
            if ($model->assignUser && !$model->user_id) {
                $model->user_id = auth()->user()->id ?? 0;
            }
            if ($model->hasReference && !$model->reference) {
                $model->reference = Ulid::generate();
            }
            if ($model->hasHash) {
                $model->hash = sha1(now() . (string) Ulid::generate());
            }
        });
    }

    public function resolveRouteBinding($value, $field = null)
    {
        return $this->where($this->getRouteKeyName(), $value)->withTrashed()->first();
    }

    public function getActivitylogOptions(): LogOptions
    {
        return LogOptions::defaults();
    }
}
