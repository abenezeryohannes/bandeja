<?php

namespace Modules\Expenses\Jobs\Payment;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Support\Facades\Schema;
use Modules\Accounts\Entities\Account;
use Modules\Accounts\Entities\Category;
use Modules\Accounts\Entities\Transaction;
use Modules\Expenses\Entities\Payment;
use Modules\Expenses\Entities\Vendor;
use Modules\Incomes\Entities\Revenue;
use Modules\Properties\Entities\Property;
use Modules\Properties\Entities\PropertyCategory;
use Modules\Properties\Entities\Block;
use Modules\Properties\Entities\Site;

class SearchAndSortPayment implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $search = null;
    protected $sortBy = null;
    protected $order = null;
    protected $payments = null;

    public function __construct($search, $sortBy, $order)
    {
        $this->search = $search;
        $this->sortBy = $sortBy;
        $this->order = $order;
    }


    public function handle()
    {
        $this->payments = Payment::join('transactions', 'payments.transaction_id', '=', 'transactions.id')
                                        ->join('vendors', 'payments.vendor_id', '=', 'vendors.id')
                                        ->join('categories', 'transactions.category_id', 'categories.id')
                                        ->where('payments.transaction_id', '!=', null);

        //search
        if($this->search!=null){
           $this->payments = $this->payments
                ->whereLike(['transactions.transaction_date', 'transactions.amount', 'vendors.name', 'categories.name'], $this->search);
        }

//      sort
        if($this->sortBy!=null ){

            if(!str_contains($this->sortBy, '.'))$this->sortBy = (new Payment())->getTable() . '.' . $this->sortBy;

            if((new Payment())->hasAttribute(strtolower($this->sortBy))
                    ||(new Category())->hasAttribute(strtolower($this->sortBy))
                    ||(new Vendor())->hasAttribute(strtolower($this->sortBy))
                    ||(new Transaction())->hasAttribute(strtolower($this->sortBy))) {

                $this->payments->orderBy(strtolower($this->sortBy), ($this->order == null) ? 'asc' : strtolower($this->order));
            }
        }

        $this->payments =  $this->payments->select('payments.*')->paginate();



        if($this->search) $this->payments->appends(['search' => ($this->search)])->links();
        if($this->sortBy) $this->payments->appends(['sort_by' => $this->sortBy])->links();
        if($this->order) $this->payments->appends(['order' => $this->order])->links();

        return $this->payments;
    }


}
