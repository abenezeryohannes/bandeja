<?php

namespace Modules\Accounts\Jobs\Category;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Modules\Accounts\Entities\Category;

class UpdateCategory implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;


    protected $category = null;
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
            $this->category = Category::find($this->id);
            if($this->category == null){
                $this->response =  "No category with this id!";
            }else {
                $this->request['type'] =($this->request['type']==null)? $this->category->type : $this->request['type'];
                $this->request['name'] =($this->request['name']==null)? $this->category->name : $this->request['name'];

                $categories = Category::where('name', '=', $this->request['name'])->where('type', '=', $this->request['type'])->where('id', '!=', $this->id)->first();
                if($categories!=null){ $this->response = "Same category is already present."; return; }

                $this->category->update($this->request->all());
            }
        });
        return ($this->response == null)? $this->category : $this->response;
    }
}
