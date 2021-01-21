<?php

namespace Modules\Accounts\Entities;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class PaymentMethod extends Model
{
    use HasFactory;

    protected $fillable = ['name', 'enabled'];

    protected $casts = [
        "enabled" => "boolean",
    ];

    protected static function newFactory()
    {
        return \Modules\Accounts\Database\factories\PaymentMethodFactory::new();
    }


    public function transactions(){
        return $this->hasMany('\Modules\Accounts\Entities\Transaction');
    }
}
