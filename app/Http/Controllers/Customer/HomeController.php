<?php

namespace App\Http\Controllers\Customer;

use DB;
use App\Models\Cart;
use App\Models\Product;
use App\Models\Category;
use Illuminate\Http\Request;
use App\Models\FrontendSetting;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\File;
use App\Http\Controllers\Controller;
use App\Models\Account;

use App\Helpers\Env;
use DateTime;
use DateTimeZone;

class HomeController extends Controller
{
    public function index() {
        $top_picks = Cart::select('products.*', DB::raw('count(*) as total'))
            ->join('products', 'carts.product_id', '=', 'products.id')
            ->groupBy('products.id')
            ->orderBy('total', 'desc')
            ->take(4)
            ->get();
        $frontend_setting = FrontendSetting::first();
        foreach ($top_picks as $value) {
            $value->likedBy = Product::find($value->id)->likedBy;
        }
        return view('customer.index')
            ->with('categories', Category::all())
            ->with('frontend_setting', $frontend_setting)
            ->with('top_picks', $top_picks);
    }

    public function about() {
        $frontend_setting = FrontendSetting::first();
        return view('customer.about')
            ->with('frontend_setting', $frontend_setting);
    }

    public function terms() {
        $frontend_setting = FrontendSetting::first();
        return view('customer.terms')
            ->with('frontend_setting', $frontend_setting);
    }

    public function contactus() {
        $timezone_str = $_ENV['APP_TIMEZONE'];
        $timezone = new DateTimeZone($timezone_str);
        $date = new DateTime('now', $timezone);
        $date->setTimezone(new DateTimeZone('UTC'));
        $utcOffset = $date->format('P');
        $timezones = config('timezones');
        $utc_timezone = '';
        foreach($timezones as $timezone) {
            if ($timezone['value'] == $timezone_str) {
                $utc_timezone = $timezone['label'];
                break;
            }
        }
        $account = Account::first();
        return view('customer.contactus')
            ->with('timezone', $utc_timezone)
            ->with('account', $account);
    }

    public function locale(Request $request) {
        $langFiles = collect(json_decode(File::get(lang_path('languages.json')))->available)->pluck('value')->all();
        if (!in_array($request->lang, $langFiles)) {
            return back()->with('error', __('Language is not available yet.'));
        }
        App::setLocale($request->lang);
        // session(['language' => $request->lang]);
        session(['user_language' => $request->lang]);
        return back()->with('message', __('Language has been changed.'));
    }
}
