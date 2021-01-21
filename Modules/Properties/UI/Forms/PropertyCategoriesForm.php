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

class PropertyCategoriesForm extends \Modules\Util\Contracts\UI\FormContract
{


    public function fields($id)
    {
        if ($id) {
            $propertyCategory = PropertyCategory::find($id);
        }else{
            $propertycategory = null;
        }
        return [
            (new \Modules\Util\UI\Form\Field('name','input'))->label('Name')->required()->icon('fa fa-font')->input_type('text')->default($propertyCategory->name ?? null)->generate(),
            (new \Modules\Util\UI\Form\Field('picture','file'))->label('Picture')->required()->icon('fa fa-key')->generate(),
            (new \Modules\Util\UI\Form\Field('description','textarea'))->label('Description')->required()->icon('fa fa-envelope')->default($propertyCategory->description ?? null)->generate(),

            [ 'label' => 'Size', 'required' => 'required', 'icon' => 'fa fa-key', 'type' => 'input', 'column' => 'col-md-6', 'input_type' => 'text', 'default' =>  $propertyCategory->size ?? null, 'name' => 'size' ],
            [ 'label' => 'Sale Price', 'required' => 'required', 'icon' => 'fa fa-key', 'type' => 'input', 'column' => 'col-md-6', 'input_type' => 'text', 'default' =>  $propertyCategory->sell_price ?? null, 'name' => 'sell_price' ],
            [ 'label' => 'Rent Price', 'required' => 'required', 'icon' => 'fa fa-key', 'type' => 'input', 'column' => 'col-md-6', 'input_type' => 'text', 'default' =>  null, 'name' => 'rent_price' ],

            (new \Modules\Util\UI\Form\Field('enabled','switcher'))->label('Status')->multiple()->option([ 'label' => 'Enabled', 'value' => '1'])->option([ 'label' => 'Disabled', 'value' => '0'])->default($propertyCategory->enabled ?? '1')->generate(),
        ];
    }


}
