<?php

namespace Modules\Properties\Jobs\Propertycategory;

use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Bus\Queueable;
use Illuminate\Foundation\Bus\Dispatchable;

class CreatePropertyCategory implements ShouldQueue
{
    use Dispatchable, Queueable;

    protected $property_category = null;
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

            
            //add property_category into the database
            $this->property_category = \Modules\Properties\Entities\PropertyCategory::create($this->request->all());
            if($this->request['picture']!=null)
                $this->property_category->set_media('picture',$this->request['picture']);
            $this->property_category->save();

            if($this->property_category == null) $this->response = "Inserted Data are not correct!";


        });
        return ($this->response ==null)? $this->property_category : $this->response;
    }
}
