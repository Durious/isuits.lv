<?php

namespace App\Http\Controllers;

use App\Models\User;
use Inertia\Inertia;
use App\Models\Salary;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;
use Illuminate\Support\Facades\Artisan;
use App\Http\Resources\SalaryCollection;

class SalaryController extends Controller
{
    protected $fillable = ['date', 'amount', 'user_id', 'description', 'staff_id'];

    public function create()
    {
        return Inertia::render('Salaries/Create', [
            'members' => User::selectRaw('id as value, name as label, salary')->staff()->take(20)->get(),
        ]);
    }

    public function delete(Salary $salary)
    {
        $salary->forceDelete();
        return redirect()->to('/salaries')->with('success', __('model_deleted', ['model' => __choice('Salary', 1)]));
    }

    public function destroy(Salary $salary)
    {
        $salary->delete();
        return back()->with('success', __('model_deleted', ['model' => __choice('Salary', 1)]));
    }

    public function edit(Salary $salary)
    {
        return Inertia::render('Salaries/Edit', [
            'salary' => [
                'id'          => $salary->id,
                'date'        => $salary->date,
                'amount'      => $salary->amount,
                'advance'     => $salary->advance,
                'description' => $salary->description,
                'settled_on'  => $salary->settled_on,
                'deleted_at'  => $salary->deleted_at,
                'staff'       => $salary->staff()->first(['id', 'name', 'phone']),
            ],
            'members' => User::selectRaw('id as value, name as label, salary')->staff()->take(20)->get(),
        ]);
    }

    public function form(Request $request)
    {
        return $request->validate([
            'advance'     => 'nullable|boolean',
            'amount'      => 'required|numeric',
            'description' => 'nullable|max:250',
            'date'        => 'required|date_format:Y-m-d',
            'settled_on'  => 'nullable|date_format:Y-m-d',
            // 'staff_id'    => 'required|exists:users,id',
            'staff_id' => ['required', Rule::exists('users', 'id')->where(function ($query) {
                $query->where('account_id', auth()->user()->account_id);
            })],
        ]);
    }

    public function generate(Salary $salary)
    {
        Artisan::call('salaries:generate');
        return back()->with('success', trim(Artisan::output()));
    }

    public function index(Request $request)
    {
        $filters = $request->all('search', 'trashed');
        return Inertia::render('Salaries/Index', [
            'filters'   => $filters,
            'salaries'  => new SalaryCollection(
                Salary::filter($filters)->orderByDesc('date')->latest()->paginate()->withQueryString()
            ),
        ]);
    }

    public function restore(Salary $salary)
    {
        $salary->restore();
        return back()->with('success', __('model_restored', ['model' => __choice('Salary', 1)]));
    }

    public function store(Request $request)
    {
        $v = $this->form($request);
        Salary::create($v);
        return redirect()->route('salaries')->with('success', __('model_created', ['model' => __choice('Salary', 1)]));
    }

    public function update(Request $request, Salary $salary)
    {
        $v = $this->form($request);
        $salary->update($v);
        return back()->with('success', __('model_updated', ['model' => __choice('Salary', 1)]));
    }
}
