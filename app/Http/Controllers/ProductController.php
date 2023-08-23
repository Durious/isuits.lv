<?php

namespace App\Http\Controllers;

use App\Helpers\TableIOHelper;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;
use Validator;
use Inertia\Inertia;
use App\Models\Product;
use App\Models\Customer;
use App\Models\Category;
use Illuminate\Http\Request;
use App\Models\ProductReview;
use App\Http\Resources\ProductCollection;
use App\Models\ProductComment;
use League\Csv\Writer;

class ProductController extends Controller
{
    public function index(Request $request)
    {
        $filters = $request->all('search');
        return Inertia::render('Products/Index', [
            'products' => new ProductCollection(
                Product::filter($filters)->with('category')->paginate()->withQueryString()
            )
        ]);
    }

    public function create()
    {
        return Inertia::render('Products/Create', [
            'icategories' => Category::select(['id as value', 'name as label'])->get()
        ]);
    }

    public function store(Request $request)
    {
        $v = $this->form($request);

        $imageName = time() . '.' . $v['main_photo']->extension();
        $v['main_photo']->storeAs('public/product', $imageName);

        $product = new Product();
        $product->name = $v['name'];
        $product->price = $v['price'];
        $product->type = $v['type'];
        $product->category_id = $v['category_id'];
        $product->description = $v['description'];
        $product->main_photo = $imageName;

        $sub_photos = $request->file('sub_photos');
        if ($sub_photos && count($sub_photos) > 0) {
            $uploaded_file_names = [];
            foreach ($sub_photos as $i => $photo) {
                $filename = time() . $i . '.' . strtolower($photo->getClientOriginalExtension());
                $photo->storeAs('public/product', $filename);
                $uploaded_file_names[] = $filename;
            }
            $product->sub_photos = implode(',', $uploaded_file_names);
        }

        $product->save();

        return redirect()->route('products')->with('success', __('model_created', ['model' => __choice('Product', 1)]));
    }

    public function edit(Product $product)
    {
        // $comments = $product->product_comments()->with('customer')->get();
        // var_dump($comments);exit;
        return Inertia::render('Products/Edit', [
            'product' => [
                'id' => $product->id,
                'name' => $product->name,
                'main_photo' => $product->main_photo,
                'price' => $product->price,
                'type' => $product->type,
                'sub_photos' => $product->sub_photos,
                'description' => $product->description,
                'deleted_at' => $product->deleted_at,
                'category' => $product->category,
                'small_burst' => $product->small_burst,
                'small_waist' => $product->small_waist,
                'small_hips' => $product->small_hips,
                'medium_burst' => $product->medium_burst,
                'medium_waist' => $product->medium_waist,
                'medium_hips' => $product->medium_hips,
                'large_burst' => $product->large_burst,
                'large_waist' => $product->large_waist,
                'large_hips' => $product->large_hips,
            ],
            'icustomers' => Customer::selectRaw('id as value, name as label, id')->get(),
            'ireviews' => $product->product_reviews()->with('customer')->get(),
            'icategories' => Category::select(['id as value', 'name as label'])->get(),
            'icomments' => $product->product_comments()->with('customer')->get(),
        ]);
    }

    public function update(Request $request, Product $product)
    {
        $v = $this->form($request);
        $product->name = $v['name'];
        $product->type = $v['type'];
        $product->price = $v['price'];
        $product->category_id = $v['category_id'];
        $product->description = $v['description'];
        $product->small_burst = $v['small_burst'];
        $product->small_waist = $v['small_waist'];
        $product->small_hips = $v['small_hips'];
        $product->medium_burst = $v['medium_burst'];
        $product->medium_waist = $v['medium_waist'];
        $product->medium_hips = $v['medium_hips'];
        $product->large_burst = $v['large_burst'];
        $product->large_waist = $v['large_waist'];
        $product->large_hips = $v['large_hips'];

        if ($v['main_photo'] && is_uploaded_file($v['main_photo'])) {
            $imageName = time() . '.' . $v['main_photo']->extension();
            $v['main_photo']->storeAs('public/product', $imageName);
            $product->main_photo = $imageName;
        }

        $product->sub_photos = null;
        $sub_photos = $request->sub_photos;
        if ($sub_photos && count($sub_photos) > 0) {
            $uploaded_file_names = [];
            foreach ($sub_photos as $i => $photo) {
                if (is_uploaded_file($photo)) {
                    $filename = time() . $i . '.' . strtolower($photo->getClientOriginalExtension());
                    $photo->storeAs('public/product', $filename);
                    $uploaded_file_names[] = $filename;
                }
                if (is_string($photo)) {
                    $uploaded_file_names[] = $photo;
                }
            }
            $product->sub_photos = implode(',', $uploaded_file_names);
        }

        $product->save();

        return back()->with('success', __('model_updated', ['model' => __choice('Product', 1)]));
    }

