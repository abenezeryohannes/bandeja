<?php

namespace Modules\Accounts\Entities;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Transaction extends Model
{
    use HasFactory;

    protected $fillable =  ['type', 'category_id', 'account_id', 'tax_id', 'amount','note','attachment',
        'transaction_date', 'invoice_payment_id','payment_type_id', 'bill_payment_id', 'revenue_id', 'purchase_id'];

    protected static function newFactory()
    {
        return \Modules\Accounts\Database\factories\TransactionFactory::new();
    }

    public function account(){
        return $this->belongsTo('\Modules\Accounts\Entities\Account');
    }


    public function tax(){
        return $this->belongsTo('\Modules\Accounts\Entities\Tax');
    }

    public function invoice(){
        return $this->hasOne('\Modules\Incomes\Entities\Invoice');
    }

    public function revenue(){
        return $this->hasOne('\Modules\Incomes\Entities\Revenue');
    }

    public function category(){
        return $this->belongsTo('\Modules\Accounts\Entities\Category');
    }

//    public function payment(){
//        return $this->hasOne('\Modules\Expenses\Entities\Payment');
//    }
//
//    public function bill(){
//        return $this->hasOne('\Modules\Expenses\Entities\Bill');
//   }

}
