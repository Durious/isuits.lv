<?php

namespace App\Helpers;

use Carbon\Carbon;
use App\Models\Order;
use App\Models\Salary;
use App\Models\Expense;
use App\Models\Customer;
use Illuminate\Support\Arr;
use Illuminate\Support\Facades\DB;

class ChartHelper
{
    protected $month;

    protected $year;

    public function __construct($month = null, $year = null)
    {
        $this->month = $month ?: date('n');
        $this->year  = $year ?: date('Y');
    }

    protected function prepareMonthArray($array, $date)
    {
        $days = $date->daysInMonth;
        $data = $array->mapWithKeys(function ($item) {
            return [$item['date'] => $item['total']];
        })->toArray();
        for ($i = 1; $i <= $days; $i++) {
            $key        = Carbon::parse($date->format('Y-m-') . ($i < 10 ? '0' . $i : $i))->format('Y-m-d');
            $data[$key] = Arr::has($data, $key) ? (0 + $data[$key]) : 0;
        }
        return $data;
    }

    protected function prepareYearArray($array, $date)
    {
        $data = $array->mapWithKeys(function ($item) {
            return [$item['year'] . ($item['month'] < 10 ? '-0' : '-') . (int) $item['month'] => $item['total']];
        })->toArray();
        for ($i = 1; $i <= 12; $i++) {
            $key        = Carbon::parse($date->format('Y-') . ($i < 10 ? '0' . $i : $i))->format('Y-m');
            $data[$key] = Arr::has($data, $key) ? (0 + $data[$key]) : 0;
        }
        return $data;
    }

    public function data()
    {
        $end_date   = now()->endOfDay();
        $start_date = now()->subMonth()->startOfDay();

        $dailyExpenses = Expense::selectRaw(DB::Raw('COUNT(*) as total_count, SUM(amount) as total_amount'))
            ->whereBetween('created_at', [$start_date, $end_date])->first();
        $dailyOrders = Order::selectRaw(DB::Raw('COUNT(*) as total_count, SUM(total) as total_amount'))
            ->whereBetween('created_at', [$start_date, $end_date])->first();
        $dailySalaries = Salary::selectRaw(DB::Raw('COUNT(*) as total_count, SUM(amount) as total_amount'))
            ->whereBetween('date', [$start_date, $end_date])->first();
        $customers = Customer::whereBetween('created_at', [$start_date, $end_date])->count();

        return [
            'customers' => $customers,
            'order'     => $dailyOrders,
            'salary'    => $dailySalaries,
            'expense'   => $dailyExpenses,
            'end'       => $end_date->format('jS M'),
            'start'     => $start_date->format('jS M'),
        ];
    }

    public function dueOrders()
    {
        return Order::with(['customer:id,name,phone', 'user:id,name,phone'])->whereDate('delivery_date', now())->orderBy('delivery_date')->get();
    }

    public function month()
    {
        $this->month = $this->month > 9 ? $this->month : '0' . $this->month;
        $end_date    = Carbon::parse($this->year . '-' . $this->month . '-01')->endOfMonth();
        $start_date  = Carbon::parse($this->year . '-' . $this->month . '-01')->startOfMonth();

        if (env('DB_CONNECTION') == 'sqlite') {
            $monthlyExpenses = Expense::selectRaw(DB::Raw("strftime('%Y-%m-%d', created_at) as date, SUM(amount) as total"))
            ->whereBetween('created_at', [$start_date, $end_date])->groupBy(DB::raw("strftime('%Y-%m-%d', created_at)"))->orderBy('date')->get();
            $monthlyOrder = Order::selectRaw(DB::Raw("strftime('%Y-%m-%d', created_at) as date, SUM(grand_total) as total"))
            ->whereBetween('created_at', [$start_date, $end_date])->groupBy(DB::raw("strftime('%Y-%m-%d', created_at)"))->orderBy('date')->get();
            $monthlySalaries = Salary::selectRaw(DB::Raw("strftime('%Y-%m-%d', date) as date, SUM(amount) as total"))
            ->whereBetween('date', [$start_date, $end_date])->groupBy(DB::raw("strftime('%Y-%m-%d', date)"))->orderBy('date')->get();
        } else {
            $monthlyExpenses = Expense::selectRaw(DB::Raw('DATE(created_at) as date, SUM(amount) as total'))
            ->whereBetween('created_at', [$start_date, $end_date])->groupBy(DB::raw('DATE(created_at)'))->orderBy('date')->get();
            $monthlyOrder = Order::selectRaw(DB::Raw('DATE(created_at) as date, SUM(grand_total) as total'))
            ->whereBetween('created_at', [$start_date, $end_date])->groupBy(DB::raw('DATE(created_at)'))->orderBy('date')->get();
            $monthlySalaries = Salary::selectRaw(DB::Raw('DATE(date) as date, SUM(amount) as total'))
            ->whereBetween('date', [$start_date, $end_date])->groupBy(DB::raw('DATE(date)'))->orderBy('date')->get();
        }

        return [
            'order'   => $this->prepareMonthArray($monthlyOrder, $start_date),
            'salary'  => $this->prepareMonthArray($monthlySalaries, $start_date),
            'expense' => $this->prepareMonthArray($monthlyExpenses, $start_date),
        ];
    }