    public function restore(Product $product)
    {
        $product->restore();
        return back()->with('success', __('model_restored', ['model' => __choice('Product', 1)]));
    }

    public function delete(Product $product)
    {
        $product->forceDelete();
        return redirect()->to('/products')->with('success', __('model_deleted', ['model' => __choice('Product', 1)]));
    }

    public function destroy(Product $product)
    {
        $product->delete();
        return back()->with('success', __('model_deleted', ['model' => __choice('Product', 1)]));
    }

    public function form(Request $request)
    {
        $rule = [
            'name' => ['required', 'max:250'],
            'category_id' => ['required', 'integer'],
            'description' => ['nullable'],
            'type' => ['required'],
            'price' => ['required', 'numeric'],
            'main_photo' => validateImage('main photo'),
            'small_burst' => ['nullable'],
            'small_waist' => ['nullable'],
            'small_hips' => ['nullable'],
            'medium_burst' => ['nullable'],
            'medium_waist' => ['nullable'],
            'medium_hips' => ['nullable'],
            'large_burst' => ['nullable'],
            'large_waist' => ['nullable'],
            'large_hips' => ['nullable'],
        ];
        if ($request->sub_photos && count($request->sub_photos) > 0) {
            $rule['sub_photos.*'] = [
                function ($attribute, $value, $fail) {
                    if (empty($value)) {
                        return $fail('The SubPhoto field is required.');
                    }
                    if (is_string($value)) {
                        return;
                    }
                    if (!is_uploaded_file($value)) {
                        return $fail('The SubPhoto must be an image file');
                    }
                    if (!in_array(strtolower($value->getClientOriginalExtension()), ['jpg', 'jpeg', 'png', 'gif'])) {
                        return $fail('The SubPhoto photo must be a JPG, JPEG, PNG, or GIF file');
                    }
                }
            ];
        }
        return $request->validate($rule);
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
            $product_review = ProductReview::find($id);
        } else {
            $old_review = ProductReview::where('product_id', $request->product_id)
                ->where('customer_id', $request->customer_id)
                ->first();
            if ($old_review) {
                return back()->with('error', __('The customer already wrote a review about this product.'));
            }
            $product_review = new ProductReview();
        }

        $product_review->rate = $request->rate;
        $product_review->title = $request->title;
        $product_review->content = $request->content;
        $product_review->product_id = $request->product_id;
        $product_review->customer_id = $request->customer_id;
        $product_review->save();

        return back()->with('success', __(($id === 0 ? 'model_created' : 'model_updated'), ['model' => __('Product Review')]));
    }

    public function delete_review($id)
    {
        $product_review = ProductReview::find($id);
        $product_review->delete();
        return back()->with('success', __('model_deleted', ['model' => __('Product Review')]));
    }

    public function export()
    {
        $fields = ['name', 'category_id', 'type', 'price', 'description', 'main_photo', 'sub_photos'];
        return TableIOHelper::export2CSV('products', $fields);
    }

    public function import(Request $request)
    {
        $result = TableIOHelper::importFromCSV($request, 'products');

        if (is_array($result)) {
            return back()->with('success', __('model_changed', ['type' => 'products', 'inserted_cnt' => $result[0], 'updated_cnt' => $result[1]]));
        } else {
            dd($result);

            return back()->with('error', 'Please select valid CSV file.');
        }
    }

    public function save_comment(Request $request, $id)
    {
        $rules = [
            'comment' => 'required',
            'customer_id' => 'required'
        ];

        $validator = Validator::make($request->all(), $rules);

        if ($validator->fails()) {
            return back()->withErrors($validator);
        }
        if ($id > 0) {
            $product_comment = ProductComment::find($id);
        } else {
            $old_comment = ProductComment::where('product_id', $request->product_id)
                ->where('customer_id', $request->customer_id)
                ->first();
            if ($old_comment) {
                return back()->with('error', __('The customer already wrote a comment about this product.'));
            }
            $product_comment = new ProductComment();
        }
        $product_comment->comment = $request->comment;
        $product_comment->product_id = $request->product_id;
        $product_comment->customer_id = $request->customer_id;
        $product_comment->save();

        return back()->with('success', __(($id === 0 ? 'model_created' : 'model_updated'), ['model' => __('Product Comment')]));
    }

    public function delete_comment($id)
    {
        $product_comment = ProductComment::find($id);
        $product_comment->delete();
        return back()->with('success', __('model_deleted', ['model' => __('Product Comment')]));
    }
}
