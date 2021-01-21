<?php

namespace Modules\Accounts\Jobs\Interest;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Modules\Accounts\Entities\Account;
use Modules\Accounts\Entities\Interest;

class DeleteInterest implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $id = 0;
    protected $interest = null;
    protected $response = null;


    public function __construct($id)
    {
        $this->id = $id;
    }


    public function handle()
    {
        \DB::transaction(function() {
            $this->interest = Interest::find($this->id);
            if($this->interest == null){
                $this->response =  "No interest is found with this id!";
            }else {
                $account = Account::find($this->interest->account_id);
                if($account != null){
                    $account->balance = $account->blance - abs($this->interest->amount);
                    $account->save();
                }
                $this->interest->delete();
            }
        });
        return ($this->response == null || !is_string($this->response))? true: $this->response;
    }
}
