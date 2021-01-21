<?php

namespace Modules\Accounts\Jobs\PaymentMethod;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Modules\Accounts\Entities\PaymentMethod;
use Modules\Accounts\Entities\Tax;

class CreatePaymentMethods implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;


    protected $payment_method = null;
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
            //check if same tax is already present
            $payment_method = PaymentMethod::where('name', '=', $this->request['name'])->first();
            if($payment_method!=null){ $this->response = "Same Payment Method is already present."; return; }

            //create category
            $this->payment_method = PaymentMethod::create($this->request->all());

            if($this->payment_method == null) $this->response = "Internal Server Error!";
        });
        return ($this->response ==null)? $this->payment_method : $this->response;
    }

}
