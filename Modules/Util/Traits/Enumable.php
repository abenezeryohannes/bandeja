<?php


namespace Modules\Util\Traits;


trait Enumable
{

    public static function getList()
    {
        return self::$list;
    }

    public static function getAll()
    {
        return self::getList();
    }

    public static function get($code,$the_list = null)
    {
        if($the_list){
            $list = $the_list;
        }else{
            $list = self::getList();
        }
        return collect($list)->filter(function($l) use($code){
            return $l['code'] == $code;
        })->first();
    }

}