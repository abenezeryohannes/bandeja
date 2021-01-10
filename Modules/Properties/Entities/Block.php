<?php

namespace Modules\Properties\Entities;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Block extends Model
{
    use HasFactory;
    // protected $table = "blocks"; 

    protected $fillable = ["site_id", "name", "floors", "address", "picture", "enabled"];
    
    protected static function newFactory()
    {
        return \Modules\Properties\Database\factories\BlockFactory::new();
    }


    public function properties(){
        return $this->hasMany('\Modules\Properties\Entities\Property');
    }

    
    public function site(){
        return $this->belongsTo('\Modules\Properties\Entities\Site');
    }


}
