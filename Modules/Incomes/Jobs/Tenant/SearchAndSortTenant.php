<?php

namespace Modules\Incomes\Jobs\Tenant;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Support\Facades\Schema;
use Modules\Accounts\Entities\Account;
use Modules\Incomes\Entities\Tenant;
use Modules\Properties\Entities\Property;
use Modules\Properties\Entities\PropertyCategory;
use Modules\Properties\Entities\Block;
use Modules\Properties\Entities\Site;

class SearchAndSortTenant implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $search = null;
    protected $sortBy = null;
    protected $order = null;
    protected $tenants = null;

    public function __construct($search, $sortBy, $order)
    {
        $this->search = $search;
        $this->sortBy = $sortBy;
        $this->order = $order;
    }


    public function handle()
    {
        $this->tenants = Tenant::where('id','>', 0);//Block::join('sites', 'blocks.site_id', '=', 'sites.id');

        //search
        if($this->search!=null){
           $this->tenants = $this->tenants
                ->whereLike(['name', 'phone_number'], $this->search);
        }

//      sort
        if($this->sortBy!=null ){


            if(!str_contains($this->sortBy, '.'))$this->sortBy = (new Tenant())->getTable() .'.'.$this->sortBy;

            if((new Tenant())->hasAttribute(strtolower($this->sortBy))) {

                $this->tenants->orderBy(strtolower($this->sortBy), ($this->order == null) ? 'asc' : strtolower($this->order));
            }
        }

        $this->tenants =  $this->tenants->select('tenants.*')->paginate();



        if($this->search) $this->tenants->appends(['search' => ($this->search)])->links();
        if($this->sortBy) $this->tenants->appends(['sort_by' => $this->sortBy])->links();
        if($this->order) $this->tenants->appends(['order' => $this->order])->links();

        return $this->tenants;
    }


}
