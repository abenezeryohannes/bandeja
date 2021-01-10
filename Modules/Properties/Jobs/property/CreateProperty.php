<?php

namespace Modules\Properties\Jobs\property;

use Illuminate\Contracts\Queue\ShouldQueue;

use Illuminate\Bus\Queueable;
use Illuminate\Foundation\Bus\Dispatchable;

class CreateProperty implements ShouldQueue
{
    use Dispatchable, Queueable;

    
    protected $property = null;
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
        // if($this->request['name'] == null) 
        //     $this->request['name'] =  $this->request['name'] . " " .  $this->request['name'] . "" . "NO " + $this->request['name'];

        \DB::transaction(function() {

            
            //add property into the database
            $this->property = \Modules\Properties\Entities\Property::create($this->request->all());
            if($this->property == null) $this->response = "Inserted Data are not correct!";


        });
        return ($this->response ==null)? $this->property : $this->response;
    }
}
