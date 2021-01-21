<?php

namespace Modules\Accounts\Jobs\Interest;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Modules\Accounts\Entities\Account;
use Modules\Accounts\Entities\Interest;

class UpdateInterest implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $interest = null;
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
            $this->interest = Interest::find($this->id);
            if($this->interest == null){
                $this->response =  "No interest with this id!";
            }else {

                if($this->request['account_id']!=null && $this->request['account_id']!= $this->interest->account_id)
                {$this->response = "Can't change the account where the interest added."; return; }

                $this->request['amount'] =($this->request['amount']==null)? $this->interest->amount :
                    $this->request['amount'];

                $account = Account::find($this->interest->account_id);
                $diff = abs( abs($this->interest->amount) - abs($this->request['amount']));
                if($account != null && $diff!=0){

                        if($this->interest->amount < $this->request['amount'])
                            $account->balance = $account->balance + $diff;
                        else
                            $account->balance = $account->balance - $diff;

                    $account->save();
                }
                $this->interest->update($this->request->all());
            }
        });
        return ($this->response == null)? $this->interest : $this->response;
    }
}
