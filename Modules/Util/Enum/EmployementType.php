<?php


namespace Modules\Util\Enum;


class EmployementType
{

    use \Modules\Util\Traits\Enumable;

     protected static $list = [
        ['code' => 'REGULAR' , 'label' => 'Regular'],
        ['code' => 'CONTRACT', 'label' => 'Contract']
    ];



}