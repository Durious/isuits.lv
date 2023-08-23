<?php

namespace App\Models;

class Category extends SoftDeleteModel
{
    protected $fillable = ['name', 'description', 'photo'];

    public function customFields()
    {
        return $this->belongsToMany(CustomField::class)->orderBy('order');
    }
}
