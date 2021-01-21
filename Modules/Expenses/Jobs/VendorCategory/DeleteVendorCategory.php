<?php

namespace Modules\Expenses\Jobs\VendorCategory;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Modules\Expenses\Entities\Vendor;
use Modules\Expenses\Entities\VendorCategory;

class DeleteVendorCategory implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $id = 0;
    protected $vendor_category = null;
    protected $response = null;

    /**
     * Create a new job instance.
     *
     * @param  $request
     */
    public function __construct($id)
    {
        $this->id = $id;
    }


    public function handle()
    {
        \DB::transaction(function() {
            $this->vendor_category = VendorCategory::find($this->id);
            if($this->vendor_category == null){
                $this->response =  "No vendor category found with this id!";
            }else {
                //if vendor category is connected to vendor dont delete the recurring
                if(Vendor::VendorCatbills($this->vendor_category->id)->count() > 0) {
                    $this->response = "Sorry, can't delete this category because it is already connected to some vendors.";
                }
                else $this->vendor_category->delete();
            }
        });
        return ($this->response == null || !is_string($this->response))? true: $this->response;
    }
}
