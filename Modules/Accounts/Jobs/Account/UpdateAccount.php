<?php

namespace Modules\Accounts\Jobs\Account;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Modules\Accounts\Entities\Account;

class UpdateAccount implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $account = null;
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
            $this->account = Account::find($this->id);
            if($this->account == null){
                $this->response =  "No account with this id!";
            }else {

                //can't change opening balance if transactions already made;
                if($this->request['opening_balance'] > 0 && $this->account->opening_balance != $this->request['opening_balance']){
                    if($this->account->transactions->count()>0){
                        $this->response = "Sorry! can't change opening_balance after transactions are made";
                    }
                }

                //can't change balance
                if($this->request['balance'] > 0 && $this->account->balance != $this->request['balance']) {
                    $this->response = "Sorry! if you wan't to change the balance make transactions";
                }

                //can't make not main account;
                if($this->request['main_account']!=null && $this->account->main_account == 1 && $this->request['main_account'] == 0) {
                    $this->response = "To make this account not your main account, first set another account as your main account.";
                }

                //if made main account :- make all other accounts not main
                if($this->request['main_account']!=null && $this->account->main_account == 0 && $this->request['main_account'] == 1) {
                    Account::where('id', '!=', $this->account->id)->update(['main_account' => false]);
                }

                $this->account->update($this->request->all());
            }
        });
        return ($this->response == null)? $this->account : $this->response;
    }
}
