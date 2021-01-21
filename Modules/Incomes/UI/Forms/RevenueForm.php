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

class RevenueForm extends \Modules\Util\Contracts\UI\FormContract
{


    public function fields($id)
    {
        if ($id) {
            $propertyCategory = PropertyCategory::find($id);
        }else{
            $propertycategory = null;
        }
        return [
         
            
            (new \Modules\Util\UI\Form\Field('transaction_date','input'))->label('Date')->required()->icon('fa fa-font')->input_type('date')->default($propertyCategory->name ?? null)->generate(),
            (new \Modules\Util\UI\Form\Field('amount','input'))->label('Amount')->required()->icon('fa fa-font')->input_type('text')->default($propertyCategory->name ?? null)->generate(),
            (new \Modules\Util\UI\Form\Field('account_id','select'))->label('Account')->required()->icon('fa fa-font')->options( \Modules\Accounts\Entities\Account::all()->map(function($a){
                return ['label' => $a['name'], 'value' => $a['id']];
            }))->default( null)->generate(),
            (new \Modules\Util\UI\Form\Field('tenant_id','select'))->label('Tenant')->required()->icon('fa fa-font')->options( \Modules\Incomes\Entities\Tenant::all()->map(function($a){
                return ['label' => $a['name'], 'value' => $a['id']];
            }))->default($propertyCategory->name ?? null)->generate(),
            (new \Modules\Util\UI\Form\Field('category_id','select'))->label('Category')->required()->icon('fa fa-font')->options( \Modules\Accounts\Entities\Category::all()->map(function($a){
                return ['label' => $a['name'], 'value' => $a['id']];
            }))->default($propertyCategory->name ?? null)->generate(),
            (new \Modules\Util\UI\Form\Field('payment_method_id','select'))->label('Payment Methods')->required()->icon('fa fa-font')->options( \Modules\Accounts\Entities\PaymentMethod::all()->map(function($a){
                return ['label' => $a['name'], 'value' => $a['id']];
            }))->default($propertyCategory->name ?? null)->generate(),
            (new \Modules\Util\UI\Form\Field('tax_id','select'))->label('Tax')->required()->icon('fa fa-font')->options( \Modules\Accounts\Entities\Tax::all()->map(function($a){
                return ['label' => $a['name'], 'value' => $a['id']];
            }))->default($propertyCategory->name ?? null)->generate(),
            (new \Modules\Util\UI\Form\Field('attachment','file'))->label('Attachement')->required()->icon('fa fa-key')->generate(),



            (new \Modules\Util\UI\Form\Field('Description','textarea'))->label('Description')->column('col-sm-12')->required()->icon('fa fa-font')->input_type('text')->default($propertyCategory->name ?? null)->generate(),
        ];
    }


}
