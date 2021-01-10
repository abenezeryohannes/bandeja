<?php

namespace Modules\Properties\Jobs\block;

use Illuminate\Contracts\Queue\ShouldQueue;


use Illuminate\Bus\Queueable;
use Illuminate\Foundation\Bus\Dispatchable;

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
            $this->site = \Modules\Properties\Entities\Site::find($this->request["site_id"]);
            if($this->site == null) $this->response = "The Choosen site is not found!";

            //add block into the database
            $this->block = \Modules\Properties\Entities\Block::create($this->request->all());
            if($this->block == null) $this->response = "Internal Server Error!";

            //using for loop create all the properties inside the block

        });
        return ($this->response ==null)? $this->block : $this->response;
    }
}
