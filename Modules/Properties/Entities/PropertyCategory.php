<?php

namespace Modules\Properties\Entities;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class PropertyCategory extends Model
{
    use HasFactory;

    protected $fillable = ["name", "description", "rent_price", "sale_price",
                           "size", "picture", "enabled"];
    
    protected static function newFactory()
    {
        return \Modules\Properties\Database\factories\PropertyCategoryFactory::new();
    }

    public function properties(){
        return $this->hasMany('\Modules\Properties\Entities\Property');
    }

}
