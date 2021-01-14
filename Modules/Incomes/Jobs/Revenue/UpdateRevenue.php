<?php

namespace Modules\Incomes\Jobs\Revenue;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Modules\Accounts\Entities\Account;
use Modules\Accounts\Entities\Category;
use Modules\Accounts\Jobs\Transaction\CreateTransaction;
use Modules\Accounts\Jobs\Transaction\UpdateTransaction;
use Modules\Incomes\Entities\Revenue;
use Modules\Incomes\Entities\Tenant;

class UpdateRevenue implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $revenue = null;
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

            $this->revenue = Revenue::find($this->id);

            if($this->revenue == null){

                $this->response =  "No revenue found with this id!";

            }else {


                if($this->request['category_id']!=null&&Category::find($this->request['category_id']) == null){
                    $this->response = "No category found with this id!";
                    return;
                }

                if($this->request['tenant_id']!=null&&Tenant::find($this->request['tenant_id']) == null){
                    $this->response = "No tenant found with this id!";
                    return;
                }


                if($this->request['account_id']!=null&&Account::find($this->request['account_id']) == null){
                    $this->response = "No account found with this id!";
                    return;
                }


                $transaction = $this->revenue->transaction()->first();
                if($transaction!=null){
                    $this->request['amount'] = $this->request['price'];
                    $this->response = UpdateTransaction::dispatchNow($this->request, $transaction->id);
                    if(is_string($this->response)) return;
                    else $this->response = null;
                }
                $this->revenue->update($this->request->all());
            }
        });
        return ($this->response == null)? $this->revenue : $this->response;
    }
}
