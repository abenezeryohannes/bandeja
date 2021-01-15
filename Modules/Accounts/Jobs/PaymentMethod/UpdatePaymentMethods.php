<?php

namespace Modules\Accounts\Jobs\Tax;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Modules\Accounts\Entities\Tax;

class UpdateTax implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $tax = null;
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
            $this->tax = Tax::find($this->id);
            if($this->tax == null){
                $this->response =  "No tax with this id!";
            }else {
                $this->request['name'] =($this->request['name']==null)? $this->tax->name : $this->request['name'];

                $tax = Tax::where('name', '=', $this->request['name'])->where('id', '!=', $this->id)->first();
                if($tax!=null){ $this->response = "Same tax is already present."; return; }

                $this->tax->update($this->request->all());
            }
        });
        return ($this->response == null)? $this->tax : $this->response;
    }
}
