<?php

namespace Modules\Properties\Jobs\Block;

use Illuminate\Contracts\Queue\ShouldQueue;

use Illuminate\Bus\Queueable;
use Illuminate\Foundation\Bus\Dispatchable;

class UpdateBlock implements ShouldQueue
{
    use Dispatchable, Queueable;

    protected $block = null;
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
            $this->block = \Modules\Properties\Entities\Block::find($this->id);
            if($this->block == null){
                $this->response =  "The site is unavailable!";
            }else {
               $this->block->update($this->request->all());
            }
        });
        return ($this->response == null)? $this->block : $this->response;
    }
}