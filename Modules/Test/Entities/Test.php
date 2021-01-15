<?php

namespace Modules\Test\Entities;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Test extends Model
{
    use HasFactory,
    	\Modules\Util\Traits\Mediable;

    protected $fillable = [ 'media_data', 'title', 'body' ];
    
    protected static function newFactory()
    {
        return \Modules\Test\Database\factories\TestFactory::new();
    }

    protected $casts = [
    	
    ];

    
}
