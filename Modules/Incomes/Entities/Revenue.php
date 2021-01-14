<?php

namespace Modules\Incomes\Entities;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Modules\Accounts\Entities\Transaction;

class Revenue extends Model
{
    use HasFactory;

    protected $fillable = [ 'tenant_id', 'category_id',
         'price', 'payed', 'status', 'transaction_id'];

    protected static function newFactory()
    {
        return \Modules\Incomes\Database\factories\RevenueFactory::new();
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

    public function category(){
        return $this->belongsTo('\Modules\Accounts\Entities\Category');
    }

    public function tenant(){
        return $this->belongsTo('\Modules\Incomes\Entities\Tenant');
    }
}
