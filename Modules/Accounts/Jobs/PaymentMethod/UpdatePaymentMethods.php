<?php

namespace Modules\Accounts\Jobs\PaymentMethod;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Modules\Accounts\Entities\PaymentMethod;
use Modules\Accounts\Entities\Tax;

class UpdatePaymentMethods implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $payment_method = null;
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
            $this->payment_method = PaymentMethod::find($this->id);
            if($this->payment_method == null){
                $this->response =  "No payment method with this id!";
            }else {
                $this->request['name'] =($this->request['name']==null)? $this->payment_method->name : $this->request['name'];

                $payment_method = PaymentMethod::where('name', '=', $this->request['name'])->where('id', '!=', $this->id)->first();
                if($payment_method!=null){ $this->response = "Same payment method is already present."; return; }

                $this->payment_method->update($this->request->all());
            }
        });
        return ($this->response == null)? $this->payment_method : $this->response;
    }
}
