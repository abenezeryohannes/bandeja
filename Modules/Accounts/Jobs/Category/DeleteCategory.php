<?php

namespace Modules\Accounts\Jobs\Category;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Modules\Accounts\Entities\Category;

class DeleteCategory implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;
    protected $id = 0;
    protected $category = null;
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


    public function handle()
    {
        \DB::transaction(function() {
            $this->category = Category::find($this->id);
            if($this->category == null){
                $this->response =  "No category with this id is found!";
            }else {
                //if transactions are made with this category attached dont delete the category
                if($this->category->transactions->count() > 0) {
                    $this->response = "Sorry, can't delete this category. Some transactions are already attached to it.";
                }
                else $this->category->delete();
            }
        });
        return ($this->response == null || !is_string($this->response))? true: $this->response;
    }
}
