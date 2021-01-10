<?php


namespace Modules\Util\Enum;


class Bank
{

    use \Modules\Util\Traits\Enumable;

    protected static $list = [
        ['code' => 'AWASH', 'label' => 'Awash Bank'],
        ['code' => 'OIB', 'label' => 'Oromia International Bank'],
        ['code' => 'CBE', 'label' => 'Commercial Bank of Ethiopia'],
        ['code' => 'BIRHAN', 'label' => 'Birhan Bank'],
    ];




}