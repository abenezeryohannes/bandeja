<?php

namespace Modules\Incomes\Jobs\Tenant;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Modules\Incomes\Entities\Tenant;

class CreateTenant implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $tenant = null;
    protected $response = null;
    protected $request;

    /**
     * Create a new job instance.
     *
     * @param  $request
     */
    public function __construct($request)
    {
        $this->request = ($request);
    }

    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle()
    {

        \DB::transaction(function() {

            $this->tenant = Tenant::create($this->request->all());

            if($this->tenant == null) $this->response = "Internal Server Error!";
        });
        return ($this->response ==null)? $this->tenant : $this->response;
    }
}
