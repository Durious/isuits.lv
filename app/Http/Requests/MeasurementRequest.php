<?php

namespace App\Http\Requests;

use App\Models\Service;
use Illuminate\Validation\Rule;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\ValidationException;

class MeasurementRequest extends FormRequest
{
    public function authorize()
    {
        return auth()->check();
    }

    public function rules()
    {
        return [
            'ajax'             => 'nullable',
            'measurement'      => 'nullable',
            'extra_attributes' => 'nullable',
            'service_id'       => ['required', Rule::exists('services', 'id')->where(function ($query) {
                $query->where('account_id', auth()->user()->account_id);
            })],
            'customer_id' => ['required', Rule::exists('customers', 'id')->where(function ($query) {
                $query->where('account_id', auth()->user()->account_id);
            })],
            'name' => 'required|max:250|unique:measurements,name' . ($this->route('measurement') ? ',' . $this->route('measurement')->id . ',id' : ''),
        ];
    }

    public function validated($key = null, $default = null)
    {
        $data = $this->validator->validated();
        $service = Service::with('measurementFields')->find($data['service_id']);
        if ($service->measurementFields) {
            $errors = [];
            foreach ($service->measurementFields as $r => $field) {
                $c = false;
                if ('Checkbox' == $field->name) {
                    $c = true;
                    if (isset($data['extra_attributes'][$r])) {
                        $cbs = json_decode($data['extra_attributes'][$r][$field->name]);
                        foreach ($cbs as $key => $value) {
                            if (!empty($value)) {
                                $c = false;
                            }
                        }
                    }
                }
                if ($c || ($field->required && empty($data['extra_attributes'][$r][$field->name]))) {
                    $errors[$field->name] = __('validation.required', ['attribute' => mb_strtolower($field->name)]);
                }
            }
            if (!empty($errors)) {
                throw ValidationException::withMessages($errors);
            }
        }
        return $data;
    }
}
