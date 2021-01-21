<?php

namespace Modules\Incomes\UI\Forms;

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

class TenantsForm extends \Modules\Util\Contracts\UI\FormContract
{


    public function fields($id)
    {
        if ($id) {
            $propertyCategory = PropertyCategory::find($id);
        }else{
            $propertycategory = null;
        }
        return [
            
            (new \Modules\Util\UI\Form\Field('name','input'))->label('Full Name')->required()->icon('fa fa-font')->input_type('text')->default($propertyCategory->name ?? null)->generate(),
            (new \Modules\Util\UI\Form\Field('postal_address','input'))->label('Postal Address')->required()->icon('fa fa-font')->input_type('text')->default($propertyCategory->name ?? null)->generate(),
            (new \Modules\Util\UI\Form\Field('phone_number','input'))->label('Phone number')->required()->icon('fa fa-font')->input_type('text')->default($propertyCategory->name ?? null)->generate(),
            (new \Modules\Util\UI\Form\Field('physical_address','input'))->label('Physical Address')->required()->icon('fa fa-font')->input_type('text')->default($propertyCategory->name ?? null)->generate(),
            (new \Modules\Util\UI\Form\Field('business_type','input'))->label('Type of business')->required()->icon('fa fa-font')->input_type('text')->default($propertyCategory->name ?? null)->generate(),
            (new \Modules\Util\UI\Form\Field('email_address','input'))->label('Email Address')->required()->icon('fa fa-font')->input_type('text')->default($propertyCategory->name ?? null)->generate(),

            (new \Modules\Util\UI\Form\Field('memo','file'))->label('Memo')->required()->icon('fa fa-key')->generate(),
            (new \Modules\Util\UI\Form\Field('tin_number','input'))->label('Tin Number')->required()->icon('fa fa-font')->input_type('text')->default($propertyCategory->name ?? null)->generate(),
        ];
    }


}
