<?php

namespace Modules\Properties\Jobs\Block;

use Illuminate\Contracts\Queue\ShouldQueue;
use \Modules\Properties\Jobs\Property\DeleteProperty;
use \Modules\Properties\Entities\Property;

use Illuminate\Bus\Queueable;
use Illuminate\Foundation\Bus\Dispatchable;

class DeleteBlock implements ShouldQueue
{
    use Dispatchable, Queueable;
   
    protected $id = 0;
    protected $block = null;
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
            $this->block = \Modules\Properties\Entities\Block::find($this->id);
            if($this->block == null){
                $this->response =  "Block is already deleted!";
            }else {
                //delete all properties inside the block
                    $properties = $this->block->properties->pluck('id');
                    foreach($properties as $prop_id) {
                        $this->response = DeleteProperty::dispatchNow($prop_id);
                        if($this->response != null && $this->response != true) return;
                    }
                    //Property::destroy($properties);
                $this->block->delete();
            }
        });
        return ($this->response == null || $this->response == true)? true: $this->response;
    }
}