<?php

namespace Modules\Expenses\Jobs\VendorCategory;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Modules\Expenses\Entities\VendorCategory;

class UpdateVendorCategory implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $vendor_category = null;
    protected $id = 0;
    protected $request;
    protected $response = null;

    /**
     * Create a new job instance.
     *
     * @param  $request
     */
    public function __construct($request, $id)
    {
        $this->request = ($request);
        $this->id = $id;
    }

    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle()
    {

        \DB::transaction(function() {
            $this->vendor_category = VendorCategory::find($this->id);
            if($this->vendor_category == null){
                $this->response =  "No tenant with this id found!";
            }else {
                $this->vendor_category->update($this->request->all());
            }
        });
        return ($this->response == null)? $this->vendor_category : $this->response;
    }
}
