<?php

namespace App\Http\Controllers\Customer;

use DB;
use Auth;
use App\Models\Product;
use App\Models\Category;
use Illuminate\Http\Request;
use App\Models\ProductReview;
use App\Models\ProductComment;
use App\Models\TagBackground;
use App\Http\Controllers\Controller;

class ProductController extends Controller
{
    public function index($type, Request $request)
    {
        $category = $request->category;
        $sort = $request->sort;
        $price = $request->price;
        $search = $request->search ?? '';

        $categories = Category::all();
        $products = Product::where('name', 'like', '%' . $search . '%')
            ->with('category');

        if ($type !== 'all') {
            $products = $products->where('type', $type);
        }
        if (isset($category)) {
            $products = $products->where('category_id', $category);
        }
        if (isset($sort)) {
            $products = $products->orderBy($sort, $request->sort_dir ?? 'asc');
        }
        if (isset($price)) {
            $priceOptionList = [
                [0, 20],
                [20, 60],
                [60, 100],
                [100, 150],
                [150, 200],
                [200]
            ];
            $priceOption = $priceOptionList[$price];
            $products = $products->whereBetween('price', [$priceOption[0], $priceOption[1] ?? PHP_INT_MAX]);
        }

        $products = $products->paginate()->withQueryString();

        return view('customer.products.index', compact(
            'category',
            'type',
            'sort',
            'search',
            'price',
            'products',
            'categories'
        ));
    }

    public function details($product)
    {
        $product = Product::with('category')->with('product_reviews')->with('product_comments')->where('id', $product)->first();
        
        $product->sub_photos = explode(',', $product->sub_photos ?? '');
        $custom_fields = Category::find($product->category_id)->customFields()->get();
        $tag_list = array();
        $tag_group_list = array();
        $tag_preview_list = array_column(TagBackground::all()->toArray(), 'background', 'name');
        foreach ($custom_fields as $custom_field) {
            if (!array_key_exists('_' . $custom_field->tag, $tag_list)) {
                $tag_list['_' . $custom_field->tag] = array();
                array_push($tag_group_list, [
                    'name' => '_' . $custom_field->tag,
                    'preview' => $tag_preview_list[$custom_field->tag] ?? null
                ]);
            }
            array_push($tag_list['_' . $custom_field->tag], $custom_field);
        }
        $related = Product::where('type', $product->type)->take(5)->get();
        return view('customer.products.details', compact(
            'product',
            'tag_list',
            'tag_group_list',
            'related'
        ));
    }

    public function mark_favorite(Request $request)
    {
        $product = Product::find($request->product_id);
        $user = Auth::guard('customer')->user();

        if ($product->likedBy->contains($user)) {
            $user->likes()->detach($product->id);
        } else {
            $user->likes()->attach($product->id);
        }

        return response()->json(['success' => true]);
    }

    public function remove_favorites($product_id)
    {
        $product = Product::find($product_id);
        $user = Auth::guard('customer')->user();

        if ($product->likedBy->contains($user)) {
            $user->likes()->detach($product->id);
        }

        return view('customer.profile.favorites');
    }

    public function save_review(Request $request)
    {
        $product_review = ProductReview::where('product_id', $request->product_id)
            ->where('customer_id', Auth::guard('customer')->user()->id)
            ->first();
        if ($product_review) {
            return back()->with('error', __('You already wrote a review about this product.'));
        }
        $product_review = new ProductReview();
        $product_review->rate = $request->rate;
        $product_review->title = $request->title;
        $product_review->content = $request->content;
        $product_review->product_id = $request->product_id;
        $product_review->customer_id = Auth::guard('customer')->user()->id;
        $product_review->save();
        return back()->with('message', __('Saved your review successfully.'));
    }

    public function save_comment(Request $request) {
        $product_comment = ProductComment::where('product_id', $request->product_id)
            ->where('customer_id', Auth::guard('customer')->user()->id)
            ->first();
        if ($product_comment) {
            return back()->with('error', __('You already wrote a comment about this product.'));
        }
        $product_comment = new ProductComment();
        $product_comment->comment = $request->comment;
        $product_comment->product_id = $request->product_id;
        $product_comment->customer_id = Auth::guard('customer')->user()->id;
        $product_comment->save();
        return back()->with('message', __('Saved your comment successfully.'));
    }
}
