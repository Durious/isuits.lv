<?php

namespace App\Http\Controllers;

use Inertia\Inertia;
use App\Models\Service;
use App\Models\Customer;
use App\Models\Measurement;
use Illuminate\Http\Request;
use App\Http\Requests\MeasurementRequest;
use App\Http\Resources\MeasurementCollection;

class MeasurementController extends Controller
{
    public function create()
    {
        return Inertia::render('Measurements/Create', [
            'icustomers' => Customer::selectRaw('id as value, name as label, id')->with('measurements')->take(20)->get(),
            'iservices'  => Service::select(['id as value', 'name as label', 'id'])->with('measurementFields')->active()->take(20)->get(),
        ]);
    }

    public function delete(Measurement $measurement)
    {
        $measurement->forceDelete();
        return redirect()->to('/measurements')->with('success', __('model_deleted', ['model' => __choice('Measurement', 1)]));
    }

    public function destroy(Measurement $measurement)
    {
        if ($measurement->orderServices()->exists()) {
            return back()->with('error', __('model_can_not_deleted', ['model' => __choice('Measurement', 1), 'data' => __choice('Order', 2)]));
        }
        $measurement->delete();
        return back()->with('success', __('model_deleted', ['model' => __choice('Measurement', 1)]));
    }

    public function edit(Measurement $measurement)
    {
        return Inertia::render('Measurements/Edit', [
            'measurement' => [
                'id'               => $measurement->id,
                'name'             => $measurement->name,
                'deleted_at'       => $measurement->deleted_at,
                'measurement'      => $measurement->measurement,
                'extra_attributes' => $measurement->extra_attributes,
                'customer'         => $measurement->customer()->first(['id', 'name', 'phone']),
                'service'          => $measurement->service()->withTrashed()->with('measurementFields')->first(['id', 'name', 'price']),
            ],
            'iservices' => Service::select(['id as value', 'name as label', 'id'])->with('measurementFields')->active()->take(20)->get(),
        ]);
    }

    public function index(Request $request)
    {
        $filters = $request->all('search', 'trashed');
        return Inertia::render('Measurements/Index', [
            'filters'      => $filters,
            'measurements' => new MeasurementCollection(
                Measurement::with('customer', 'service')
                    ->filter($filters)
                    ->latest()
                    ->paginate()
                    ->withQueryString()
            ),
        ]);
    }

    public function restore(Measurement $measurement)
    {
        $measurement->restore();
        return back()->with('success', __('model_restored', ['model' => __choice('Measurement', 1)]));
    }

    public function show(Request $request, Measurement $measurement, $hash)
    {
        if (md5($measurement->name) != $hash) {
            abort(404);
        }

        $measurement->load(['account', 'customer', 'user:id,name']);
        if ($request->ajax) {
            return $measurement;
        }
        return Inertia::render('Measurements/Show', [
            'modal'       => false,
            'measurement' => $measurement->toArray(),
        ]);
    }

    public function store(MeasurementRequest $request)
    {
        $v = $request->validated();
        $m = Measurement::create($v);
        if ($v['ajax'] ?? false) {
            return response()->json($m);
        }
        return redirect()->route('measurements')->with('success', __('model_created', ['model' => __choice('Measurement', 1)]));
    }

    public function update(MeasurementRequest $request, Measurement $measurement)
    {
        $v = $request->validated();
        $measurement->update($v);
        return back()->with('success', __('model_updated', ['model' => __choice('Measurement', 1)]));
    }
}
