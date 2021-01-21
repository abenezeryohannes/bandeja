<?php

namespace Modules\Expenses\Jobs\Payment;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Modules\Accounts\Entities\Account;
use Modules\Accounts\Entities\Category;
use Modules\Accounts\Jobs\Transaction\UpdateTransaction;
use Modules\Expenses\Entities\Payment;
use Modules\Expenses\Entities\Vendor;

class UpdatePayment implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $payment = null;
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

            $this->payment = Payment::find($this->id);

            if($this->payment == null){

                $this->response =  "No payment found with this id!";

            }else {


                if($this->request['category_id']!=null&&Category::find($this->request['category_id']) == null){
                    $this->response = "No category found with this id!";
                    return;
                }

                if($this->request['vendor_id']!=null&&Vendor::find($this->request['vendor_id']) == null){
                    $this->response = "No vendor found with this id!";
                    return;
                }


                if($this->request['account_id']!=null&&Account::find($this->request['account_id']) == null){
                    $this->response = "No account found with this id!";
                    return;
                }


                $transaction = $this->payment->transaction()->first();
                if($transaction!=null){
                    $this->response = UpdateTransaction::dispatchNow($this->request, $transaction->id);
                    if(is_string($this->response)) return;
                    else $this->response = null;
                }
                $this->payment->update($this->request->all());
            }
        });
        return ($this->response == null)? $this->payment : $this->response;
    }
}
