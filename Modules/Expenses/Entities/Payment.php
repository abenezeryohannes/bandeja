<?php

namespace Modules\Expenses\Entities;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Payment extends Model
{
    use HasFactory;
    protected $fillable = ['vendor_id', 'category_id', 'tax_id', 'transaction_id', 'amount'];

    protected static function newFactory()
    {
        return \Modules\Expenses\Database\factories\PaymentsFactory::new();
    }


    public function transaction(){
        return $this->belongsTo('\Modules\Accounts\Entities\Transaction');
    }

    public function vendor(){
        return $this->belongsTo('\Modules\Expenses\Entities\Vendor');
    }

    public function category(){
        return $this->belongsTo('\Modules\Accounts\Entities\Category');
    }

}
