<?php

namespace App\Models;

class CustomField extends SoftDeleteModel
{
    protected $table = 'custom_fields';

    public function categories()
    {
        return $this->belongsToMany(Category::class);
    }
}
