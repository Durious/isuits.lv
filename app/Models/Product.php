<?php

namespace App\Models;

class Product extends SoftDeleteModel
{
    protected $fillable = ['name', 'category_id', 'description', 'main_photo', 'sub_photos', 'price', 
        'small_burst', 'small_waist', 'small_hips', 'medium_burst', 'medium_waist', 'medium_hips', 
        'large_burst', 'large_waist', 'large_hips'];

    public function category()
    {
        return $this->belongsTo(Category::class);
    }

    public function likedBy()
    {
        return $this->belongsToMany(Customer::class, 'favorites');
    }

    public function product_reviews()
    {
        return $this->hasMany(ProductReview::class);
    }

    public function product_comments() {
        return $this->hasMany(ProductComment::class);
    }

    public function scopeFilter($query, array $filters)
    {
        $query->when($filters['search'] ?? null, function ($query, $search) {
            $query->where(function ($query) use ($search) {
                $query->where('name', 'like', '%' . $search . '%')
                    ->orWhere('description', 'like', '%' . $search . '%');
            });
        });
    }

    public function via()
    {
        return ['database', 'mail'];
    }

    public function averageRate()
    {
        $rates = $this->product_reviews()->pluck('rate');
        return $rates->isNotEmpty() ? round($rates->average(), 1) : 0;
    }
}
