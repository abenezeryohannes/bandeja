<?php

namespace Modules\Expenses\Entities;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class BillPayment extends Model
{
    use HasFactory;

    protected $fillable = ['bill_id', 'bill_date', 'price','period', 'transaction_id','due_date'];

    protected static function newFactory()
    {
        return \Modules\Expenses\Database\factories\BillPaymentFactory::new();
    }



    public function transaction(){
        return $this->belongsTo('\Modules\Accounts\Entities\Transaction');
    }

    public function bill(){
        return $this->belongsTo('\Modules\Expenses\Entities\Bill');
    }


}
