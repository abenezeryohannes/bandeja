<?php

namespace Modules\Accounts\Entities;

use App\Http\Traits\SearchableAndSortable;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Account extends Model
{
    use HasFactory, SearchableAndSortable;

    protected $casts = [
        "enabled" => "boolean",
        "main_account" => "boolean",
    ];

    protected $fillable =  ['name', 'account_number', 'opening_balance', 'balance',
        'bank', 'type', 'main_account', 'enabled'];

    protected static function newFactory()
    {
        return \Modules\Accounts\Database\factories\AccountFactory::new();
    }

    public function transactions(){
        return $this->hasMany('\Modules\Accounts\Entities\Transaction');
    }
}
