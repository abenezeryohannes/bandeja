<?php

namespace Modules\Properties\Jobs\Block;

use Illuminate\Contracts\Queue\ShouldQueue;


use Illuminate\Bus\Queueable;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Http\Request;
use Modules\Properties\Entities\Block;
use Modules\Properties\Entities\Property;
use Modules\Properties\Entities\Site;
use Modules\Properties\Jobs\property\CreateProperty;

class CreateBlock implements ShouldQueue
{
    use Dispatchable, Queueable;

    protected $block = null;
    protected $site = null;
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

            //check if the linked site is available
            $this->site = Site::find($this->request["site_id"]);
            if($this->site == null) $this->response = "The choosen site is not found!";

            //add block into the database
            $this->block = Block::create($this->request->all());
                if($this->request['picture']!=null)
                    $this->block->set_media('picture',$this->request['picture']);
            $this->block->save();

            if($this->block == null) $this->response = "Internal Server Error!";

            //using for loop create all the properties inside the block
            //properties sample date
            //{
            //  "data":[
            //            {
            //              "property_category_id": 3,
            //              "properties": "2,3,23,43,4,5,53,42,13,6"
            //    		}
            //  ]
            //}

            $data = json_decode($this->request['properties'], true);


            foreach($data['data'] as $i => $d)
            {

                $property_category_id = $d['property_category_id'];
                $properties_name = explode(",", $d['properties']);

                foreach ($properties_name as $p_name){
                    $request = new Request();
                    $request['name'] = $this->block->site()->first()->name . " " . $this->block->name .  " Property " . $p_name;
                    $request['inside_block'] = true;
                    $request['block_id'] = $this->block->id;
                    $request['property_category_id'] = $property_category_id;
                    CreateProperty::dispatchNow($request);
                }
            }


        });
        return ($this->response ==null)? $this->block : $this->response;
    }
}
