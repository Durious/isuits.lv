<?php

namespace App\Http\Controllers;

use Inertia\Inertia;

class PageController extends Controller
{
    public function __invoke()
    {
        return Inertia::render('Pages');
    }
}
