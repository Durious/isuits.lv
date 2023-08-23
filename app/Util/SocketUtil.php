<?php

namespace App\Util;
use Illuminate\Support\Facades\Http;

class SocketUtil
{
//    private static $host = 'http://localhost:3000/send_notification';
    private static $host = 'https://node.isuits.lv/send_notification';

    public static function sendMessage($id, $message)
    {
        $response = Http::post(self::$host, [
            'id' => $id,
            'message' => $message
        ]);

        if ($response->ok()) {
            // HTTP response status code is between 200 and 299 (inclusive)
            // Handle the success case...
        } else {
            // HTTP response status code is not between 200 and 299 (inclusive)
            // Handle the error case...
        }
    }
}
