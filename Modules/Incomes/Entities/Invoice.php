<?php

namespace Modules\Incomes\Entities;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Invoice extends Model
{
    use HasFactory;

    protected $casts = [
        "canceled" => "boolean",
    ];
    protected $fillable = ['tenant_id', 'category_id', 'property_id', 'tax_id',
        'start_date', 'end_date', 'due_date', 'invoice_number', 'renewed_invoice_id', 'note',
        'attachment1', 'attachment2', 'attachment3', 'price'];

    protected static function newFactory()
    {
        return \Modules\Incomes\Database\factories\InvoiceFactory::new();
    }

    public function invoicePayments(){
        return $this->hasMany('\Modules\Incomes\Entities\InvoicePayment');
    }


    public function tenant(){
        return $this->belongsTo('\Modules\Incomes\Entities\Tenant');
    }

    public function property(){
        return $this->belongsTo('\Modules\Properties\Entities\Property');
    }

    public function tax(){
        return $this->belongsTo('\Modules\Accounts\Entities\Tax');
    }

    public function category(){
        return $this->belongsTo('\Modules\Accounts\Entities\Category');
    }
    public function canceled(){
        return $this->hasMany('\Modules\Incomes\Entities\CanceledInvoice');
    }



    public function scopeTransactions($query){
        return $query->join('invoice_payments', function ($join){
            $join->on('invoice_payments.invoice_id', '=', 'invoices.id');
        })->join('transactions', function ($join){
            $join->on('transactions.id', '=', 'invoice_payments.transaction_id');
        })->where('invoice_payments.transaction_id', '!=', null)->select('transactions.*');
    }

}
