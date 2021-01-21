<?php

namespace Modules\Incomes\Jobs\Revenue;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Modules\Accounts\Entities\Account;
use Modules\Accounts\Entities\Category;
use Modules\Accounts\Entities\Transaction;
use Modules\Accounts\Jobs\Transaction\CreateTransaction;
use Modules\Incomes\Entities\Revenue;
use Modules\Incomes\Entities\Tenant;

class CreateRevenue implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $revenue = null;
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
            if(Tenant::find($this->request['tenant_id']) == null){
                $this->response = "No tenant with this id!";
                return;
            }
            if(Account::find($this->request['account_id']) == null){
                $this->response = "No account with this id!";
                return;
            }



            $trans_req = $this->request;
            $trans_req['amount'] = $this->request['price'] ?? $this->request['amount'];
            $trans_req['type'] = 'revenue';
            $this->response = CreateTransaction::dispatchNow($trans_req);

            if(is_string($this->response)) return;
            else {
                $this->request['transaction_id'] = $this->response->id;
                $this->revenue = Revenue::create($this->request->all());
                $this->response = null;
            }

            if($this->revenue == null) $this->response = "Internal Server Error!";
        });
        return ($this->response ==null)? $this->revenue : $this->response;
    }
}
