<?php

namespace Modules\Accounts\Jobs\Account;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Support\Facades\Schema;
use Modules\Accounts\Entities\Account;
use Modules\Properties\Entities\Property;
use Modules\Properties\Entities\PropertyCategory;
use Modules\Properties\Entities\Block;
use Modules\Properties\Entities\Site;

class SearchAndSortAccount implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $search = null;
    protected $sortBy = null;
    protected $order = null;
    protected $account = null;

    public function __construct($search, $sortBy, $order)
    {
        $this->search = $search;
        $this->sortBy = $sortBy;
        $this->order = $order;
    }


    public function handle()
    {
        $this->account = Account::where('id','>', 0);//Block::join('sites', 'blocks.site_id', '=', 'sites.id');

        //search
        if($this->search!=null){
           $this->account = Account::query()
                ->whereLikeIn(['name', 'bank', 'account_number', 'balance'], $this->search);
        }

//      sort
        if($this->sortBy!=null ){

            if(!str_contains($this->sortBy, '.'))$this->sortBy = (new Account())->getTable() .'.'.$this->sortBy;
            if((new Account())->hasAttribute(strtolower($this->sortBy))) {

                $this->account->orderBy(strtolower($this->sortBy), ($this->order == null) ? 'asc' : strtolower($this->order));
            }
        }

        $this->account =  $this->account->select('accounts.*')->paginate();



        if($this->search) $this->account->appends(['search' => ($this->search)])->links();
        if($this->sortBy) $this->account->appends(['sort_by' => $this->sortBy])->links();
        if($this->order) $this->account->appends(['order' => $this->order])->links();

        return $this->account;
    }


}
