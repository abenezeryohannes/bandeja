<?php

namespace Modules\Accounts\Jobs\Account;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Modules\Accounts\Entities\Account;

class DeleteAccount implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $id = 0;
    protected $account = null;
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
            $this->account = Account::find($this->id);
            if($this->account == null){
                $this->response =  "Account is already deleted!";
            }else {
                //if transactions are made or its a main account dont delete the account
                if($this->account->transactions->count() > 0) {
                    $this->response = "Sorry, can't delete this account. Transactions are already made with it.";
                }else if($this->account->main_account != 0) {
                    $this->response = "Sorry, Can't delete the main account.";
                }
                else $this->account->delete();
            }
        });
        return ($this->response == null || !is_string($this->response))? true: $this->response;
    }
}
