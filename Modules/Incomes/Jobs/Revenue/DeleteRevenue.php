<?php

namespace Modules\Incomes\Jobs\Revenue;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Modules\Accounts\Jobs\Transaction\DeleteTransaction;
use Modules\Incomes\Entities\Revenue;

class DeleteRevenue implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $id = 0;
    protected $revenue = null;
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
            $this->revenue = Revenue::find($this->id);
            if($this->revenue == null){
                $this->response =  "No revenue found with this id!";
            }else {

                //to delete revenue delete the transaction created with that revenue;
                $transaction = $this->revenue->transaction()->first();
                if($transaction!=null) { DeleteTransaction::dispatchNow($transaction); }

                $this->revenue->delete();

            }
        });
        return ($this->response == null || !is_string($this->response))? true: $this->response;
    }
}
