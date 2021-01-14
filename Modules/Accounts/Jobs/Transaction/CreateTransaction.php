<?php

namespace Modules\Accounts\Jobs\Transaction;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Modules\Accounts\Entities\Account;
use Modules\Accounts\Entities\Category;
use Modules\Accounts\Entities\Transaction;

class CreateTransaction implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $transaction = null;
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

            if($this->request['category_id'] == null) { $this->response = "Choose category first";return;}

            $category = Category::find($this->request['category_id']);

            if($category==null) {$this->response = "No category is found with this id.";return;}

            //Get account
            $account = null;
                //if no account gived use main account
            if($this->request['account_id'] == null) {
                $account = Account::where('main_account', '=', 1)->first();
                if($account == null) {$this->response = "Choose account first";return;}
                else $this->request['account_id'] = $account->id;
            }else $account = Account::find($this->request['account_id']);

            //if account is null it means  no account provided and also no main account found for the transaction
            if($account==null) {$this->response = "No account is found with this id.";return;}


            // take care of the bank current balance
            if(strtolower($category->type) == "income" || strtolower($category->type) == "deposit"
                || strtolower($category->type) == "invoice" || strtolower($category->type) == "revenue"){
                $account->balance = $account->balance + abs($this->request['amount']);
                $account->save();
            }else{
                $account->balance = $account->balance - abs($this->request['amount']);
                $account->save();}


            $this->transaction = Transaction::create($this->request->all());

            if($this->transaction == null) $this->response = "Internal Server Error!";
        });

        return ($this->response ==null)? $this->transaction : $this->response;

    }
}
