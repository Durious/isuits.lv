<?php

namespace App\Http\Requests;

use Illuminate\Validation\Rule;
use Illuminate\Foundation\Http\FormRequest;

class OrderRequest extends FormRequest
{
    public function authorize()
    {
        return auth()->check();
    }

    public function rules()
    {
        return [
            'discount'      => 'nullable',
            'priority'      => 'nullable',
            'add_payment'   => 'nullable',
            'taxes'         => 'nullable|array',
            'photo'         => 'nullable|image',
            'note'          => 'nullable|max:250',
            'delivery_date' => 'required|date',
            // 'delivery_date' => 'required|date_format:Y-m-d',
            'assigned_to' => 'nullable|numeric|exists:users,id',
            // 'customer_id' => 'required|numeric|exists:customers,id',
            'customer_id' => ['required', Rule::exists('customers', 'id')->where(function ($query) {
                $query->where('account_id', auth()->user()->account_id);
            })],
            'status'    => 'required|string|in:Received,Preparing,Ready,Completed',
            'reference' => 'nullable|max:250|unique:orders,reference' . ($this->route('order') ? ',' . $this->route('order')->id . ',id' : ''),

            'services' => 'min:1|array',
            // 'services.*.id' => 'nullable',
            'services.*.id' => ['nullable', Rule::exists('services', 'id')->where(function ($query) {
                $query->where('account_id', auth()->user()->account_id);
            })],
            'services.*.qty'            => 'required|numeric',
            'services.*.price'          => 'required|numeric',
            'services.*.code'           => 'required|string',
            'services.*.name'           => 'required|string',
            'services.*.service_id'     => 'required',
            'services.*.measurement_id' => 'required|exists:measurements,id',
        ];
    }

    public function validated($key = null, $default = null)
    {
        $data = $this->validator->validated();
        if (request()->file('photo')) {
            $data['photo_path'] = request()->file('photo')->store('orders');
        }
        return $data;
    }

    public function withValidator($validator)
    {
        $validator->setImplicitAttributesFormatter(function ($attribute) {
            $attributes = explode('.', $attribute);
            if ('services' == $attributes[0]) {
                if ($attributes[2]) {
                    $relations = explode('_', $attributes[2]);
                    return 'service ' . ($attributes[1] + 1) . ' ' . $relations[0];
                }
                return 'service ' . ($attributes[1] + 1);
            }
            return $attribute;
        });
    }
}
