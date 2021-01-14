<?php

namespace Modules\Incomes\Jobs\Tenant;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Modules\Incomes\Entities\Tenant;

class UpdateTenant implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $tenant = null;
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
            $this->tenant = Tenant::find($this->id);
            if($this->tenant == null){
                $this->response =  "No tenant with this id found!";
            }else {
                $this->tenant->update($this->request->all());
            }
        });
        return ($this->response == null)? $this->tenant : $this->response;
    }
}
