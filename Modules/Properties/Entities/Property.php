<?php

namespace Modules\Properties\Entities;

use App\Http\Traits\SearchableAndSortable;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Property extends Model
{
    use HasFactory, SearchableAndSortable;

    protected $fillable = ["name", "inside_block", "site_id", "block_id", "property_category_id",
     "floor", "address", "available_after", "enabled"];

    protected $casts= [
        "enabled"=>"boolean"
    ];





    protected static function newFactory()
    {
        return \Modules\Properties\Database\factories\PropertyFactory::new();
    }


    
    public function propertyCategory(){
        return $this->belongsTo('\Modules\Properties\Entities\PropertyCategory');
    }

    public function invoices(){
        return $this->hasMany('\Modules\Incomes\Entities\Invoice');
    }

    
    public function site(){
        return $this->belongsTo('\Modules\Properties\Entities\Site');
    }
    
    public function block(){
        return $this->belongsTo('\Modules\Properties\Entities\Block');
    }

}
