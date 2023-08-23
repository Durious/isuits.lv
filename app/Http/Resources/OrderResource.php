<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class OrderResource extends JsonResource
{
    public function toArray($request)
    {
        // return parent::toArray($request);
        return [
            'id'              => $this->id,
            'created_at'      => $this->created_at,
            'reference'       => $this->reference,
            'total'           => $this->total,
            'paid'            => $this->paid,
            'status'          => $this->status,
            'priority'        => $this->priority,
            'discount'        => $this->discount,
            'tax_amount'      => $this->tax_amount,
            'deleted_at'      => $this->deleted_at,
            'grand_total'     => $this->grand_total,
            'discount_amount' => $this->discount_amount,
            'due_passed'      => $this->delivery_date->isPast(),
            'delivery_date'   => $this->delivery_date->format('Y-m-d'),
            'due'             => $this->delivery_date->endOfDay()->diffForHumans(),
            'user'            => $this->user ? $this->user->only('id', 'name', 'phone') : null,
            'customer'        => $this->customer ? $this->customer->only('id', 'name', 'phone') : null,
            'assigned_to'     => $this->assignedTo ? $this->assignedTo->only('id', 'name', 'phone') : null,
        ];
    }
}
