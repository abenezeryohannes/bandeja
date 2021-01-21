<?php

namespace Modules\Properties\Jobs\Site;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use \Modules\Properties\Entities\Block;

use \Modules\Properties\Jobs\Property\DeleteProperty;
use \Modules\Properties\Entities\Property;

use \Modules\Properties\Jobs\Block\DeleteBlock;
class DeleteSite implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    
    protected $id = 0;
    protected $site = null;
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
            $this->site = \Modules\Properties\Entities\Site::find($this->id);
            if($this->site == null){
                $this->response =  "Site is already deleted!";
            }else {
                //deleteall Blocks and properties inside the site
                 $blocks = $this->site->blocks->pluck('id');
                 foreach($blocks as $block_id) {
                     $this->response = DeleteBlock::dispatchNow($block_id);
                     if($this->response != null && $this->response != true) return;
                    
                    }
                 //Block::destroy($blocks);

                 $props = $this->site->properties->pluck('id');
                 foreach($props as $prop_id) {
                    $this->response = DeleteProperty::dispatchNow($prop_id);
                     if($this->response != null && $this->response != true) return;
                    }
                 //Properties::destroy($props);
                

                $this->site->delete();
            }
        });
        return ($this->response == null || $this->response == true)? true: $this->response;
    }
}
