<?php

namespace Modules\Properties\Jobs\Block;

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

class SearchAndSortBlock implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $search = null;
    protected $sortBy = null;
    protected $order = null;
    protected $blocks = null;

    public function __construct($search, $sortBy, $order)
    {
        $this->search = $search;
        $this->sortBy = $sortBy;
        $this->order = $order;
    }


    public function handle()
    {
        $this->blocks = Block::join('sites', 'blocks.site_id', '=', 'sites.id');

        //search
        if($this->search!=null){
           $this->blocks = $this->blocks
                ->whereLike(['blocks.name', 'blocks.address', 'sites.name', 'blocks.floors'], $this->search);
        }



//      sort
        if($this->sortBy!=null ){
            if(!str_contains($this->sortBy, '.'))$this->sortBy = (new Block())->getTable() .'.'.$this->sortBy;
            if((new Block())->hasAttribute(strtolower($this->sortBy))
                ||
                (new Site())->hasAttribute(strtolower($this->sortBy)) ) {

                $this->blocks->orderBy(strtolower($this->sortBy), ($this->order == null) ? 'asc' : strtolower($this->order));
            }
        }

        $this->blocks =  $this->blocks->select('blocks.*')->paginate();



        if($this->search) $this->blocks->appends(['search' => ($this->search)])->links();
        if($this->sortBy) $this->blocks->appends(['sort_by' => $this->sortBy])->links();
        if($this->order) $this->blocks->appends(['order' => $this->order])->links();

        return $this->blocks;
    }


}
