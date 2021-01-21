<?php

namespace Modules\Expenses\Jobs\Vendor;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Modules\Expenses\Entities\Vendor;

class UpdateVendor implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $vendor = null;
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
            $this->vendor = Vendor::find($this->id);
            if($this->vendor == null){
                $this->response =  "No vendor with this id found!";
            }else {
                $this->vendor->update($this->request->all());
            }
        });
        return ($this->response == null)? $this->vendor : $this->response;
    }
}
