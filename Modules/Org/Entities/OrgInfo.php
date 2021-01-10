<?php

namespace Modules\Org\Entities;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class OrgInfo extends \App\Models\LocalizableModel
{
    use HasFactory;

    protected $fillable = [
    	'code', 'value_en', 'value_am', 'type'
    ];
    
    protected $localizable = [
        'value',
    ];
    
    protected static function newFactory()
    {
        return \Modules\Org\Database\factories\OrgInfoFactory::new();
    }
}
