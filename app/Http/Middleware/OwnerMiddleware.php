<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Support\Facades\Auth;

class OwnerMiddleware
{
    public function handle($request, Closure $next)
    {
        abort_unless(auth()->user()->owner, 403, 'Access denied! you are not allowed to access the resource.');

        return $next($request);
    }
}
