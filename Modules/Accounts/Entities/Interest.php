<?php

namespace Modules\Accounts\Entities;

use App\Http\Traits\SearchableAndSortable;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Interest extends Model
{
    use HasFactory, SearchableAndSortable;

    protected $fillable = ['date', 'amount', 'account_id'];
    
    protected static function newFactory()
    {
        return \Modules\Accounts\Database\factories\InterestFactory::new();
    }

    public function account(){
        return $this->belongsTo('\Modules\Accounts\Entities\Account');
    }
}
