<?php

namespace Modules\Util\Federalism;

use Closure;
use Illuminate\Http\Request;

class City
{

    private static $cities = [
        'HAWASSA' => [ 'code' => 'HAWASSA', 'name_en' => 'Hawassa', 'name_am' => 'hawaaa' ]
    ];

    public static function get($city_code)
    {
        return self::$cities[$city_code];
    }

    public static function all()
    {
        return self::$cities;
    }
}
