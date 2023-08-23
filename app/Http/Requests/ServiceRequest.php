<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class ServiceRequest extends FormRequest
{
    public function authorize()
    {
        return auth()->check();
    }

    public function rules()
    {
        return [
            'name'        => 'required|max:250',
            'price'       => 'required|numeric',
            'active'      => 'nullable|boolean',
            'description' => 'nullable|max:250',
            'code'        => 'required|max:25|unique:services,code,' . ($this->id ?? ''),
            'photo'       => [
                'nullable', 
                function($attribute, $value, $fail) {
                    if(is_string($value)) {
                        return;
                    }
                    if(!is_uploaded_file($value)) {
                        return $fail('The ' . $attribute . ' must be an image file');
                    }
                    if(!in_array(strtolower($value->getClientOriginalExtension()), ['jpg', 'jpeg', 'png', 'gif'])) {
                        return $fail('The ' . $attribute . ' must be a JPG, JPEG, PNG, or GIF file');
                    }
                }
            ]
        ];
    }
}
