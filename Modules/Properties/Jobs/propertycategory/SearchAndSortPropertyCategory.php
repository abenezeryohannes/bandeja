<?php

namespace Modules\Properties\Jobs\Propertycategory;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Support\Facades\Schema;
use Modules\Properties\Entities\Property;
use Modules\Properties\Entities\PropertyCategory;
use Modules\Properties\Entities\Block;
use Modules\Properties\Entities\Site;

class SearchAndSortPropertyCategory implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $search = null;
    protected $sortBy = null;
    protected $order = null;
    protected $propCategories = null;

    public function __construct($search, $sortBy, $order)
    {
        $this->search = $search;
        $this->sortBy = $sortBy;
        $this->order = $order;
    }


    public function handle()
    {


        $this->propCategories = PropertyCategory::where('id', '>', 0);
        //search
        if($this->search!=null)
       $this->propCategories = PropertyCategory::query()->whereLike(['id', 'name', 'description', 'price', 'status'], $this->search);



//      sort
        if($this->sortBy!=null ){

            if(!str_contains($this->sortBy, '.'))$this->sortBy = (new PropertyCategory())->getTable() .'.'.$this->sortBy;
            if((new PropertyCategory())->hasAttribute(strtolower($this->sortBy)) ) {

                $this->propCategories->orderBy(strtolower($this->sortBy), ($this->order == null) ? 'asc' : strtolower($this->order));
            }
        }

        $this->propCategories =  $this->propCategories->select('property_categories.*')->paginate();


        if($this->search) $this->propCategories->appends(['search' => ($this->search)])->links();
        if($this->sortBy) $this->propCategories->appends(['sort_by' => $this->sortBy])->links();
        if($this->order) $this->propCategories->appends(['order' => $this->order])->links();

        return $this->propCategories;
    }


}
