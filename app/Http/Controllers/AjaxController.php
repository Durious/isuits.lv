<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\Service;
use App\Models\Customer;
use App\Models\Category;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\File;

class AjaxController extends Controller
{
    public function customers(Request $request)
    {
        $customers = Customer::select('name as label', 'id as value', 'id');
        if (1 == $request->measurements) {
            $customers = $customers->with('measurements');
        }
        $customers = $customers->where('name', 'like', '%' . $request->search . '%')
            ->orWhere('phone', 'like', '%' . $request->search . '%')->take(20)->get();
        return response()->json($customers);
    }

    public function fields(Request $request, Service $service)
    {
        return response()->json($service->measurementFields);
    }

    public function locale($locale)
    {
        $langFiles = collect(json_decode(File::get(lang_path('languages.json')))->available)->pluck('value')->all();
        if (!in_array($locale, $langFiles)) {
            return back()->with('error', __('Language is not available yet.'));
        }
        App::setLocale($locale);
        session(['language' => $locale]);
        return back()->with('message', __('Language has been changed.'));
    }

    public function services(Request $request)
    {
        $services = Service::query()->select(1 == $request->full ? '*' : 'name as label', 'id as value', 'id')
            ->active()
            ->where('code', 'like', '%' . $request->search . '%')
            ->orWhere('name', 'like', '%' . $request->search . '%');
        if ($request->with_fields) {
            $services->with('measurementFields');
        }
        return response()->json($services->take(20)->get());
    }

    public function categories(Request $request)
    {
        $categories = Category::select('name as label', 'id as value', 'id');
        $categories = $categories->where('name', 'like', '%' . $request->search . '%')->get();
        return response()->json($categories);
    }

    public function staff(Request $request)
    {
        if (!$request->user()->owner) {
            return [];
        }
        $staff = User::selectRaw(1 == $request->with_salaries ? 'id as value, name as label, salary' : 'id as value, name as label')
            ->staff()->where('name', 'like', '%' . $request->search . '%')
            ->orWhere('phone', 'like', '%' . $request->search . '%')->take(20)->get();
        return response()->json($staff);
    }

    public function users(Request $request)
    {
        if (!$request->user()->owner) {
            return [];
        }
        $staff = User::selectRaw(1 == $request->with_salaries ? 'id as value, name as label, salary' : 'id as value, name as label')
            ->where('name', 'like', '%' . $request->search . '%')
            ->orWhere('phone', 'like', '%' . $request->search . '%')->take(20)->get();
        return response()->json($staff);
    }
}
