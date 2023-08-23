<?php

namespace App\Exceptions;

use Throwable;
use Inertia\Inertia;
use Illuminate\Support\Facades\App;
use Illuminate\Foundation\Exceptions\Handler as ExceptionHandler;

class Handler extends ExceptionHandler
{
    protected $dontFlash = [
        'password',
        'password_confirmation',
    ];
    protected $dontReport = [
        //
    ];

    public function render($request, Throwable $e)
    {
        if ($e instanceof \Illuminate\Encryption\MissingAppKeyException) {
            return redirect()->to('/install');
        }

        // return parent::render($request, $e);
        $response = parent::render($request, $e);
        if (419 === $response->status()) {
            return back()->with('error', 'The page expired, please try again.');
        }

        if (App::environment('production') && $request->header('X-Inertia') && in_array($response->status(), [500, 503, 404, 403])) {
            return Inertia::render('Error', ['status' => $response->status()])->toResponse($request)->setStatusCode($response->status());
        }

        return $response;
    }
}
