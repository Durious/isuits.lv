<?php

namespace App\Http\Controllers;

use League\Glide\Server;
use Illuminate\Http\Request;

class ImageController extends Controller
{
    public function show(Server $server, $path)
    {
        return $server->outputImage($path, request()->all());
    }
}
