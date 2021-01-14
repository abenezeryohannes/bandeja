<?php

namespace Modules\Accounts\Jobs\Category;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Modules\Accounts\Entities\Category;

class CreateCategory implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $category = null;
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
            //check if same category is already present
            $categories = Category::where('name', '=', $this->request['name'])->where('type', '=', $this->request['type'])->first();
            if($categories!=null){ $this->response = "Same category is already present."; return; }

            //create category
            $this->category = Category::create($this->request->all());

            if($this->category == null) $this->response = "Internal Server Error!";
        });
        return ($this->response ==null)? $this->category : $this->response;
    }
}
