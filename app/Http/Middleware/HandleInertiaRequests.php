<?php

namespace App\Http\Middleware;

use Auth;
use Inertia\Middleware;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\File;

class HandleInertiaRequests extends Middleware
{
    protected $rootView = 'app';

    public function share(Request $request)
    {
        $user = Auth::guard('web')->user();
        $langFiles = json_decode(File::get(lang_path('languages.json')));
        return array_merge(parent::share($request), [
            'demo'      => demo(),
            'settings'  => get_settings(),
            'language'  => app()->getLocale(),
            'locales'   => $langFiles->available,
            'languages' => $langFiles->available,
            'flash'     => [
                'error'   => session('error'),
                'message' => session('message'),
                'success' => session('success'),
            ],
            'app_name' => config('app.name'),
            'user'     => $user ? [
                'id'       => $user->id,
                'name'     => $user->name,
                'phone'    => $user->phone,
                'email'    => $user->email,
                'owner'    => $user->owner,
                'can_sms'  => $user->can_sms,
                'edit_all' => $user->edit_all,
                'username' => $user->username,
                'photo'    => $user->photoUrl(['w' => 40, 'h' => 40, 'fit' => 'crop']),
                'account'  => [
                    'locales'       => $langFiles->available,
                    'id'            => $user->account->id,
                    'name'          => $user->account->name,
                    'payu'          => $user->account->payu,
                    'stripe'        => $user->account->stripe,
                    'currency'      => env('STRIPE_CURRENCY'),
                    'gateways'      => $user->account->gateways,
                    'language'      => $user->account->language,
                    'direction'     => $user->account->direction,
                    'logo_path'     => $user->account->logo_path,
                    'default_tax'   => $user->account->default_tax,
                    'sms_enabled'   => $user->account->sms_enabled,
                    'email_enabled' => $user->account->email_enabled,
                    'order_statuses'=> explode(',', $user->account->order_statuses),
                    'stripe_key'    => $user->account->stripe ? env('STRIPE_KEY') : null,
                ],
            ] : null,
        ]);
    }

    public function version(Request $request)
    {
        return parent::version($request);
    }
}
