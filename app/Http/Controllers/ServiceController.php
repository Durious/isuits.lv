<?php

namespace App\Http\Controllers;

use App\Helpers\TableIOHelper;
use App\Models\Customer;
use App\Models\ServiceReview;
use Inertia\Inertia;
use App\Models\Service;
use Illuminate\Http\Request;
use App\Http\Requests\ServiceRequest;
use App\Http\Resources\ServiceCollection;
use Validator;

class ServiceController extends Controller
{
    public function create()
    {
        return Inertia::render('Services/Form');
    }

    public function delete(Service $service)
    {
        $service->measurementFields()->dissociate();
        $service->forceDelete();
        return redirect()->to('/services')->with('success', __('model_deleted', ['model' => __choice('Service', 1)]));
    }

    public function destroy(Service $service)
    {
        if ($service->orderServices()->exists()) {
            return back()->with('error', __('model_can_not_deleted', ['model' => __choice('Service', 1), 'data' => __choice('Order', 2)]));
        }
        $service->delete();
        return back()->with('success', __('model_deleted', ['model' => __choice('Service', 1)]));
    }

    public function edit(Service $service)
    {
        return Inertia::render('Services/Form', ['service' => $service, 'icustomers' => Customer::selectRaw('id as value, name as label, id')->get(),
            'ireviews' => $service->service_reviews()->with('customer')->get(),]);
    }

    public function index(Request $request)
    {
        $filters = $request->all('search', 'trashed');
        return Inertia::render('Services/Index', [
            'filters' => $filters,
            'services' => new ServiceCollection(
                Service::filter($filters)->orderBy('id', 'desc')->paginate()->withQueryString()
            ),
        ]);
    }

    public function restore(Service $service)
    {
        $service->restore();
        return back()->with('success', __('model_restored', ['model' => __choice('Service', 1)]));
    }

    public function store(ServiceRequest $request)
    {
        $v = $request->validated();
        if ($v['photo'] && is_uploaded_file($v['photo'])) {
            $imageName = time() . '.' . $v['photo']->extension();
            $v['photo']->storeAs('public/service', $imageName);
            $v['photo'] = $imageName;
        }

        Service::create($v);
        return redirect()->route('services')->with('success', __('model_created', ['model' => __choice('Service', 1)]));
    }

    public function update(ServiceRequest $request, Service $service)
    {
        $v = $request->validated();
        if ($v['photo'] && is_uploaded_file($v['photo'])) {
            $imageName = time() . '.' . $v['photo']->extension();
            $v['photo']->storeAs('public/service', $imageName);
            $v['photo'] = $imageName;
        }
        $service->update($v);

        return back()->with('success', __('model_updated', ['model' => __choice('Service', 1)]));
    }

    public function import(Request $request)
    {
        $result = TableIOHelper::importFromCSV($request, 'services');

        if (is_array($result)) {
            return back()->with('success', __('model_changed', ['type' => 'services', 'inserted_cnt' => $result[0], 'updated_cnt' => $result[1]]));
        } else {
            return back()->with('error', 'Please select valid CSV file.');
        }
    }

    public function export()
    {
        $fields = ['name', 'code', 'price', 'description', 'active', 'photo', 'account_id',];
        return TableIOHelper::export2CSV('services', $fields);
    }

    public function delete_review($id)
    {
        $service_review = ServiceReview::find($id);
        $service_review->delete();
        return back()->with('success', __('model_deleted', ['model' => __('Service Review')]));
    }

    public function save_review(Request $request, $id)
    {
        $rules = [
            'rate' => 'required',
            'title' => 'required',
            'content' => 'required',
            'customer_id' => 'required'
        ];

        $validator = Validator::make($request->all(), $rules);

        if ($validator->fails()) {
            return back()->withErrors($validator);
        }

        if ($id > 0) {
            $service_review = ServiceReview::find($id);
        } else {
            $old_review = ServiceReview::where('service_id', $request->service_id)
                ->where('customer_id', $request->customer_id)
                ->first();
            if ($old_review) {
                return back()->with('error', __('The customer already wrote a review about this service.'));
            }
            $service_review = new ServiceReview();
        }

        $service_review->rate = $request->rate;
        $service_review->title = $request->title;
        $service_review->content = $request->content;
        $service_review->service_id = $request->service_id;
        $service_review->customer_id = $request->customer_id;
        $service_review->save();

        return back()->with('success', __(($id === 0 ? 'model_created' : 'model_updated'), ['model' => __('Service Review')]));
    }
}
