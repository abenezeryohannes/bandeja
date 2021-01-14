<?php

namespace Modules\Incomes\Jobs\Tenant;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Modules\Incomes\Entities\Tenant;

class DeleteTenant implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $id = 0;
    protected $tenant = null;
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
            $this->tenant = Tenant::find($this->id);
            if($this->tenant == null){
                $this->response =  "No tenant found with this id!";
            }else {
                //if tenant is connected to invoice or revenue dont delete the tenant
                if($this->tenant->revenues()->count() > 0) {
                    $this->response = "Sorry, can't delete this tenant because it is connected to some invoices record.";
                }else if($this->tenant->invoices()->count() != 0) {
                    $this->response = "Sorry, can't delete this tenant because it is connected to some revenues record.";
                }
                else $this->tenant->delete();
            }
        });
        return ($this->response == null || !is_string($this->response))? true: $this->response;
    }
}
