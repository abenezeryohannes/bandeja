<?php

namespace Modules\User\Http\Controllers;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;

class ChangeLangController extends Controller
{

    public function __invoke(Request $request)
    {
        $user = auth()->user();
        $user->locale = $request['locale'];
        $user->save();

        return response()->json([
            'success' => true 
        ]);
    }
}
