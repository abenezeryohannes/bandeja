<?php

namespace App\Http\Traits;

trait SearchableAndSortable {


    public function hasAttribute($attr)
    {
        if(str_contains($attr, '.')){
            //get the table
            $table = substr($attr,0, strpos($attr, '.'));
            //check if table is correct
            if(($table) != ($this->getTable())){ return false; }
            //get the attribute
            $attr = substr($attr, strpos($attr, '.')+1);
        }
        foreach ($this->fillable as $fil) if($fil == $attr) return true;
        return false;
    }
}