<?php

namespace App\Http\Controllers\Update;

use Inertia\Inertia;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Artisan;

class UpdateController extends Controller
{
    public function __invoke()
    {
        $code = Artisan::call('migrate', ['--force' => true, '--path' => 'database/migrations/updates']);
        return Inertia::render('Update', ['info' => trim(Artisan::output())]);
    }
}
