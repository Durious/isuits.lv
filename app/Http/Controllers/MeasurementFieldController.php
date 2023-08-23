<?php

namespace App\Http\Controllers;

use Inertia\Inertia;
use App\Models\Service;
use Illuminate\Http\Request;
use App\Models\MeasurementField;
use App\Http\Resources\MeasurementFieldCollection;

class MeasurementFieldController extends Controller
{
    public function create()
    {
        return Inertia::render('MeasurementFields/Create', [
            'iservices' => Service::select(['id as value', 'name as label'])->active()->take(20)->get(),
        ]);
    }

    public function delete(MeasurementField $measurement_field)
    {
        $measurement_field->forceDelete();
        return redirect()->to('/measurement_fields')->with('success', __('model_deleted', ['model' => __choice('Measurement Field', 1)]));
    }

    public function destroy(MeasurementField $measurement_field)
    {
        if ($measurement_field->measurements()->exists()) {
            return back()->with('error', __('model_can_not_deleted', ['model' => __choice('Measurement', 1), 'data' => __choice('Customer', 2)]));
        }
        $measurement_field->delete();
        return back()->with('success', __('model_deleted', ['model' => __choice('Measurement Field', 1)]));
    }

    public function edit(MeasurementField $measurement_field)
    {
        return Inertia::render('MeasurementFields/Edit', [
            'field' => [
                'id'          => $measurement_field->id,
                'type'        => $measurement_field->type,
                'name'        => $measurement_field->name,
                'order'       => $measurement_field->order,
                'options'     => $measurement_field->options,
                'required'    => $measurement_field->required,
                'deleted_at'  => $measurement_field->deleted_at,
                'description' => $measurement_field->description,
                'services'    => $measurement_field->services()->get(['id as value', 'name as label']),
            ],
            'iservices' => Service::select(['id as value', 'name as label'])->active()->take(20)->get(),
        ]);
    }

    public function form(Request $request, $model = null)
    {
        return $request->validate([
            'services'        => 'array|min:1',
            'description'     => 'nullable|string',
            'order'           => 'nullable|integer',
            'required'        => 'nullable|boolean',
            'type'            => 'required|in:Text,Select,Textarea,Checkbox,Radio',
            'options.*.value' => 'required_if:type,Select|required_if:type,Checkbox|required_if:type,Radio',
            'name'            => 'required|max:50|unique:measurement_fields,name' . ($model ? ',' . $model->id : ''),
        ]);
    }

    public function index(Request $request)
    {
        $filters = $request->all('search', 'trashed');
        return Inertia::render('MeasurementFields/Index', [
            'filters'            => $filters,
            'measurement_fields' => new MeasurementFieldCollection(
                MeasurementField::filter($filters)->orderBy('order')->paginate()->withQueryString()
            ),
        ]);
    }

    public function restore(MeasurementField $measurement_field)
    {
        $measurement_field->restore();
        return back()->with('success', __('model_restored', ['model' => __choice('Measurement Field', 1)]));
    }

    public function store(Request $request)
    {
        $v = $this->form($request);
        $m = MeasurementField::create($v);
        $m->services()->sync($v['services']);
        return redirect()->route('measurement_fields')->with('success', __('model_created', ['model' => __choice('Measurement Field', 1)]));
    }

    public function update(Request $request, MeasurementField $measurement_field)
    {
        $v = $this->form($request, $measurement_field);
        $measurement_field->update($v);
        $measurement_field->services()->sync($v['services']);
        return back()->with('success', __('model_updated', ['model' => __choice('Measurement Field', 1)]));
    }
}
