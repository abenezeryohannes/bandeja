<?php

namespace Modules\Accounts\Jobs\Transaction;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Support\Facades\Schema;
use Modules\Accounts\Entities\Account;
use Modules\Accounts\Entities\Category;
use Modules\Accounts\Entities\Interest;
use Modules\Accounts\Entities\Transaction;
use Modules\Properties\Entities\Property;
use Modules\Properties\Entities\PropertyCategory;
use Modules\Properties\Entities\Block;
use Modules\Properties\Entities\Site;

class SearchAndSortTransaction implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $search = null;
    protected $sortBy = null;
    protected $order = null;
    protected $transaction = null;

    public function __construct($search, $sortBy, $order)
    {
        $this->search = $search;
        $this->sortBy = $sortBy;
        $this->order = $order;
    }


    public function handle()
    {
        $this->transaction = Transaction::Join('categories', 'transactions.category_id', '=', 'categories.id')
                ->join('accounts', 'transactions.account_id', '=', 'accounts.id');

        //search
        if($this->search!=null){
           $this->transaction = $this->transaction
                ->whereLike(['transactions.id', 'accounts.name', 'transaction_date', 'amount', 'categories.type', 'categories.name'], $this->search);
        }

//      sort
        if($this->sortBy!=null ){

            if(!str_contains($this->sortBy, '.'))$this->sortBy = (new Transaction())->getTable() .'.'.$this->sortBy;
            if((new Transaction())->hasAttribute(strtolower($this->sortBy))
                || (new Account())->hasAttribute(strtolower($this->sortBy))
                || (new Category())->hasAttribute(strtolower($this->sortBy))) {

                $this->transaction->orderBy(strtolower($this->sortBy), ($this->order == null) ? 'asc' : strtolower($this->order));
            }
        }

        $this->transaction =  $this->transaction->select('transactions.*')->paginate();



        if($this->search) $this->transaction->appends(['search' => ($this->search)])->links();
        if($this->sortBy) $this->transaction->appends(['sort_by' => $this->sortBy])->links();
        if($this->order) $this->transaction->appends(['order' => $this->order])->links();

        return $this->transaction;
    }


}
