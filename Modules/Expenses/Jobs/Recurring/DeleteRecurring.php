<?php

namespace Modules\Expenses\Jobs\Recurring;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Modules\Expenses\Entities\Recurring;

class DeleteRecurring implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $id = 0;
    protected $recurring = null;
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
            $this->recurring = Recurring::find($this->id);
            if($this->recurring == null){
                $this->response =  "No recurring found with this id!";
            }else {
                //if recurring is connected to bill dont delete the recurring
                if($this->recurring->bills()->count() > 0) {
                    $this->response = "Sorry, can't delete this recurring because it is connected to some bills record.";
                }
                else $this->recurring->delete();
            }
        });
        return ($this->response == null || !is_string($this->response))? true: $this->response;
    }
}
