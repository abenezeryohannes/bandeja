<?php

namespace Modules\Util\Http\Controllers;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;

class BootController extends Controller
{

    public function __invoke()
    {
        if (!auth()->user()) {
            return response()->json([
                'message' => __('errors.unauthenticated'),
                'to' => url('/login')
            ], 302);    
        }
        $main_menu = new \Modules\Util\Menu\Menu('main');
        $main_menu->setRole(auth()->user()->role);
        return response()->json([
            'main_menu' => $main_menu->getMenu(),
            'main_menu_header' => 'NTPC',
            'home_img' => url('img/akaunting-logo-white.svg'),
            'version' => env("SYSTEM_VERSION"),
            'developer' => [
                'link' => env("DEVELOPER_LINK"),
                'name' => __("info.developer_name"),
            ],
            'copyright' => [
                'text' => __("info.copyright_text", ['year'=>2021]),
                'all_rights' => __("info.all_rights"),
            ],
            'user' => [
                'name' => auth()->user()->name,
                'pp' => auth()->user()->pp,
                'org' => 'New Testament Priest Church',
                'locale' => auth()->user()->locale,
                'role' => auth()->user()->role,
            ],
        ]);
    }
}
