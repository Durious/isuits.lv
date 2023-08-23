<?php

// Get Settings
if (!function_exists('get_settings')) {
    function get_settings($key = null)
    {
        return auth()->user()?->account?->toArray();
        return array_merge(auth()->user()?->account?->toArray(), \App\Helpers\Env::changeable()->mapWithKeys(function ($item) {
            return [$item['key'] => $item['value']];
        })?->toArray());

        // if ($key) {
        //     return optional(\App\Models\Setting::where('tec_key', $key)->first())->tec_value;
        // }
        // return \App\Models\Setting::all()->pluck('tec_value', 'tec_key')->merge(['baseUrl' => url('/')]);
    }
}

// Get account id
if (!function_exists('getAccountId')) {
    function getAccountId($account_id = null)
    {
        return session('account_id', $account_id ?? optional(auth()->user())->account_id);
    }
}

// Log Activity
if (!function_exists('log_activity')) {
    function log_activity($activity, $properties = null, $model = null, $name = null)
    {
        return activity($name)->performedOn($model)->withProperties($properties)->log($activity);
    }
}

// Format Decimal
if (!function_exists('formatDecimal')) {
    function formatDecimal($number, $decimals = 4, $ds = '.', $ts = '')
    {
        return number_format($number, $decimals, $ds, $ts);
    }
}

// Format Number
if (!function_exists('formatNumber')) {
    function formatNumber($number, $decimals = 2, $ds = '.', $ts = ',')
    {
        return number_format($number, $decimals, $ds, $ts);
    }
}

// Is Demo Enabled
if (!function_exists('demo')) {
    function demo()
    {
        return env('DEMO', false) || env('WINDOWS', false);
    }
}

if (!function_exists('desktopMachine')) {
    function desktopMachine()
    {
        return env('DESKTOPMACHINE', false);
    }
}

if (!function_exists('notDemo')) {
    function notDemo()
    {
        return !demo();
    }
}

if (!function_exists('__choice')) {
    function __choice(string $key, int $count): string
    {
        return trans_choice(__($key), $count);
    }
}

if (!function_exists('_t')) {
    function _t($text, $param = -1)
    {
        if($param === -1) {
            return __($text);
        } else if(is_array($param)){
            return __($text, $param);
        } else {
            return trans_choice($text, $param);
        }
    }
}

if (!function_exists('getLocales')) {
    function getLocales()
    {
        $langFiles = json_decode(File::get(lang_path('languages.json')));
        return $langFiles->available;
    }
}
if (!function_exists('validateImage')) {
    function validateImage($fieldName) {
        return [
            'required',
            function($attribute, $value, $fail) use ($fieldName) {
                if(is_string($value)) {
                    return;
                }
                if(!is_uploaded_file($value)) {
                    return $fail('The '.$fieldName.' must be a valid file');
                }
                if(!in_array(strtolower($value->getClientOriginalExtension()), ['jpg', 'jpeg', 'png', 'gif', 'webp'])) {
                    return $fail('The '.$fieldName.' must be a JPG, JPEG, PNG, or GIF, WEBP file');
                }
            }
        ];
    }
}

if (!function_exists('uploadImage')) {
    function uploadImage(&$item, $field, $prefix, $path) {
        if (
            isset($item[$field]) &&
            $item[$field] &&
            is_uploaded_file($item[$field])
        ) {
            $filename = time().$prefix.'.'.$item[$field]->extension();
            $item[$field]->storeAs('public/'.$path, $filename);
            $item[$field] = $filename;
        }
    }
}

if (!function_exists('get_time_ago')) {
    function get_time_ago( $time, $long = true )
    {
        $time_difference = time() - $time;

        if( $time_difference < 60 ) { return ($long ? 'Less than ' : '').'1 min ago'; }
        $condition = array(
            12 * 30 * 24 * 60 * 60  =>  'year',
            30 * 24 * 60 * 60       =>  'month',
            24 * 60 * 60            =>  'day',
            60 * 60                 =>  'hour',
            60                      =>  'min',
            1                       =>  'second'
        );

        foreach( $condition as $secs => $str )
        {
            $d = $time_difference / $secs;

            if( $d >= 1 )
            {
                $t = round( $d );
                return ($long ? 'About ': '') . $t . ' ' . $str . ( $t > 1 ? 's' : '' ) . ' ago';
            }
        }
    }
}
