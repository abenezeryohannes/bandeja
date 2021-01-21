<?php

namespace Modules\Accounts\Entities;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Interest extends Model
{
    use HasFactory;

    protected $fillable = ['date', 'amount', 'account_id'];
    
    protected static function newFactory()
    {
        return \Modules\Accounts\Database\factories\InterestFactory::new();
    }

    public function account(){
        return $this->belongsTo('\Modules\Accounts\Entities\Account');
    }
}
