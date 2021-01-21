<?php

namespace Modules\Expenses\Entities;

use App\Http\Traits\SearchableAndSortable;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class VendorCategory extends Model
{
    use HasFactory, SearchableAndSortable;

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
