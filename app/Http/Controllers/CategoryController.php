<?php

namespace App\Http\Controllers;

use DB;
use Inertia\Inertia;
use App\Models\Category;
use App\Models\CustomField;
use Illuminate\Http\Request;

class CategoryController extends Controller
{
    public function index()
    {
        return Inertia::render('Categories/Index', [
            'categories' => Category::all()
        ]);
    }

    public function create()
    {
        return Inertia::render('Categories/Create', [
            'icustomFields' => CustomField::select(['id as value', DB::raw('CONCAT(tag, " - ", name) as label')])->orderBy('tag')->get()
        ]);
    }

    public function store(Request $request)
    {
        $v = $this->form($request);
        
        $imageName = time().'.'.$v['photo']->extension();
        $v['photo']->storeAs('public/category', $imageName);

        $category = new Category();
        $category->name = $v['name'];
        $category->description = $v['description'];
        $category->photo = $imageName;
        $category->save();

        $category->customFields()->sync(json_decode($request->custom_fields));

        return redirect()->route('categories')->with('success', __('model_created', ['model' => __choice('Category', 1)]));
    }

    public function edit(Category $category)
    {
        return Inertia::render('Categories/Edit', [
            'category' => [
                'id'            => $category->id,
                'name'          => $category->name,
                'photo'         => $category->photo,
                'description'   => $category->description,
                'deleted_at'    => $category->deleted_at,
                'customFields'  => $category->customFields()->select(['id as value', DB::raw('CONCAT(tag, " - ", name) as label')])->get(),
            ],
            'icustomFields' =>  CustomField::select(['id as value', DB::raw('CONCAT(tag, " - ", name) as label')])->orderBy('tag')->get()
        ]);
    }

    public function update(Request $request, Category $category)
    {
        $v = $this->form($request);

        $category->name = $v['name'];
        $category->description = $v['description'];

        if($v['photo'] && is_uploaded_file($v['photo'])) {
            $imageName = time().'.'.$v['photo']->extension();
            $v['photo']->storeAs('public/category', $imageName);
            $category->photo = $imageName;
        }

        $category->save();

        $category->customFields()->sync(json_decode($request->custom_fields));

        return back()->with('success', __('model_updated', ['model' => __choice('Category', 1)]));
    }

    public function restore(Category $category)
    {
        $category->restore();
        return back()->with('success', __('model_restored', ['model' => __choice('Category', 1)]));
    }

    public function delete(Category $category)
    {
        $category->forceDelete();
        return redirect()->to('/categories')->with('success', __('model_deleted', ['model' => __choice('Category', 1)]));
    }

    public function destroy(Category $category)
    {
        $category->delete();
        return back()->with('success', __('model_deleted', ['model' => __choice('Category', 1)]));
    }

    public function form(Request $request)
    {
        return $request->validate([
            'name'        => ['required', 'max:250'],
            'photo'       => [
                'required', 
                function($attribute, $value, $fail) {
                    if(is_string($value)) {
                        return;
                    }
                    if(!is_uploaded_file($value)) {
                        return $fail('The ' . $attribute . ' must be an image file');
                    }
                    if(!in_array(strtolower($value->getClientOriginalExtension()), ['jpg', 'jpeg', 'png', 'gif'])) {
                        return $fail('The ' . $attribute . ' must be a JPG, JPEG, PNG, or GIF file');
                    }
                }
            ],
            'description' => ['nullable'],
        ]);
    }
}
