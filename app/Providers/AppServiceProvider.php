<?php

namespace App\Providers;

use DB;
use Auth;
use App\Models\Chat;
use App\Models\Account;
use App\Models\FrontendSetting;
use League\Glide\ServerFactory;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    public function boot()
    {
        Schema::defaultStringLength(191);
        \App\Models\Order::observe(\App\Observers\OrderObserver::class);
        \App\Models\ProductOrder::observe(\App\Observers\ProductOrderObserver::class);
        \App\Models\Payment::observe(\App\Observers\PaymentObserver::class);
        \App\Models\Customer::observe(\App\Observers\CustomerObserver::class);
        \App\Models\Product::observe(\App\Observers\ProductObserver::class);
        \App\Models\Service::observe(\App\Observers\ServiceObserver::class);
    }

    public function register()
    {
        $this->app->singleton('League\Glide\Server', function ($app) {
            $filesystem = $app->make('Illuminate\Contracts\Filesystem\Filesystem');
            return ServerFactory::create([
                'driver'            => 'gd',
                'base_url'          => url('/'),
                'cache_path_prefix' => '.cache',
                'cache'             => $filesystem->getDriver(),
                'source'            => $filesystem->getDriver(),
            ]);
        });
        view()->composer('*', function ($view) {
            if(Account::first()->logo_path) {
                $account_logo = 'storage/account/'.Account::first()->logo_path;
            } else {
                $account_logo = 'customer/img/logo/logo.png';
            }
            $frontend_setting = FrontendSetting::first();
            $instagram_list = json_decode($frontend_setting->instagram ?? 'null');
            $subscribe = json_decode($frontend_setting->subscribe ?? 'null');
            $footer = json_decode($frontend_setting->footer ?? 'null');

            $chat_tailors = array();
            if(Auth::guard('customer')->check()){
                $chat_tailors = Chat::select(
                        'users.id',
                        'users.name',
                        'users.email',
                        'users.photo_path',
                        DB::raw('MAX(chats.created_at) as last_time'),
                        DB::raw('SUBSTRING_INDEX(GROUP_CONCAT(chats.text ORDER BY chats.created_at DESC SEPARATOR \'!!\'), \'!!\', 1) as last_text'),
                        DB::raw('SUM(CASE WHEN chats.is_read = false AND chats.from_user = 1 THEN 1 ELSE 0 END) as unread')
                    )
                    ->join('users', 'users.id', '=', 'chats.user_id')
                    ->where('chats.customer_id', Auth::guard('customer')->id())
                    ->orderBy('last_time', 'desc')
                    ->groupBy('users.id')
                    ->get();
            }

            $view->with('account_logo', $account_logo)
                ->with('instagram_list', $instagram_list)
                ->with('subscribe', $subscribe)
                ->with('chat_tailors', $chat_tailors)
                ->with('footer', $footer);
        });
    }
}
