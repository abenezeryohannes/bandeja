<?php

namespace Modules\Properties\UI\Forms;

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

class BlocksForm extends \Modules\Util\Contracts\UI\FormContract
{

     protected function custom_fields()
    {
        return [
            'data' => [
                'categories' => \Modules\Properties\Entities\PropertyCategory::all()->map(function($r){
                    return ['label' => $r['name'], 'value' => $r['id'] ];
                }),
                // 'taxes' => \Modules\Accounts\Entities\Tax::all()->map(function($r){
                //     return ['label' => $r['name'], 'value' => $r['id'], 'rate' => $r['rate'] ];
                // }),
            ],
            'fields' => [ 'properties' ]
        ];
    }


    public function fields($id)
    {
        if ($id) {
            $propertyCategory = PropertyCategory::find($id);
        }else{
            $propertycategory = null;
        }
        return [
             [ 'label' => 'Name', 'required' => 'required', 'icon' => 'fa fa-font', 'type' => 'input', 'column' => 'col-md-6', 'input_type' => 'text', 'default' =>  null, 'name' => 'name' ],
                    [ 'label' => 'Floors', 'required' => 'required', 'icon' => 'fa fa-font', 'type' => 'input', 'column' => 'col-md-3', 'input_type' => 'text', 'default' =>  null, 'name' => 'floors' ],
                    [ 'label' => 'Status', 'required' => 'required', 'icon' => 'fa fa-save', 'type' => 'switcher', 'column' => 'col-md-3', 'options' => [ [ 'label' => 'Enabled', 'value' => '1'],[ 'label' => 'Disabled', 'value' => '0']  ], 'default' =>  '1', 'name' => 'enabled' ],

                    [ 'label' => 'Site', 'required' => 'required', 'icon' => 'fa fa-envelope', 'type' => 'select', 'column' => 'col-md-6', 'options' => \Modules\Properties\Entities\Site::all()->map(function($s){
                        return [
                            'label' => $s['name'],
                            'value' => $s['id'],
                        ];
                    }), 'default' =>  null, 'name' => 'site_id' ],
                    [ 'label' => 'Address', 'required' => 'required', 'icon' => 'fa fa-envelope', 'type' => 'textarea', 'column' => 'col-md-6', 'input_type' => 'email', 'default' =>  null, 'name' => 'address' ],

                    // [ 'label' => 'Types of properties inside the block', 'icon' => 'fa fa-envelope', 'type' => 'input', 'column' => 'col-md-4', 'input_type' => 'number', 'default' =>  null, 'name' => 'no_of_types' ],

                    (new \Modules\Util\UI\Form\Field('picture','file'))->label('Picture')->required()->icon('fa fa-key')->generate(),
                    (new \Modules\Util\UI\Form\Field('blank1','blank'))->generate(),

                    (new \Modules\Util\UI\Form\Field('types','custom'))->column('col-sm-8')->generate(),
        ];
    }


}
