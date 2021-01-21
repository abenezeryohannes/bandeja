<?php

namespace Modules\Expenses\Jobs\Bill;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Support\Facades\Schema;
use Modules\Accounts\Entities\Account;
use Modules\Accounts\Entities\Category;
use Modules\Accounts\Entities\Transaction;
use Modules\Expenses\Entities\Bill;
use Modules\Expenses\Entities\Vendor;
use Modules\Incomes\Entities\Revenue;
use Modules\Properties\Entities\Property;
use Modules\Properties\Entities\PropertyCategory;
use Modules\Properties\Entities\Block;
use Modules\Properties\Entities\Site;

class SearchAndSortBill implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $search = null;
    protected $sortBy = null;
    protected $order = null;
    protected $bills = null;

    public function __construct($search, $sortBy, $order)
    {
        $this->search = $search;
        $this->sortBy = $sortBy;
        $this->order = $order;
    }


    public function handle()
    {
        $this->bills = Bill::join('vendors', 'bills.vendor_id', '=', 'vendors.id');

        //search
        if($this->search!=null){
           $this->bills = $this->bills
                ->whereLike(['bills.bill_number', 'bills.start_date', 'bills.end_date', 'bills.due_date', 'vendors.name'], $this->search);
        }

//      sort
        if($this->sortBy!=null ){

            if(!str_contains($this->sortBy, '.'))$this->sortBy = (new Bill())->getTable() .'.'.$this->sortBy;
            if((new Bill())->hasAttribute(strtolower($this->sortBy))
                    ||(new Vendor())->hasAttribute(strtolower($this->sortBy))) {

                $this->bills->orderBy(strtolower($this->sortBy), ($this->order == null) ? 'asc' : strtolower($this->order));
            }
        }

        $this->bills =  $this->bills->select('bills.*')->paginate();



        if($this->search) $this->bills->appends(['search' => ($this->search)])->links();
        if($this->sortBy) $this->bills->appends(['sort_by' => $this->sortBy])->links();
        if($this->order) $this->bills->appends(['order' => $this->order])->links();

        return $this->bills;
    }


}
