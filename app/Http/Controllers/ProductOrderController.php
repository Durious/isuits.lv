<?php

namespace App\Http\Controllers;

use Inertia\Inertia;
use App\Models\Cart;
use App\Models\Product;
use App\Models\Customer;
use App\Models\Category;
use App\Models\ProductOrder;
use Illuminate\Http\Request;

class ProductOrderController extends Controller
{
    public function index()
    {
        $product_orders = array();
        $list = ProductOrder::with('account', 'carts', 'carts.product', 'customer', 'shipping_address', 'billing_address')
            ->orderBy('created_at', 'desc')
            ->get();
        foreach($list as $item) {
            $item->total_price = $item->total_price();
            array_push($product_orders, $item);
        }
        return Inertia::render('ProductOrders/Index', [
            'product_orders' => $product_orders
        ]);
    }

    public function status(Request $request, ProductOrder $order)
    {
        $v = $request->validate(['status' => 'required']);
        $order->status = $v['status'];
        $order->save();
        return back()->with('success', __('Order status has been successfully updated.'));
    }

    public function paid_status(Request $request, ProductOrder $order)
    {
        $v = $request->validate(['status' => 'required']);
        $order->paid_status = $v['status'];
        $order->save();
        return back()->with('success', __('Order payment status has been successfully updated.'));
    }

    public function edit($id)
    {
        return Inertia::render('ProductOrders/Edit', [
            'order' => ProductOrder::with('carts')
                ->with('carts.product')
                ->with('carts.product.category')
                ->with('customer')
                ->find($id),
            'icustomers' => Customer::selectRaw('id as value, name as label, id')->get(),
            'iproducts' => Product::withTrashed()->selectRaw('id as value, name as label, id, name, price, main_photo, category_id')->get(),
            'icategories' => Category::withTrashed()->with('customFields')->get()
        ]);
    }

    public function update(Request $request, ProductOrder $order)
    {
        $order->customer_id = $request->customer;
        $order->reference = $request->reference;
        $order->save();

        $cartIds = collect($request->carts)->pluck('id');
        Cart::where('product_order_id', $order->id)
            ->whereNotIn('id', $cartIds)
            ->delete();

        foreach ($request->carts as $key => $item) {
            $cart = Cart::find($item['id']) ?? new Cart();
            $cart->customization = $item['customization'];
            $cart->product_id = $item['product_id'];
            $cart->unit = $item['unit'];
            $cart->quantity = $item['quantity'];
            $cart->product_order_id = $order->id;
            $cart->save();
        }

        return back()->with('success', __('model_updated', ['model' => __choice('Product Order', 1)]));
    }
}
