<?php

namespace Modules\Accounts\Entities;

use App\Http\Traits\SearchableAndSortable;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Tax extends Model
{
    use HasFactory, SearchableAndSortable;

    protected $casts = [
        "enabled" => "boolean",
    ];


    protected $fillable = ['name', 'rate', 'enabled', 'description'];

    protected static function newFactory()
    {
        return \Modules\Accounts\Database\factories\TaxFactory::new();
    }

    public function transactions(){
        return $this->hasMany('\Modules\Accounts\Entities\Transaction');
    }

    public function invoices(){
        return $this->hasMany('\Modules\Incomes\Entities\Invoice');
    }
}
