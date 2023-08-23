<?php

namespace App\Http\Middleware;

use Closure;
use App\Models\Account;
use Illuminate\Support\Facades\App;

class Language
{
    public function handle($request, Closure $next)
    {
        $locale = 'en';

        if (session('language')) {
            $locale = session('language');
        } else if (auth()->user()) {
            $locale = session('language', auth()->user()->account->language);
        } else {
            $locale = Account::select('language')->first()->language;
        }

        App::setLocale($locale);
        return $next($request);
    }
}
