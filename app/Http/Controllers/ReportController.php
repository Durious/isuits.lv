<?php

namespace App\Http\Controllers;

use Carbon\Carbon;
use App\Models\User;
use Inertia\Inertia;
use App\Models\Order;
use App\Models\Salary;
use App\Models\Expense;
use App\Models\Customer;
use Illuminate\Support\Str;
use Illuminate\Http\Request;

class ReportController extends Controller
{
    public function customer($request)
    {
        $v = $request->validate([
            'start_date'  => 'nullable|date',
            'end_date'    => 'nullable|date',
            'customer_id' => 'required|exists:customers,id',
        ]);

        $v['end_date'] = $v['end_date'] ?? date('Y-m-d') . ' 23:59:59';
        $v['start_date'] = $v['start_date'] ?? date('Y-m-d') . ' 00:00:00';

        $customer = Customer::find($v['customer_id']);

        $orders = $customer->orders()
            ->selectRaw('COUNT(id) as total_orders, SUM(grand_total) as total_amount')
            ->whereBetween('created_at', [$v['start_date'], $v['end_date']])->first();

        $report = [
            'orders'       => $orders,
            'due_payments' => $customer->payments()->due()->count(),
            'customer'     => $customer->only('id', 'name', 'phone'),
            'balance'      => $customer->journal->getBalanceInDollars(),
        ];

        return response()->json([
            'report'     => $report,
            'end_date'   => $v['end_date'],
            'start_date' => $v['start_date'],
            'title'      => 'Customer Report',
            'heading'    => 'Please review the customer report below',
        ]);
    }

    public function general($request)
    {
        $v = $request->validate([
            'start_date' => 'nullable|date',
            'end_date'   => 'nullable|date',
        ]);

        $v['end_date'] = $v['end_date'] ?? date('Y-m-d') . ' 23:59:59';
        $v['start_date'] = $v['start_date'] ?? date('Y-m-d') . ' 00:00:00';

        $expenses = Expense::selectRaw('SUM(amount) as total')
            ->whereBetween('created_at', [$v['start_date'], $v['end_date']])->first();

        $salaries = Salary::selectRaw('SUM(amount) as total')
            ->whereBetween('date', [$v['start_date'], $v['end_date']])->first();

        $orders = Order::selectRaw('SUM(grand_total) as total_amount, SUM(tax_amount) as total_tax')
            ->whereBetween('created_at', [$v['start_date'], $v['end_date']])->first();

        $report = [
            'orders'   => $orders,
            'expenses' => $expenses,
            'salaries' => $salaries,
        ];

        return response()->json([
            'report'     => $report,
            'end_date'   => $v['end_date'],
            'title'      => 'General Report',
            'start_date' => $v['start_date'],
            'heading'    => 'Please review the report below',
        ]);
    }

    public function index(Request $request)
    {
        if (method_exists($this, $request->report)) {
            if ($request->start_date && $request->end_date) {
                $diff = Carbon::parse($request->start_date)->diffInDays($request->end_date);
                if ($diff >= 93) {
                    return response(['message' => 'You only can get report for max 92 days, please reduce ' . ($diff - 92) . ' ' . Str::plural('day', $diff - 92) . '.'], 422);
                }
            } elseif ($request->end_date) {
                $request->merge(['start_date' => Carbon::parse($request->end_date)->subDays(30)->toDateString()]);
            } elseif ($request->start_date) {
                $request->merge(['end_date' => Carbon::parse($request->start_date)->addDays(30)->toDateString()]);
            } else {
                $request->merge(['end_date' => Carbon::now()->toDateString()]);
                $request->merge(['start_date' => Carbon::parse($request->end_date)->subDays(30)->toDateString()]);
            }
            return $this->{$request->report}($request);
        }

        return Inertia::render('Reports/Index', [
            'members'    => User::selectRaw('id as value, name as label')->take(20)->get(),
            'icustomers' => Customer::selectRaw('id as value, name as label, id')->take(20)->get(),
        ]);
    }

    public function tax($request)
    {
        $v = $request->validate([
            'start_date' => 'nullable|date',
            'end_date'   => 'nullable|date',
        ]);

        $v['end_date'] = $v['end_date'] ?? date('Y-m-d') . ' 23:59:59';
        $v['start_date'] = $v['start_date'] ?? date('Y-m-d') . ' 00:00:00';

        $orders = Order::with('taxes')->whereBetween('created_at', [$v['start_date'], $v['end_date']])->get();
        $order_taxes = [];
        $order_taxes_amount = [];
        foreach ($orders as $order) {
            if (!empty($order->taxes) && $order->taxes->isNotEmpty()) {
                $order_taxes[] = $order->taxes;
            }
        }
        $order_taxes = collect($order_taxes)->flatten(1)->groupBy('id');
        foreach ($order_taxes as $id => $taxes) {
            $total_tax = 0;
            foreach ($taxes as $tax) {
                $total_tax += $tax->pivot->total_amount;
            }
            $order_taxes_amount[$id] = [
                'code'  => $tax->code,
                'name'  => $tax->name,
                'total' => $total_tax,
            ];
        }

        $report = [
            'orders' => [
                'taxes'        => $order_taxes_amount,
                'total_tax'    => formatDecimal($orders->sum('tax_amount')),
                'total_amount' => formatDecimal($orders->sum('grand_total')),
            ],
        ];

        return response()->json([
            'report'     => $report,
            'title'      => 'Tax Report',
            'end_date'   => $v['end_date'],
            'start_date' => $v['start_date'],
            'heading'    => 'Please review the tax report below',
        ]);
    }

    public function user($request)
    {
        $v = $request->validate([
            'start_date' => 'nullable|date',
            'end_date'   => 'nullable|date',
            'user_id'    => 'required|exists:users,id',
        ]);

        $v['end_date'] = $v['end_date'] ?? date('Y-m-d') . ' 23:59:59';
        $v['start_date'] = $v['start_date'] ?? date('Y-m-d') . ' 00:00:00';

        $user = User::find($v['user_id']);

        $salaries = $user->salaries()
            ->selectRaw('SUM(amount) as amount')
            ->whereBetween('date', [$v['start_date'], $v['end_date']])->first();

        $expenses = $user->expenses()
            ->selectRaw('SUM(amount) as amount')
            ->whereBetween('created_at', [$v['start_date'], $v['end_date']])->first();

        $orders = $user->orders()
            ->selectRaw('COUNT(id) as total_orders, SUM(grand_total) as total_amount')
            ->whereBetween('created_at', [$v['start_date'], $v['end_date']])->first();

        $assigned = $user->assignedTo()
            ->selectRaw('COUNT(id) as total_orders, SUM(grand_total) as total_amount')
            ->whereBetween('created_at', [$v['start_date'], $v['end_date']])->first();

        $report = [
            'orders'          => $orders,
            'assigned_orders' => $assigned,
            'salaries'        => $salaries->amount,
            'expenses'        => $expenses->amount,
            'user'            => $user->only('id', 'name', 'phone'),
        ];

        return response()->json([
            'report'     => $report,
            'title'      => 'User Report',
            'end_date'   => $v['end_date'],
            'start_date' => $v['start_date'],
            'heading'    => 'Please review the user report below',
        ]);
    }
}
