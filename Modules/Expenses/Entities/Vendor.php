<?php

namespace Modules\Expenses\Entities;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Vendor extends Model
{
    use HasFactory;

    protected $fillable = ['name', 'vendor_category_id', 'phone_number', 'position', 'postal_address',
        'physical_address', 'tin_number', 'email_address', 'memo', 'bank',
        'account_number', 'enabled'];

    protected $casts = [
        'enabled' => 'boolean'
    ];

    protected static function newFactory()
    {
        return \Modules\Expenses\Database\factories\VendorFactory::new();
    }


    public function vendorCategory()
    {
        return $this->belongsTo('\Modules\Expenses\Entities\VendorCategory');
    }
    public function bills()
    {
        return $this->hasMany('\Modules\Expenses\Entities\Bill');
    }

    public function payments()
    {
        return $this->hasMany('\Modules\Expenses\Entities\Payment');
    }



    protected $vendor_id;
    public function scopeBillTransactions($query, $vendor_id)
    {
        $this->vendor_id = $vendor_id;
        return $query->where('vendors.id', '=', $vendor_id)
            ->join('bills', function ($join) {
                $join->on('vendors.id', '=', 'bills.vendor_id');
            })
            ->join('bill_payments', function ($join) {
                $join->on('bill_payments.bill_id', '=', 'bills.id');
            })
            ->join('transactions', function ($join) {
                $join->on('transactions.id', '=', 'bill_payments.transaction_id');
            })
            ->where('bill_payments.transaction_id', '!=', null)
            ->select('transactions.*');
    }



    public function scopePaymentTransactions($query, $vendor_id)
    {
        $this->vendor_id = $vendor_id;
        return $query->where('vendors.id', '=', $vendor_id)
            ->join('payments', function ($join) {
                $join->on('vendors.id', '=', 'payments.vendor_id');
            })
            ->join('transactions', function ($join) {
                $join->on('transactions.id', '=', 'payments.transaction_id');
            })
            ->where('payments.transaction_id', '!=', null)
            ->select('transactions.*');
    }



//returns bills connected to  vendors with certain vendor_category
    protected $vendor_cat_id;
    public function scopevendorCatbills($query, $vendor_cat_id){
        $this->vendor_cat_id = $vendor_cat_id;
        return $query
            ->join('bills', function ($join) {
                $join->on('bills.vendor_id', '=', 'vendors.id');
            })
            ->where('vendors.vendor_category_id', '=', $this->vendor_cat_id)
            ->select('bills.*');
    }


    //get unpaid vendor money
    public function scopeUnpaidBills($query, $vendor_id)
    {
        $this->vendor_id = $vendor_id;
        return $query->where('vendors.id', '=', $vendor_id)
            ->join('bills', function ($join) {
                $join->on('vendors.id', '=', 'bills.vendor_id');
            })
            ->join('bill_payments', function ($join) {
                $join->on('bill_payments.bill_id', '=', 'bills.id');
            })
            ->join('recurrings', function ($join) {
                $join->on('recurrings.id', '=', 'bills.recurring_id');
            })
          ->where('bill_payments.transaction_id', '=', null)
          ->select('bill_payments.price', 'bill_payments.bill_date', 'recurrings.interval', 'bills.fixed');
    }


    public function scopeUnPaid($query, $vendor_id){
        //calculate total unpaid prices
        $unpaidbills = $query->UnpaidBills($vendor_id)->get();
        $unpaid = 0;
        foreach ($unpaidbills as $unp){
            $diff_in_days = Carbon::parse($unp->bill_date)->diffInDays(Carbon::now());
            $round = $diff_in_days %  ($unp->interval);
            $unpaid+=($round * $unp->price);
        }
        return $unpaid;
    }


}
