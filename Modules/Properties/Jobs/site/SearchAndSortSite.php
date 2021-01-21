<?php

namespace Modules\Properties\Jobs\Site;

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

class SearchAndSortSite implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $search = null;
    protected $sortBy = null;
    protected $order = null;
    protected $site = null;

    public function __construct($search, $sortBy, $order)
    {
        $this->search = $search;
        $this->sortBy = $sortBy;
        $this->order = $order;
    }


    public function handle()
    {

        $this->site = Site::where('id', '>', 0);
        //search
        if($this->search!=null)
           $this->site = Site::query()->whereLike(['name', 'address'], $this->search);



//      sort
        if($this->sortBy!=null ){

            if(!str_contains($this->sortBy, '.'))$this->sortBy = (new Site())->getTable() .'.'.$this->sortBy;
            if((new PropertyCategory())->hasAttribute(strtolower($this->sortBy)) ) {
                $this->site->orderBy(strtolower($this->sortBy), ($this->order == null) ? 'asc' : strtolower($this->order));
            }
        }

        $this->site =  $this->site->select('sites.*')->paginate();


        if($this->search) $this->site->appends(['search' => ($this->search)])->links();
        if($this->sortBy) $this->site->appends(['sort_by' => $this->sortBy])->links();
        if($this->order) $this->site->appends(['order' => $this->order])->links();

        return $this->site;
    
    }


}
