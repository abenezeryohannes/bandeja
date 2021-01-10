<?php

namespace Modules\Properties\Jobs\propertycategory;

use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Bus\Queueable;
use Illuminate\Foundation\Bus\Dispatchable;


use \Modules\Properties\Jobs\Property\DeleteProperty;
use \Modules\Properties\Entities\Property;
use \Modules\Properties\Entities\PropertyCategory;

class DeletePropertyCategory implements ShouldQueue
{
    use Dispatchable, Queueable;

   
    protected $id = 0;
    protected $propertyCategory = null;
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
            $this->propertyCategory = PropertyCategory::find($this->id);
            if($this->propertyCategory == null){
                $this->response =  "This property type is already deleted!";
            }else {
                //delete all properties inside the block
                    $properties = $this->propertyCategory->properties->pluck('id');
                    foreach($properties as $prop_id) {
                        $this->response = DeleteProperty::dispatchNow($prop_id);
                        if($this->response != null && $this->response != true) return;
                    }
                    //Property::destroy($properties);
                $this->propertyCategory->delete();
            }
        });
        return ($this->response == null || $this->response == true)? true: $this->response;
    }
}
