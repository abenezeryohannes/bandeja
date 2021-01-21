<?php

namespace Modules\Incomes\Jobs\Invoice;

use Carbon\Carbon;
use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Support\Facades\Schema;
use Modules\Accounts\Entities\Account;
use Modules\Incomes\Entities\Invoice;
use Modules\Incomes\Entities\Tenant;
use Modules\Properties\Entities\Property;
use Modules\Properties\Entities\PropertyCategory;
use Modules\Properties\Entities\Block;
use Modules\Properties\Entities\Site;

class SearchAndSortInvoice implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $search = null;
    protected $sortBy = null;
    protected $order = null;
    protected $invoices = null;

    public function __construct($search, $sortBy, $order)
    {
        $this->search = $search;
        $this->sortBy = $sortBy;
        $this->order = $order;
    }


    public function handle()
    {
        $this->invoices = Invoice::join('tenants', 'invoices.tenant_id', '=', 'tenants.id');


        //search
        if($this->search!=null){
            $this->invoices = $this->invoices
                ->whereLike(['tenants.name', 'invoice_number', 'invoice_number', 'price', 'start_date', 'end_date', 'due_date'], $this->search);
        }

//      sort
        if($this->sortBy!=null ){

            if(!str_contains($this->sortBy, '.'))$this->sortBy = (new Invoice())->getTable() .'.'.$this->sortBy;
            if((new Invoice())->hasAttribute(strtolower($this->sortBy))
            || (new Tenant())->hasAttribute(strtolower($this->sortBy))) {
                $this->invoices->orderBy(strtolower($this->sortBy), ($this->order == null) ? 'asc' : strtolower($this->order));
            }
        }

        $this->invoices =  $this->invoices->select('invoices.*')->paginate();



        if($this->search) $this->invoices->appends(['search' => ($this->search)])->links();
        if($this->sortBy) $this->invoices->appends(['sort_by' => $this->sortBy])->links();
        if($this->order) $this->invoices->appends(['order' => $this->order])->links();

        return $this->invoices;
    }


}
