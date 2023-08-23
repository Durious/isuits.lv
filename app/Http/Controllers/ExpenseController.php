<?php

namespace App\Http\Controllers;

use Inertia\Inertia;
use App\Models\Expense;
use Illuminate\Http\Request;
use App\Http\Resources\ExpenseCollection;

class ExpenseController extends Controller
{
    protected $fillable = ['name', 'amount', 'user_id', 'description', 'account_id'];

    public function create()
    {
        return Inertia::render('Expenses/Create');
    }

    public function delete(Expense $expense)
    {
        $expense->forceDelete();
        return redirect()->to('/expenses')->with('success', __('model_deleted', ['model' => __choice('Expense', 1)]));
    }

    public function destroy(Expense $expense)
    {
        $expense->delete();
        return back()->with('success', __('model_deleted', ['model' => __choice('Expense', 1)]));
    }

    public function edit(Expense $expense)
    {
        $this->authorize('update', $expense);
        return Inertia::render('Expenses/Edit', [
            'expense' => [
                'id'          => $expense->id,
                'name'        => $expense->name,
                'amount'      => $expense->amount,
                'description' => $expense->description,
                'deleted_at'  => $expense->deleted_at,
                'user'        => $expense->user()->first(['id', 'name', 'phone']),
            ],
        ]);
    }

    public function form(Request $request)
    {
        return $request->validate([
            'name'        => ['required', 'max:250'],
            'amount'      => ['required', 'numeric'],
            'description' => ['nullable', 'max:250'],
        ]);
    }

    public function index(Request $request)
    {
        $filters = $request->all('search', 'start_date', 'end_date', 'trashed');
        return Inertia::render('Expenses/Index', [
            'filters'  => $filters,
            'expenses' => new ExpenseCollection(
                Expense::filter($filters)->latest()->paginate()->withQueryString()
            ),
        ]);
    }

    public function restore(Expense $expense)
    {
        $expense->restore();
        return back()->with('success', __('model_restored', ['model' => __choice('Expense', 1)]));
    }

    public function store(Request $request)
    {
        $v = $this->form($request);
        Expense::create($v);
        return redirect()->route('expenses')->with('success', __('model_created', ['model' => __choice('Expense', 1)]));
    }

    public function update(Request $request, Expense $expense)
    {
        $this->authorize('update', $expense);
        $v = $this->form($request);
        $expense->update($v);
        return back()->with('success', __('model_updated', ['model' => __choice('Expense', 1)]));
    }
}
