<?php

namespace Modules\Expenses\Entities;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Recurring extends Model
{
    use HasFactory;

    protected $fillable = ['name', 'interval', 'enabled'];
    protected $casts = [
        'canceled'=>'boolean'
    ];

    protected static function newFactory()
    {
        return \Modules\Expenses\Database\factories\RecurringFactory::new();
    }


    public function bills(){
        return $this->hasMany('\Modules\Expenses\Entities\Bill');
    }
}
