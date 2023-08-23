<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class JournalTransaction extends Model
{
    protected $hidden = ['posted_at', 'updated_at', 'deleted_at'];

    protected $with = ['subject'];

    protected static function boot()
    {
        parent::boot();
        static::saved(function ($transaction) {
            $transaction->journal->resetCurrentBalances();
        });
    }

    public function journal()
    {
        return $this->belongsTo(Journal::class);
    }

    public function referencesObject($object)
    {
        $this->subject_type = get_class($object);
        $this->subject_id   = $object->id;
        $this->save();
        return $this;
    }

    public function scopeFilter($query, array $filters)
    {
        $query->when($filters['search'] ?? null, function ($query, $search) {
            $query->where('type', 'like', '%' . $search . '%');
        });
    }

    public function scopeOfType($query, $type)
    {
        return $query->where('type', $type);
    }

    public function subject()
    {
        return $this->morphTo();
    }
}
