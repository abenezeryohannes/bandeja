<?php

namespace Modules\Util\Contracts\UI;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Validator;
use \Modules\Properties\Transformers\Index\PropertyCategory as PropertyCategoryIndexResource;
use \Modules\Properties\Transformers\Show\PropertyCategory as PropertyCategoryShowResource;
use \Modules\Properties\Entities\PropertyCategory;
use \Modules\Properties\Transformers\ResponseWrapper;
use \Modules\Properties\Jobs\propertycategory\CreatePropertyCategory;
use \Modules\Properties\Jobs\propertycategory\UpdatePropertyCategory;
use \Modules\Properties\Jobs\propertycategory\DeletePropertyCategory;

abstract class FormContract
{
    protected $type;

    protected $strings = [
        'create' => [
            'save' => 'Save',
            'cancel' => 'cancel'
        ],
        'edit' => [
            'save' => 'Update',
            'cancel' => 'cancel'
        ]
    ];
    public function __construct($type)
    {
        $this->type = $type;
    }


    protected function custom_fields()
    {
        return [];
    }


    public function generate($id = null)
    {
        return [
            'form' => [
                'fields' => $this->fields($id),
                'extra_fields' => $this->custom_fields(),
                'strings' => $this->strings[$this->type] ?? $this->strings['create']
            ] 
        ];
    }


}
