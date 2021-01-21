<?php

namespace Modules\Accounts\Entities;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Transaction extends Model
{
    use HasFactory;

    protected $fillable =  ['type', 'category_id', 'account_id', 'tax_id', 'amount','note','attachment',
        'transaction_date','payment_method_id'];

    protected static function newFactory()
    {
        return \Modules\Accounts\Database\factories\TransactionFactory::new();
    }

    public function account(){
        return $this->belongsTo('\Modules\Accounts\Entities\Account');
    }

    public function paymentMethod(){
        return $this->belongsTo('\Modules\Accounts\Entities\PaymentMethod');
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





    protected $vendor_id;
    public function scopeVendorBillTransactions($query, $vendor_id)
    {
        $this->vendor_id = $vendor_id;
        return $query
            ->join('bill_payments', function ($join) {
                $join->on('bill_payments.transaction_id', '=', 'transactions.id');
            })
            ->join('bills', function ($join) {
                $join->on('bills.id', '=', 'bill_payments.bill_id');
            })
            ->join('vendors', function ($join) {
                $join->on('vendors.id', '=', 'bills.vendor_id');
            })->where('vendors.id', '=', $this->vendor_id)
            ->where('bill_payments.transaction_id', '!=', null)
            ->select('transactions.*');
    }

    public function scopeVendorPaymentTransactions($query, $vendor_id)
    {
        $this->vendor_id = $vendor_id;
        return $query
            ->join('payments', function ($join) {
                $join->on('payments.transaction_id', '=', 'transactions.id');
            })
            ->join('vendors', function ($join) {
                $join->on('vendors.id', '=', 'payments.vendor_id');
            })->where('vendors.id', '=', $this->vendor_id)
            ->where('payments.transaction_id', '!=', null)
            ->select('transactions.*');
    }




    protected $tenant_id;
    public function scopeTenantRevenueTransactions($query, $tenant_id)
    {  $this->tenant_id = $tenant_id;
        return $query
            ->join('revenues', function ($join) {
                $join->on('revenues.transaction_id', '=', 'transactions.id');
            })
            ->join('tenants', function ($join) {
                $join->on('revenues.tenant_id', '=', 'tenants.id');
            })->where('tenants.id', '=', $this->tenant_id)
            ->where('revenues.transaction_id', '!=', null)
            ->select('transactions.*');
    }

    public function scopeTenantInvoiceTransactions($query, $tenant_id)
    {
        $this->tenant_id = $tenant_id;
        return $query
            ->join('invoice_payments', function ($join) {
                $join->on('invoice_payments.transaction_id', '=', 'transactions.id');
            })
            ->join('invoices', function ($join) {
                $join->on('invoice_payments.invoice_id', '=', 'invoices.id');
            })
            ->join('tenants', function ($join) {
                $join->on('invoices.tenant_id', '=', 'tenants.id');
            })->where('tenants.id', '=', $this->tenant_id)
            ->where('invoice_payments.transaction_id', '!=', null)
            ->select('transactions.*');
    }



    protected $bill_id;
    public function scopeBillTransactions($query, $bill_id)
    {
        $this->bill_id = $bill_id;
        return $query
            ->join('bill_payments', function ($join) {
                $join->on('bill_payments.transaction_id', '=', 'transactions.id');
            })
            ->join('bills', function ($join) {
                $join->on('bills.id', '=', 'bill_payments.bill_id');
            })
            ->where('bills.id', '=', $this->bill_id)
            ->where('bill_payments.transaction_id', '!=', null)
            ->select('transactions.*');
    }


    protected $invoice_id;
    public function scopeInvoiceTransactions($query, $invoice_id)
    {
        $this->invoice_id = $invoice_id;
        return $query
            ->join('invoice_payments', function ($join) {
                $join->on('invoice_payments.transaction_id', '=', 'transactions.id');
            })
            ->join('invoices', function ($join) {
                $join->on('invoices.id', '=', 'invoice_payments.invoice_id');
            })
            ->where('invoices.id', '=', $this->invoice_id)
            ->where('invoice_payments.transaction_id', '!=', null)
            ->select('transactions.*');
    }




}
