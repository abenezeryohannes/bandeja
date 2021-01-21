<?php

namespace Modules\Expenses\Jobs\Vendor;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Support\Facades\Schema;
use Modules\Accounts\Entities\Account;
use Modules\Accounts\Entities\Category;
use Modules\Accounts\Entities\Transaction;
use Modules\Expenses\Entities\Vendor;
use Modules\Expenses\Entities\VendorCategory;
use Modules\Incomes\Entities\Revenue;
use Modules\Properties\Entities\Property;
use Modules\Properties\Entities\PropertyCategory;
use Modules\Properties\Entities\Block;
use Modules\Properties\Entities\Site;

class SearchAndSortVendor implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $search = null;
    protected $sortBy = null;
    protected $order = null;
    protected $vendors = null;

    public function __construct($search, $sortBy, $order)
    {
        $this->search = $search;
        $this->sortBy = $sortBy;
        $this->order = $order;
    }


    public function handle()
    {
        $this->vendors = Vendor::join('vendor_categories', 'vendor_categories.id', 'vendors.vendor_category_id');

        //search
        if($this->search!=null){
           $this->vendors = $this->vendors
                ->whereLike(['vendors.name', 'vendor_categories.name'], $this->search);
        }

//      sort
        if($this->sortBy!=null ){

            if(!str_contains($this->sortBy, '.'))$this->sortBy = (new Vendor())->getTable() .'.'.$this->sortBy;
            if((new Vendor())->hasAttribute(strtolower($this->sortBy))
                    ||(new VendorCategory())->hasAttribute(strtolower($this->sortBy))) {

                $this->vendors->orderBy(strtolower($this->sortBy), ($this->order == null) ? 'asc' : strtolower($this->order));
            }
        }

        $this->vendors =  $this->vendors->select('vendors.*')->paginate();



        if($this->search) $this->vendors->appends(['search' => ($this->search)])->links();
        if($this->sortBy) $this->vendors->appends(['sort_by' => $this->sortBy])->links();
        if($this->order) $this->vendors->appends(['order' => $this->order])->links();

        return $this->vendors;
    }


}
