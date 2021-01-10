<?php

namespace Modules\Properties\Jobs\propertycategory;

use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Bus\Queueable;
use Illuminate\Foundation\Bus\Dispatchable;

class UpdatePropertyCategory implements ShouldQueue
{
    use Dispatchable, Queueable;

    protected $propertyCategory = null;
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
            $this->propertyCategory = \Modules\Properties\Entities\PropertyCategory::find($this->id);
            if($this->propertyCategory == null){
                $this->response =  "The site is unavailable!";
            }else {
               $this->propertyCategory->update($this->request->all());
            }
        });
        return ($this->response == null)? $this->propertyCategory : $this->response;
    }
}
