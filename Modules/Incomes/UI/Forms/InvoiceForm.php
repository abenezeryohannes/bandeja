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
use Carbon\Carbon;
class InvoiceForm extends \Modules\Util\Contracts\UI\FormContract
{

    protected function custom_fields()
    {
        $all =  [
            'data' => [

                'properties' => \Modules\Properties\Entities\Property::where('available_after', '<', Carbon::now())->get()->map(function($r){
                    return ['label' => $r['name'], 'value' => $r['id'], 'price' => $r->propertyCategory['rent_price'] ];
                }),
                'taxes' => \Modules\Accounts\Entities\Tax::all()->map(function($r){
                    return ['label' => $r['name'], 'value' => $r['id'], 'rate' => $r['rate'] ];
                }),
            ],
            'fields' => [ 'property_id' ]
        ];

        switch ($this->type) {
            case 'pay':
                return [];
                break;
            
            default:
                return $all;
                break;
        }
    }



    public function fields($id)
    {
        switch ($this->type) {
            case 'pay':
                return $this->pay_fields($id);
                break;
            
            default:
                return $this->create_fields($id);
                break;
        }
    }


    public function pay_fields($id)
    {
        if ($id) {
            $propertyCategory = PropertyCategory::find($id);
        }else{
            $propertycategory = null;
        }
        return [
//             transaction_date:2021-01-13 11:21:39
// payment_method_id:1
// :1
// :1
// :40
// //attachment:
// note:This is sample note
// amount:300
// period:3
         
            (new \Modules\Util\UI\Form\Field('transaction_date','input'))->label('Transaction Date')->required()->icon('fa fa-font')->input_type('date')->default($propertyCategory->name ?? null)->generate(),
            
            (new \Modules\Util\UI\Form\Field('payment_method_id','select'))->label('Payment Method')->required()->icon('fa fa-font')->options( \Modules\Accounts\Entities\PaymentMethod::all()->map(function($a){
                return ['label' => $a['name'], 'value' => $a['id']];
            }))->default( null)->generate(),

            (new \Modules\Util\UI\Form\Field('account_id','select'))->label('Account')->required()->icon('fa fa-font')->options( \Modules\Accounts\Entities\Account::all()->map(function($a){
                return ['label' => $a['name'], 'value' => $a['id']];
            }))->default( null)->generate(),

            (new \Modules\Util\UI\Form\Field('tax_id','select'))->label('Tax')->required()->icon('fa fa-font')->options( \Modules\Accounts\Entities\Tax::all()->map(function($a){
                return ['label' => $a['name'], 'value' => $a['id']];
            }))->default( null)->generate(),

//            (new \Modules\Util\UI\Form\Field('invoice_payment_id','select'))->label('Invoice Payment')->required()->icon('fa fa-font')->options( \Modules\Incomes\Entities\InvoicePayment::all()->map(function($a){
//                return ['label' => $a['name'], 'value' => $a['id']];
//            }))->default( null)->generate(),

            // (new \Modules\Util\UI\Form\Field('blank1','blank'))->generate(),

            (new \Modules\Util\UI\Form\Field('note','textarea'))->label('Note')->required()->icon('fa fa-font')->input_type('date')->default($propertyCategory->name ?? null)->generate(),
            (new \Modules\Util\UI\Form\Field('amount','input'))->label('Amount')->required()->icon('fa fa-font')->input_type('number')->default($propertyCategory->name ?? null)->generate(),
            (new \Modules\Util\UI\Form\Field('period','input'))->label('Period')->required()->icon('fa fa-font')->input_type('number')->default($propertyCategory->name ?? null)->generate(),


        ];
    }


    public function create_fields($id)
    {
        if ($id) {
            $propertyCategory = PropertyCategory::find($id);
        }else{
            $propertycategory = null;
        }
        return [
         
            (new \Modules\Util\UI\Form\Field('tenant_id','select'))->label('Tenant')->required()->icon('fa fa-font')->options( \Modules\Incomes\Entities\Tenant::all()->map(function($a){
                return ['label' => $a['name'], 'value' => $a['id']];
            }))->default( null)->generate(),
            (new \Modules\Util\UI\Form\Field('due_date','input'))->label('Due Date')->required()->icon('fa fa-font')->input_type('date')->default($propertyCategory->name ?? null)->generate(),
            
            // (new \Modules\Util\UI\Form\Field('blank1','blank'))->generate(),

            (new \Modules\Util\UI\Form\Field('start_date','input'))->label('Invoice Start Date')->required()->icon('fa fa-font')->input_type('date')->default($propertyCategory->name ?? null)->generate(),
            (new \Modules\Util\UI\Form\Field('end_date','input'))->label('Invoice End Date')->required()->icon('fa fa-font')->input_type('date')->default($propertyCategory->name ?? null)->generate(),

            (new \Modules\Util\UI\Form\Field('properties','custom'))->generate(),
            
            (new \Modules\Util\UI\Form\Field('note','input'))->label('Notes')->required()->icon('fa fa-font')->input_type('text')->default($propertyCategory->name ?? null)->generate(),
            (new \Modules\Util\UI\Form\Field('category_id','select'))->label('Payed By')->required()->icon('fa fa-font')->options( \Modules\Accounts\Entities\PaymentMethod::all()->map(function($a){
                    return ['label' => $a['name'], 'value' => $a['id']];
                }))->default($propertyCategory->name ?? null)->generate(),
            (new \Modules\Util\UI\Form\Field('renewed_invoice_id','select'))->label('Renewd Invoice')->required()->icon('fa fa-font')->options( \Modules\Incomes\Entities\Invoice::all()->map(function($a){
                    return ['label' => $a['invoice_number'], 'value' => $a['id']];
                }))->default($propertyCategory->name ?? null)->generate(),

            (new \Modules\Util\UI\Form\Field('attachment1','file'))->label('Attachments')->required()->icon('fa fa-key')->generate(),

            (new \Modules\Util\UI\Form\Field('rental_contract','custom'))->generate(),

        ];
    }


}
