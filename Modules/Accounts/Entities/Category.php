<?php

namespace Modules\Accounts\Entities;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Category extends Model
{
    use HasFactory;

    protected $casts = [
        "enabled" => "boolean",
    ];
    protected $fillable = ['name', 'type', 'color', 'enabled'];
    
    protected static function newFactory()
    {
        return \Modules\Accounts\Database\factories\CategoryFactory::new();
    }



    public function transactions(){
        return $this->hasMany('\Modules\Accounts\Entities\Transaction');
    }
}
