<?php

namespace App\Http\Controllers;

use Inertia\Inertia;
use App\Helpers\ChartHelper;
use Illuminate\Http\Request;

class DashboardController extends Controller
{
    public function form(Request $request)
    {
        return $request->validate([
            'month' => 'nullable|integer|date_format:n',
            'year'  => 'nullable|integer|date_format:Y',
        ]);
    }

    public function index(Request $request)
    {
        $this->form($request);
        $cahrt = new ChartHelper($request->get('month'), $request->get('year'));
        return Inertia::render('Dashboard/Index', [
            'data'      => $cahrt->data(),
            'due_today' => $cahrt->dueOrders(),
            'new_today' => $cahrt->newOrders(),
            'chart'     => ['year' => $cahrt->year(), 'month' => $cahrt->month()],
        ]);
    }

    public function monthChart(Request $request)
    {
        $this->form($request);
        $cahrt = new ChartHelper($request->get('month'), $request->get('year'));
        return response()->json(['chart' => ['month' => $cahrt->month()]]);
    }

    public function yearChart(Request $request)
    {
        $this->form($request);
        $cahrt = new ChartHelper($request->get('month'), $request->get('year'));
        return response()->json(['chart' => ['year' => $cahrt->year(), 'month' => $cahrt->month()]]);
    }
}
