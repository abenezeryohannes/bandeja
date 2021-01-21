<?php

namespace Modules\Incomes\Jobs\Revenue;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Support\Facades\Schema;
use Modules\Accounts\Entities\Account;
use Modules\Accounts\Entities\Category;
use Modules\Accounts\Entities\Transaction;
use Modules\Incomes\Entities\Revenue;
use Modules\Properties\Entities\Property;
use Modules\Properties\Entities\PropertyCategory;
use Modules\Properties\Entities\Block;
use Modules\Properties\Entities\Site;

class SearchAndSortRevenue implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $search = null;
    protected $sortBy = null;
    protected $order = null;
    protected $revenues = null;

    public function __construct($search, $sortBy, $order)
    {
        $this->search = $search;
        $this->sortBy = $sortBy;
        $this->order = $order;
    }


    public function handle()
    {
        $this->revenues = Revenue::join('transactions', 'revenues.transaction_id', '=', 'transactions.id')
                                        ->join('tenants', 'revenues.tenant_id', '=', 'tenants.id')
                                        ->join('categories', 'transactions.category_id', 'categories.id')
                                        ->where('revenues.transaction_id', '!=', null);

        //search
        if($this->search!=null){
           $this->revenues = $this->revenues
                ->whereLike(['transactions.transaction_date', 'transactions.amount', 'tenants.name', 'categories.name'], $this->search);
        }

//      sort
        if($this->sortBy!=null ){

            if(!str_contains($this->sortBy, '.'))$this->sortBy = (new Revenue())->getTable() .'.'.$this->sortBy;
            if((new Revenue())->hasAttribute(strtolower($this->sortBy))
                    ||(new Category())->hasAttribute(strtolower($this->sortBy))
                    ||(new Transaction())->hasAttribute(strtolower($this->sortBy))) {

                $this->revenues->orderBy(strtolower($this->sortBy), ($this->order == null) ? 'asc' : strtolower($this->order));
            }
        }

        $this->revenues =  $this->revenues->select('revenues.*')->paginate();



        if($this->search) $this->revenues->appends(['search' => ($this->search)])->links();
        if($this->sortBy) $this->revenues->appends(['sort_by' => $this->sortBy])->links();
        if($this->order) $this->revenues->appends(['order' => $this->order])->links();

        return $this->revenues;
    }


}
