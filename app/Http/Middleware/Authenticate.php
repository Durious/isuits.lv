<?php

namespace App\Http\Middleware;

use Illuminate\Support\Str;
use Illuminate\Auth\Middleware\Authenticate as Middleware;

class Authenticate extends Middleware
{
    protected function redirectTo($request)
    {
        if (!$request->expectsJson()) {
            if (Str::startsWith($request->fullUrl(), url('/admin'))) {
                return route('login');
            } else {
                return route('customer.home');
            }
        }
    }
}
