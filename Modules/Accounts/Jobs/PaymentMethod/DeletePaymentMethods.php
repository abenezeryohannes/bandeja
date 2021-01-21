<?php

namespace Modules\Accounts\Jobs\PaymentMethod;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Modules\Accounts\Entities\PaymentMethod;
use Modules\Accounts\Entities\Tax;

class DeletePaymentMethods implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;
    protected $id = 0;
    protected $payment_method = null;
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
            $this->payment_method = PaymentMethod::find($this->id);
            if($this->payment_method == null){
                $this->response =  "No payment method with this id is found!";
            }else {
                //if transactions are made with this tax attached dont delete the tax
                if($this->payment_method->transactions->count() > 0) {
                    $this->response = "Sorry, can't delete this payment_method. Some transactions are already attached to it.";
                }

                else $this->payment_method->delete();
            }
        });
        return ($this->response == null || !is_string($this->response))? true: $this->response;
    }
}
