<?php

namespace Modules\Properties\Jobs\Property;

use Illuminate\Contracts\Queue\ShouldQueue;

use Illuminate\Bus\Queueable;
use Illuminate\Foundation\Bus\Dispatchable;

class DeleteProperty implements ShouldQueue
{
    use Dispatchable, Queueable;

    protected $id = 0;
    protected $property = null;
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
                $this->response =  "Property is already deleted!";
            }else {
                $this->property->delete();
            }
        });
        return ($this->response == null)? true: $this->response;
    }
}
