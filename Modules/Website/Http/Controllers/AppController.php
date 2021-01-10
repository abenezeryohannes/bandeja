<?php

namespace Modules\Website\Http\Controllers;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;

class AppController extends Controller
{

    public function __construct()
    {
        $this->middleware('auth');
    }

    public function __invoke($vue_capture = null)
    {
        $user = auth()->user();
        $meta = [
            'title' => 'Walta'
        ];
        return view('app', compact('user','meta'));
    }
}
