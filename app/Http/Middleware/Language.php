<?php

namespace App\Http\Middleware;

use Closure;
use App\Models\Account;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\Request;

class Language
{
    public function handle($request, Closure $next)
    {
        // $locale = 'en';

        // if (session('language')) {
        //     $locale = session('language');
        // } else if (auth()->user()) {
        //     $locale = session('language', auth()->user()->account->language);
        // } else {
        //     $locale = Account::select('language')->first()->language;
        // }

        // App::setLocale($locale);
        // return $next($request);

        
        $cur_path = Request::path();
        if (strpos($cur_path, "admin/") !== false) { // if admin
            $user = auth()->user();
            if ($user) {
                if (session('admin_language')) {
                    $locale = session('admin_language');
                } else {
                    $locale = session('admin_language', $user->account->language);
                }
            } else {
                $locale = session('admin_language', Account::select('language')->first()->language);
            }
        } else {    // if user
            if (session('user_language')) {
                $locale = session('user_language');
            } else {
                $locale = session('user_language', Account::select('language')->first()->language);
            }
        }        

        App::setLocale($locale);
        return $next($request);
    }
}
