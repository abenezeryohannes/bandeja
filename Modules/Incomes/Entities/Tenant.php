<?php

namespace Modules\Incomes\Entities;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Tenant extends Model
{
    use HasFactory;
    protected $casts = [
        "enabled" => "boolean",
    ];

    protected $fillable = ['name', 'type', 'phone_number', 'business_type',
        'postal_address', 'physical_address', 'email_address', 'tin_number', 'memo', 'enabled'];

    protected static function newFactory()
    {
        return \Modules\Incomes\Database\factories\TenantFactory::new();
    }

    public function revenues(){
        return $this->belongsTo('\Modules\Incomes\Entities\Revenue');
    }


    public function invoices(){
        return $this->hasMany('\Modules\Incomes\Entities\Invoice', 'tenant_id', 'id');
    }



    public function scopeTotalDefaulted($query){
       return $query->join('invoices', function ($join){
           $join->on('invoices.tenant_id', '=', 'tenants.id');
       })->join('invoice_payments', function ($join){
           $join->on('invoice_payments.invoice_id', '=', 'invoices.id');
       })->where('invoice_payments.transaction_id', '=', null)
         ->where('invoice_payments.due_date', '<=',Carbon::now())
           ->sum('invoice_payments.price');
    }
    //open_invoices

    public function scopeTotalPaidInv($query){
        return $query->join('invoices', function ($join){
            $join->on('invoices.tenant_id', '=', 'tenants.id');
        })->join('invoice_payments', function ($join){
            $join->on('invoice_payments.invoice_id', '=', 'invoices.id');
        })->join('transactions', function ($join){
            $join->on('transactions.id', '=', 'invoice_payments.transaction_id');
        })->where('invoice_payments.transaction_id', '!=', null)
            ->sum('transactions.amount');
    }
    public function scopeTotalWaiting($query){
        return $query->join('invoices', function ($join){
            $join->on('invoices.tenant_id', '=', 'tenants.id');
        })->join('invoice_payments', function ($join){
            $join->on('invoice_payments.invoice_id', '=', 'invoices.id');
        })->where('invoice_payments.transaction_id', '=', null)
            ->where('invoice_payments.due_date', '>',Carbon::now())
            ->sum('invoice_payments.price');
     }
     public function scopeTotalPaidRev($query){
        return $query->join('revenues', function ($join){
            $join->on('revenues.tenant_id', '=', 'tenants.id');
        })->join('transactions', function ($join){
            $join->on('transactions.id', '=', 'revenues.transaction_id');
        })->where('revenues.transaction_id', '!=', null)
            ->sum('transactions.amount');
     }

    public function scopeTotalTransactionRev($query){
        return $query->join('revenues', function ($join){
            $join->on('revenues.tenant_id', '=', 'tenants.id');
        })->join('transactions', function ($join){
            $join->on('transactions.id', '=', 'revenues.transaction_id');
        })->where('revenues.transaction_id', '!=', null)->count();
    }
    public function scopeTotalTransactionInv($query){
        return $query->join('invoices', function ($join){
            $join->on('invoices.tenant_id', '=', 'tenants.id');
        })->join('invoice_payments', function ($join){
            $join->on('invoice_payments.invoice_id', '=', 'invoices.id');
        })->join('transactions', function ($join){
            $join->on('transactions.id', '=', 'invoice_payments.transaction_id');
        })->where('invoice_payments.transaction_id', '!=', null)->count();
    }

    public function scopeTransactionsInv($query){
        return $query->join('invoices', function ($join){
            $join->on('invoices.tenant_id', '=', 'tenants.id');
        })->join('invoice_payments', function ($join){
            $join->on('invoice_payments.invoice_id', '=', 'invoices.id');
        })->join('transactions', function ($join){
            $join->on('transactions.id', '=', 'invoice_payments.transaction_id');
        })->where('invoice_payments.transaction_id', '!=', null);
    }

    public function scopeTransactionRev($query){
        return $query->join('revenues', function ($join){
            $join->on('revenues.tenant_id', '=', 'tenants.id');
        })->join('transactions', function ($join){
            $join->on('transactions.id', '=', 'revenues.transaction_id');
        })->where('revenues.transaction_id', '!=', null);
    }


}
