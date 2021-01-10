<?php

namespace Modules\Properties\Jobs\site;

use Illuminate\Bus\Queueable;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Contracts\Queue\ShouldQueue;

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
            $this->site = \Modules\Properties\Entities\Site::create($this->request->all());
        });
        return $this->site;
    }
}
