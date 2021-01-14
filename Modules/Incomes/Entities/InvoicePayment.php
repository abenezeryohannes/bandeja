<?php

namespace Modules\Incomes\Entities;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class InvoicePayment extends Model
{
    use HasFactory;

    protected $fillable = [ 'invoice_id',
         'period', 'price', 'payed',
        'due_date', 'invoice_date', 'status', 'transaction_id'];

    protected static function newFactory()
    {
        return \Modules\Incomes\Database\factories\InvoicePaymentFactory::new();
    }


    public function transaction(){
        return $this->belongsTo('\Modules\Accounts\Entities\Transaction');
    }

    public function account(){
        return $this->belongsTo('\Modules\Accounts\Entities\Account');
    }


    public function tax(){
        return $this->belongsTo('\Modules\Accounts\Entities\Tax');
    }

    public function invoice(){
        return $this->belongsTo('\Modules\Incomes\Entities\Invoice');
    }
}
