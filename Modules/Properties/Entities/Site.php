<?php

namespace Modules\Properties\Entities;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class site extends Model
{
    use HasFactory;

    protected $fillable = ["name", "address", "picture", "enabled"];
    
    protected static function newFactory()
    {
        return \Modules\Properties\Database\factories\SiteFactory::new();
    }

    
    public function properties(){
        return $this->hasMany('\Modules\Properties\Entities\Property');
    }


    public function blocks(){
        return $this->hasMany('\Modules\Properties\Entities\Block');
    }
    

    
    protected $site_id;
    public function scopeGetBlockedProperties($query, $site_id)
    {
        $this->site_id = $site_id;
        return $query->join('blocks', function($join){
                            $join->on('blocks.site_id', '=', 'sites.id');
                        })->join('properties', function($join){
                            $join->on('properties.block_id', '=', 'blocks.id');
                        })
                        ->where('sites.id', '=', $this->site_id)
                        ->where('blocks.site_id', '=', $this->site_id)
                        ->select("properties.*");
    }



}
