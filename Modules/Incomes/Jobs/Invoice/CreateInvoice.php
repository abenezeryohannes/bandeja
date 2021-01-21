<?php

namespace Modules\Incomes\Jobs\Invoice;

use Carbon\Carbon;
use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Modules\Accounts\Entities\Category;
use Modules\Incomes\Entities\Invoice;
use Modules\Incomes\Entities\Tenant;
use Modules\Incomes\Jobs\InvoicePayment\CreateInvoicePayment;
use Modules\Properties\Entities\Property;

class CreateInvoice implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $invoice = null;
    protected $response = null;
    protected $request;


    public function __construct($request)
    {
        $this->request = ($request);
    }


    public function handle()
    {

        \DB::transaction(function() {

            if(Category::find($this->request['category_id']) == null){
                $this->response = "No category with this id!";
                return;
            }

            if(Tenant::find($this->request['tenant_id']) == null){
                $this->response = "No tenant with this id!";
                return;
            }

            $property = Property::find($this->request['property_id']);
            if($property == null){
                $this->response = "No Property with this id!";
                return;
            }

            if(Carbon::parse($property->available_after)->isAfter(Carbon::now()->addDay())){
                $this->response = "This property is not available!";
                return;
            }

            //check if end date and due date is prior to start date
            if(Carbon::parse($this->request['start_date'])->isAfter(Carbon::parse($this->request['end_date'])))
            {$this->response = "Invoice end date must be after invoice start date!"; return;}

            if(Carbon::parse($this->request['start_date'])->isAfter(Carbon::parse($this->request['due_date'])))
            {$this->response = "Invoice due date can't precede invoice start date!"; return;}

//            if(Carbon::parse($this->request['due_date'])->isAfter(Carbon::parse($this->request['end_date'])))            {$this->response = "No tenant with this id!"; return;}
//            {$this->response = "Invoice end date must be after due date"; return;}



            //if no price set use property price else use inserted price
            if(!array_key_exists('price', $this->request->all()))
            $this->request['price'] = $property->propertyCategory()->first()->rent_price;

            //create invoice
            $this->invoice = Invoice::create($this->request->all());

            //update properties available_after
            Property::where('id', '=', $this->invoice->property_id)->update([
                'available_after' => Carbon::parse($this->invoice->end_date)
            ]);


            //get the month deference between invoice date and end date
            //get the difference in days between invoice date and due date
            //for each month create invoice payment table
            $months = Carbon::parse($this->invoice->start_date)->diffInMonths(Carbon::parse($this->invoice->end_date));
            $dueDiff = Carbon::parse($this->invoice->start_date)->diffInDays(Carbon::parse($this->invoice->due_date));


            for($i = 1;$i <= $months; $i++){
                $new_invoice_payment = [
                    'invoice_id' => $this->invoice->id,
                    'price' => $this->request['price'],
                    'due_date' => Carbon::parse($this->invoice->start_date)->addMonths($i)->addDays($dueDiff),
                    'invoice_date' => Carbon::parse($this->invoice->start_date)->addMonths($i),
                ];
                $this->response =  CreateInvoicePayment::dispatchNow($new_invoice_payment);
                if( is_string($this->response)) { return; }
                else $this->response = null;
            }

            if($this->invoice == null) $this->response = "Internal Server Error!";
        });
        return ($this->response ==null)? $this->invoice : $this->response;
    }
}
