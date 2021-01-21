<?php

namespace Modules\Accounts\Jobs\Interest;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Support\Facades\Schema;
use Modules\Accounts\Entities\Account;
use Modules\Accounts\Entities\Interest;
use Modules\Properties\Entities\Property;
use Modules\Properties\Entities\PropertyCategory;
use Modules\Properties\Entities\Block;
use Modules\Properties\Entities\Site;

class SearchAndSortInterest implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $search = null;
    protected $sortBy = null;
    protected $order = null;
    protected $interest = null;

    public function __construct($search, $sortBy, $order)
    {
        $this->search = $search;
        $this->sortBy = $sortBy;
        $this->order = $order;
    }


    public function handle()
    {
        $this->interest = Interest::join('accounts', 'interests.account_id', '=', 'accounts.id');

        //search
        if($this->search!=null){
           $this->interest = $this->interest
                ->whereLike(['interests.id', 'accounts.name', 'date', 'amount'], $this->search);
        }

//      sort
        if($this->sortBy!=null ){

            if(!str_contains($this->sortBy, '.'))$this->sortBy = (new Interest())->getTable() .'.'.$this->sortBy;

            if((new Interest())->hasAttribute(strtolower($this->sortBy))
            || (new Account())->hasAttribute(strtolower($this->sortBy))) {
                $this->interest->orderBy(strtolower($this->sortBy), ($this->order == null) ? 'asc' : strtolower($this->order));
            }
        }

        $this->interest =  $this->interest->select('interests.*')->paginate();



        if($this->search) $this->interest->appends(['search' => ($this->search)])->links();
        if($this->sortBy) $this->interest->appends(['sort_by' => $this->sortBy])->links();
        if($this->order) $this->interest->appends(['order' => $this->order])->links();

        return $this->interest;
    }


}
