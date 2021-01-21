<?php

namespace Modules\Expenses\Entities;

use App\Http\Traits\SearchableAndSortable;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Bill extends Model
{
    use HasFactory, SearchableAndSortable;

    protected $fillable = ['vendor_id', 'category_id', 'recurring_id', 'tax_id', 'price',
        'start_date', 'due_date', 'bill_number', 'note', 'attachment',
        'canceled', 'fixed'];
    protected $casts = [
        'canceled' => 'boolean',
        'fixed' => 'boolean'
    ];

    protected static function newFactory()
    {
        return \Modules\Expenses\Database\factories\BillFactory::new();
    }

    public function billPayments()
    {
        return $this->hasMany('\Modules\Expenses\Entities\BillPayment');
    }

    public function recurring()
    {
        return $this->belongsTo('\Modules\Expenses\Entities\Recurring');
    }

    public function category()
    {
        return $this->belongsTo('\Modules\Accounts\Entities\Category');
    }

    public function tax()
    {
        return $this->belongsTo('\Modules\Accounts\Entities\Tax');
    }

    public function vendor()
    {
        return $this->belongsTo('\Modules\Expenses\Entities\Vendor');
    }

}
