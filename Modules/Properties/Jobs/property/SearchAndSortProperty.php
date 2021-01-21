<?php

namespace Modules\Properties\Jobs\Property;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Support\Facades\Schema;
use Modules\Properties\Entities\Property;
use Modules\Properties\Entities\PropertyCategory;

class SearchAndSortProperty implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $search = null;
    protected $sortBy = null;
    protected $order = null;
    protected $properties = null;

    public function __construct($search, $sortBy, $order)
    {
        $this->search = $search;
        $this->sortBy = $sortBy;
        $this->order = $order;
    }


    public function handle()
    {
        $this->properties = Property::join('property_categories', 'properties.property_category_id', '=', 'property_categories.id');

        //search
        if($this->search!=null){
           $this->properties = $this->properties
                ->whereLike(['properties.name', 'properties.address', 'property_categories.name'], $this->search);
        }

//      sort
        if($this->sortBy!=null ){
            if(!str_contains($this->sortBy, '.'))$this->sortBy = (new Property())->getTable() .'.'.$this->sortBy;

            if((new Property())->hasAttribute(strtolower($this->sortBy))
                ||
                (new PropertyCategory())->hasAttribute(strtolower($this->sortBy)) ) {

                $this->properties->orderBy(strtolower($this->sortBy), ($this->order == null) ? 'asc' : strtolower($this->order));
            }
        }

        $this->properties = $this->properties->select('properties.*')->paginate();



        if($this->search) $this->properties->appends(['search' => ($this->search)])->links();
        if($this->sortBy) $this->properties->appends(['sort_by' => $this->sortBy])->links();
        if($this->order) $this->properties->appends(['order' => $this->order])->links();

        return $this->properties;
    }


}
