<?php

namespace Modules\Accounts\Jobs\Interest;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Modules\Accounts\Entities\Account;
use Modules\Accounts\Entities\Interest;

class CreateInterest implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $interest = null;
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
            $account->balance = $account->balance + abs($this->request['amount']);
            $account->save();


            $this->interest = Interest::create($this->request->all());

            if($this->interest == null) $this->response = "Internal Server Error!";
        });

        return ($this->response ==null)? $this->interest : $this->response;

    }
}
