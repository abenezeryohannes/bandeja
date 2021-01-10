<?php


namespace Modules\Util\Enum;


class EducationalBackground
{

    use \Modules\Util\Traits\Enumable;

    protected static $list = [
        [ 'code' => 'PHD', 'label' => 'PHD' ],
        [ 'code' => 'MASTERS', 'label' => 'Masters Degree' ],
        [ 'code' => 'UNDERGRAD', 'label' => 'Undergraduate Degree' ],
        [ 'code' => 'DIPLOMA', 'label' => 'Diploma' ],
        [ 'code' => 'SECONDARY', 'label' => 'Secondary Education' ],
        [ 'code' => 'PRIMARY', 'label' => 'Primary Education' ],
        [ 'code' => 'LITERATE', 'label' => 'Literate' ],
        [ 'code' => 'ILLITERATE', 'label' => 'Illiterate' ],
    ];



}