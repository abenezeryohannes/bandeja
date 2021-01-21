<?php

namespace Modules\Util\Http\Controllers;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;

use Illuminate\Support\Facades\Storage;
class MediaController extends Controller
{
    public function __invoke($path)
    {
        $f = Storage::get($path);

        if ($f) {
            return response()->file(base_path('storage/app/'.$path));
        }
    }
}
