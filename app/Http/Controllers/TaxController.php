<?php

namespace App\Http\Controllers;

use App\Models\Tax;
use Inertia\Inertia;
use Illuminate\Http\Request;
use App\Http\Resources\TaxCollection;

class TaxController extends Controller
{
    public function create()
    {
        return Inertia::render('Taxes/Create');
    }

    public function delete(Tax $tax)
    {
        $tax->forceDelete();
        return redirect()->to('/taxes')->with('success', __('model_deleted', ['model' => __choice('Tax', 1)]));
    }

    public function destroy(Tax $tax)
    {
        if ($tax->orders()->exists()) {
            return back()->with('error', __('model_can_not_deleted', ['model' => __choice('Tax', 1), 'data' => __choice('Order', 2)]));
        }
        $tax->delete();
        return back()->with('success', __('model_deleted', ['model' => __choice('Tax', 1)]));
    }

    public function edit(Tax $tax)
    {
        return Inertia::render('Taxes/Edit', [
            'tax' => [
                'id'          => $tax->id,
                'code'        => $tax->code,
                'name'        => $tax->name,
                'rate'        => $tax->rate,
                'state'       => $tax->state,
                'same'        => $tax->same,
                'compound'    => $tax->compound,
                'description' => $tax->description,
                'deleted_at'  => $tax->deleted_at,
            ],
        ]);
    }

    public function form(Request $request, $model = null)
    {
        return $request->validate([
            'name'        => 'required|max:250',
            'rate'        => 'required|numeric',
            'state'       => 'nullable|boolean',
            'same'        => 'nullable|boolean',
            'compound'    => 'nullable|boolean',
            'description' => 'nullable|max:250',
            'code'        => 'required|max:25|unique:taxes,code' . ($model ? ',' . $model->id : ''),
        ]);
    }

    public function index(Request $request)
    {
        $filters = $request->all('search', 'trashed');
        return Inertia::render('Taxes/Index', [
            'filters'   => $filters,
            'taxes'     => new TaxCollection(
                Tax::filter($filters)->orderBy('name')->paginate()->withQueryString()
            ),
        ]);
    }

    public function restore(Tax $tax)
    {
        $tax->restore();
        return back()->with('success', __('model_restored', ['model' => __choice('Tax', 1)]));
    }

    public function store(Request $request)
    {
        $v = $this->form($request);
        Tax::create($v);
        // $request->user()->account->taxes()->create($v);
        return redirect()->route('taxes')->with('success', __('model_created', ['model' => __choice('Tax', 1)]));
    }

    public function update(Request $request, Tax $tax)
    {
        $v = $this->form($request, $tax);
        $tax->update($v);
        return back()->with('success', __('model_updated', ['model' => __choice('Tax', 1)]));
    }
}
