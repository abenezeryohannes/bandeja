<?php

namespace Modules\Accounts\Jobs\Tax;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Modules\Accounts\Entities\Tax;

class DeleteTax implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;
    protected $id = 0;
    protected $tax = null;
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
            $this->tax = Tax::find($this->id);
            if($this->tax == null){
                $this->response =  "No tax with this id is found!";
            }else {
                //if transactions are made with this tax attached dont delete the tax
                if($this->tax->transactions->count() > 0) {
                    $this->response = "Sorry, can't delete this tax. Some transactions are already attached to it.";
                }
                //if invoices are made with this tax attached dont delete the tax
                if($this->tax->invoices->count() > 0) {
                    $this->response = "Sorry, can't delete this tax. Some invoices are already attached to it.";
                }
                else $this->tax->delete();
            }
        });
        return ($this->response == null || !is_string($this->response))? true: $this->response;
    }
}
