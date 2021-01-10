<?php

namespace Modules\Util\Http\Controllers;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;

class NotificationController extends Controller
{

	public function __construct()
	{
		$this->middleware('auth');
	}
    public function __invoke()
    {
        return response()->json([
        ]);
    }
}
