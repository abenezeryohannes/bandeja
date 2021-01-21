<?php

namespace Modules\Properties\Jobs\Site;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;

class UpdateSite implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $site = null;
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
            $this->site = \Modules\Properties\Entities\Site::find($this->id);
            if($this->site == null){
                $this->response =  "The site is unavailable!";
            }else {
               $this->site->update($this->request->all());
            }
        });
        return ($this->response == null)? $this->site : $this->response;
    }
}
