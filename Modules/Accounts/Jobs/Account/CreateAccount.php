<?php

namespace Modules\Accounts\Jobs\Account;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Modules\Accounts\Entities\Account;

class CreateAccount implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $account = null;
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
            //add account into the database
//            $this->request['opening_balance'] = str_replace(",", "", $this->request['opening_balance']);

            //the opening balance of the account is the current balance of the account before any transaction
            $this->request['balance'] = $this->request['opening_balance'];

            //if this account is the first account created make it main account automatically
            if(Account::all()->count()==0) $this->request['main_account']=1;

            $this->account = Account::create($this->request->all());

            if($this->account == null) $this->response = "Internal Server Error!";
        });
        return ($this->response ==null)? $this->account : $this->response;
    }
}
