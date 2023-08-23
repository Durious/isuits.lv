<?php

namespace App\Http\Controllers\Auth;

use Inertia\Inertia;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;
use Illuminate\Foundation\Auth\ResetsPasswords;

class ResetPasswordController extends Controller
{
    use ResetsPasswords;

    protected $redirectTo = '/';

    public function __construct()
    {
        $this->middleware('guest');
    }

    protected function sendResetFailedResponse(Request $request, $response)
    {
        return back()->with(['error' => trans($response)])
                ->withErrors(['email' => trans($response)]);
    }

    protected function sendResetResponse(Request $request, $response)
    {
        return redirect($this->redirectPath())->with('success', trans($response));
    }

    public function showResetForm(Request $request, $token = null)
    {
        if (!DB::table('password_resets')->where('email', $request->email)->first()) {
            return redirect()->route('password.request')->with(['error' => __('Request expired! please try again.')]);
        };
        return Inertia::render('Auth/Reset', ['token' => $token, 'email' => $request->email]);
    }
}