    public function newOrders()
    {
        return Order::with(['customer:id,name,phone', 'user:id,name,phone'])->whereBetween('created_at', [now()->startOfDay(), now()->endOfDay()])->latest()->get();
    }

    public function year()
    {
        $end_date   = Carbon::parse($this->year . '-01-01')->endOfYear();
        $start_date = Carbon::parse($this->year . '-01-01')->startOfYear();

        if (env('DB_CONNECTION') == 'sqlite') {
            $monthlyExpenses = Expense::selectRaw(DB::Raw("strftime('%m', created_at) as month, strftime('%Y', created_at) as year, SUM(amount) as total"))
            ->whereBetween('created_at', [$start_date, $end_date])->groupBy(DB::raw("strftime('%Y', created_at), strftime('%m', created_at)"))->orderBy(DB::raw("strftime('%Y-%m', created_at)"))->get();
            $monthlyOrder = Order::selectRaw(DB::Raw("strftime('%m', created_at) as month, strftime('%Y', created_at) as year, SUM(grand_total) as total"))
            ->whereBetween('created_at', [$start_date, $end_date])->groupBy(DB::raw("strftime('%Y', created_at), strftime('%m', created_at)"))->orderBy(DB::raw("strftime('%Y-%m', created_at)"))->get();
            $monthlySalaries = Salary::selectRaw(DB::Raw("strftime('%m', date) as month, strftime('%Y', date) as year, SUM(amount) as total"))
            ->whereBetween('date', [$start_date, $end_date])->groupBy(DB::raw("strftime('%Y', date), strftime('%m', date)"))->orderBy(DB::raw("strftime('%Y-%m', date)"))->get();
        } else {
            $monthlyExpenses = Expense::selectRaw(DB::Raw('MONTH(created_at) as month, YEAR(created_at) as year, SUM(amount) as total'))
            ->whereBetween('created_at', [$start_date, $end_date])->groupBy(DB::raw('YEAR(created_at), MONTH(created_at)'))->orderBy('year')->orderBy('month')->get();
            $monthlyOrder = Order::selectRaw(DB::Raw('MONTH(created_at) as month, YEAR(created_at) as year, SUM(grand_total) as total'))
            ->whereBetween('created_at', [$start_date, $end_date])->groupBy(DB::raw('YEAR(created_at), MONTH(created_at)'))->orderBy('year')->orderBy('month')->get();
            $monthlySalaries = Salary::selectRaw(DB::Raw('MONTH(date) as month, YEAR(date) as year, SUM(amount) as total'))
            ->whereBetween('date', [$start_date, $end_date])->groupBy(DB::raw('YEAR(date), MONTH(date)'))->orderBy('year')->orderBy('month')->get();
        }

        return [
            'order'   => $this->prepareYearArray($monthlyOrder, $start_date),
            'salary'  => $this->prepareYearArray($monthlySalaries, $start_date),
            'expense' => $this->prepareYearArray($monthlyExpenses, $start_date),
        ];
    }
}
