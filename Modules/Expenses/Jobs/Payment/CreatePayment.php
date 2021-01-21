<?php

namespace Modules\Expenses\Jobs\Payment;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Modules\Accounts\Entities\Account;
use Modules\Accounts\Entities\Category;
use Modules\Accounts\Jobs\Transaction\CreateTransaction;
use Modules\Expenses\Entities\Payment;
use Modules\Expenses\Entities\Vendor;

class CreatePayment implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;


    protected $payment = null;
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

            if(Category::find($this->request['category_id']) == null){
                $this->response = "No category with this id!";
                return;
            }
            if(Vendor::find($this->request['vendor_id']) == null){
                $this->response = "No vendor with this id!";
                return;
            }
            if(Account::find($this->request['account_id']) == null){
                $this->response = "No account with this id!";
                return;
            }

            $trans_req = $this->request;
            $trans_req['type'] = 'payment';
            $this->response = CreateTransaction::dispatchNow($trans_req);

            if(is_string($this->response)) return;
            else {
                $this->request['transaction_id'] = $this->response->id;
                $this->payment = Payment::create($this->request->all());
                $this->response = null;
            }

            if($this->payment == null) $this->response = "Internal Server Error!";
        });
        return ($this->response ==null)? $this->payment : $this->response;
    }
}
