<?php

namespace Modules\Incomes\Entities;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class CanceledInvoice extends Model
{
    use HasFactory;

    protected $fillable = ['reason', 'by', 'previous_end_date', 'invoice_id'];

    protected static function newFactory()
    {
        return \Modules\Incomes\Database\factories\CanceledInvoiceFactory::new();
    }


    public function invoice(){
        return $this->belongsTo('\Modules\Incomes\Entities\Invoice');
    }

}
