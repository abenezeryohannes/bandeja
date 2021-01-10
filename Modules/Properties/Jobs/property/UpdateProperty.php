<?php

namespace Modules\Properties\Jobs\property;

use Illuminate\Contracts\Queue\ShouldQueue;

use Illuminate\Bus\Queueable;
use Illuminate\Foundation\Bus\Dispatchable;

class UpdateProperty implements ShouldQueue
{
    use Dispatchable, Queueable;

    protected $property = null;
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
            $this->property = \Modules\Properties\Entities\Property::find($this->id);
            if($this->property == null){
                $this->response =  "The site is unavailable!";
            }else {
               $this->property->update($this->request->all());
            }
        });
        return ($this->response == null)? $this->property : $this->response;
    }
}