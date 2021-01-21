<?php

namespace Modules\Properties\Entities;

use App\Http\Traits\SearchableAndSortable;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Support\Arr;

class PropertyCategory extends Model
{
    use HasFactory, 
        \Modules\Util\Traits\Mediable, SearchableAndSortable;

    protected $fillable = ["name", "description", "rent_price", "sale_price",
                           "size", "picture", "enabled"];

    protected $casts= [
        "enabled"=>"boolean"
    ];


    protected $media_columns = ['picture'];

    protected $media_folder = "property_category";
    
    
    protected static function newFactory()
    {
        return \Modules\Properties\Database\factories\PropertyCategoryFactory::new();
    }


    public function properties(){
        return $this->hasMany('\Modules\Properties\Entities\Property');
    }

}
