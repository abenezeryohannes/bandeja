<?php

namespace Modules\Accounts\Jobs\Tax;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Modules\Accounts\Entities\Tax;

class CreateTax implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;


    protected $tax = null;
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
            //check if same tax is already present
            $tax = Tax::where('name', '=', $this->request['name'])->first();
            if($tax!=null){ $this->response = "Same tax is already present."; return; }

            //create category
            $this->tax = Tax::create($this->request->all());

            if($this->tax == null) $this->response = "Internal Server Error!";
        });
        return ($this->response ==null)? $this->tax : $this->response;
    }

}
