<?php

namespace Modules\Properties\Jobs\Site;

use Illuminate\Bus\Queueable;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Modules\Properties\Entities\Site;

class CreateSite implements ShouldQueue
{
    use Dispatchable, Queueable;

    protected $site = null;
    protected $response = "Internal server error";
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
            $this->site = Site::create($this->request->all());
            if($this->request['picture']!=null)
                $this->site->set_media('picture',$this->request['picture']);
            $this->site->save();
        });
        return $this->site;
    }
}
