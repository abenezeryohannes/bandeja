<?php

namespace Modules\Expenses\Entities;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class VendorCategory extends Model
{
    use HasFactory;

    protected $fillable = ['name', 'enabled'];

    protected $casts = [
        'enabled'=>'boolean'
    ];
    protected static function newFactory()
    {
        return \Modules\Expenses\Database\factories\VendorCategoriesFactory::new();
    }


    public function vendors(){
        return $this->hasMany('\Modules\Expenses\Entities\Vendor');
    }

}
