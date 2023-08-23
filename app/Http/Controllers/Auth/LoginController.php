<?php

namespace App\Http\Controllers\Auth;

use Auth;
use Inertia\Inertia;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Validation\ValidationException;
use Illuminate\Foundation\Auth\AuthenticatesUsers;

class LoginController extends Controller
{
    use AuthenticatesUsers;

    protected $redirectTo = '/admin';

    protected function authenticated(Request $request, $user)
    {
        if (!$user->active) {
            $this->logout($request);
            throw ValidationException::withMessages([
                $this->username() => [__('User is not active, please check with admin.')],
            ]);
        }
        log_activity(__('User has been logged in'), ['user' => $user], $user);
    }

    protected function credentials(Request $request)
    {
        $field = filter_var($request->username, FILTER_VALIDATE_EMAIL) ? 'email' : 'username';

        return [
            $field     => $request->username,
            'password' => $request->get('password'),
        ];
    }

    public function decayMinutes()
    {
        return property_exists($this, 'decayMinutes') ? $this->decayMinutes : 5;
    }

    public function maxAttempts()
    {
        return property_exists($this, 'maxAttempts') ? $this->maxAttempts : 3;
    }

    public function showLoginForm()
    {
        return Inertia::render('Auth/Login');
    }

    public function username()
    {
        return 'username';
    }

    public function logout()
    {
        Auth::guard('web')->logout();
        return redirect()->route('dashboard');
    }
}
