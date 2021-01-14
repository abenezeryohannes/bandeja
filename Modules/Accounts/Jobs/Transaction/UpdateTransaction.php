<?php

namespace Modules\Accounts\Jobs\Transaction;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Modules\Accounts\Entities\Account;
use Modules\Accounts\Entities\Transaction;
use Modules\Incomes\Entities\Invoice;
use Modules\Incomes\Entities\Revenue;

class UpdateTransaction implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;


    protected $transaction = null;
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
            $this->transaction = Transaction::find($this->id);
            if($this->transaction == null){
                $this->response =  "No transaction with this id!";
            }else {

                if($this->request['category_id']!=null && $this->request['category_id']!= $this->transaction->category_id)
                {
                    $this->response = "Can't change or edit the category of transaction."; return;
                }

                if($this->request['account_id']!=null && $this->request['account_id']!= $this->transaction->account_id)
                {
                    $this->response = "Can't change the account where the transaction is made."; return;
                }

                $this->request['amount'] =($this->request['amount']==null)? $this->transaction->amount :
                                                                             $this->request['amount'];

                $account = Account::find($this->transaction->account_id);
                $diff = abs( abs($this->transaction->amount) - abs($this->request['amount']));
                if($account != null && $diff!=0){
                    $type = $this->transaction->category()->first()->type;
                    if(strtolower($type) == "income" || strtolower($type) == "deposit" || strtolower($type) == "invoice"
                        || strtolower($type) == "revenue" )
                        if($this->transaction->amount < $this->request['amount'])
                            $account->balance = $account->balance + $diff;
                        else
                            $account->balance = $account->balance - $diff;
                    else
                        if($this->transaction->amount < $this->request['amount'])
                            $account->balance = $account->balance - $diff;
                        else
                            $account->balance = $account->balance + $diff;
                    $account->save();
                }

                $this->transaction->update($this->request->all());
            }
        });
        return ($this->response == null)? $this->transaction : $this->response;
    }
}
