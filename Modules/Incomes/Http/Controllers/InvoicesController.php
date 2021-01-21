<?php

namespace Modules\Incomes\Http\Controllers;

use Carbon\Carbon;
use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Validator;
use Modules\Accounts\Entities\Transaction;
use Modules\Incomes\Entities\Invoice;
use Modules\Incomes\Jobs\Invoice\CancelInvoice;
use Modules\Incomes\Jobs\Invoice\CreateInvoice;
use Modules\Incomes\Jobs\Invoice\DeleteInvoice;
use Modules\Incomes\Jobs\Invoice\UpdateInvoice;
use Modules\Incomes\Jobs\InvoicePayment\PayInvoice;
use Modules\Incomes\Transformers\Invoice\Index;
use Modules\Incomes\Transformers\ResponseWrapper;

class InvoicesController extends Controller
{

    public $perpage = 20;

    public function index()
    {
        $invoices = Invoice::simplepaginate($this->perpage);
        return Index::Collection($invoices);
    }


    public function create()
    {
        $form = new \Modules\Incomes\UI\Forms\InvoiceForm('create');
        return response()->json($form->generate());
    }


    public function store(Request $request)
    {
        //validating the input fields
        $request->validate([
            'tenant_id' => 'bail|required',
            'category_id' => 'bail|required',
            'property_id' => 'bail|required',
        ]);


        //save to database and return the response
        $response = CreateInvoice::dispatchNow($request);
        // return $response;//
        return ResponseWrapper::WrapSuccess($response, 'Account');
    }


    public function show($id)
    {
        $invoice = Invoice::find($id);
        if($invoice==null)$invoice = "No Invoice found with this id";
        return ResponseWrapper::WrapSuccess($invoice, 'showInvoice');
    }

    public function transactions($id)
    {
        $invoice = Invoice::find($id);
        if($invoice==null)$invoice = "No Invoice found with this id";
        $transactions = Transaction::InvoiceTransactions($invoice->id)->get();
        return ResponseWrapper::WrapSuccess($transactions, 'indextransactioncollection');
    }


    public function edit($id)
    {
        return view('accounts::edit');
    }


    public function update(Request $request, $id)
    {
        //save to database and return the response
        $response = UpdateInvoice::dispatchNow($request, $id);

        //$response returns the data inserted into the database
        return $response;//ResponseWrapper::WrapSuccess($response, 'Account');

    }



    public function pay_form()
    {

        $form = new \Modules\Incomes\UI\Forms\InvoiceForm('pay');
        return response()->json($form->generate());
    }

    public function pay(Request $request, $id)
    {

        //validating the input fields
        $request->validate([
//            'invoice_payment_id' => 'bail|required',
            'period' => 'bail|required',
            'amount' => 'bail|required',
            'transaction_date' => 'bail|required',
        ]);



        //save to database and return the response
        $response = PayInvoice::dispatchNow($request, $id);

        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, 'InvoicePayment');

    }


    public function cancel(Request $request, $id)
    {
        //validating the input fields
        $validator = Validator::make($request->all(), [
            'reason' => 'bail|required',
            'by' => 'bail|required',
            'months' => 'bail|required',
        ]);

        //returning the error if input is not correct
        if ($validator->fails()) {
            return ResponseWrapper::WrapSuccess(
                $validator->errors()->first("reason")
                . $validator->errors()->first("by")
                . $validator->errors()->first("months") , null);
        }


        //save to database and return the response
        $response = CancelInvoice::dispatchNow($request, $id);


        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, 'CancelIndex');

    }


    public function destroy($id)
    {
        //save to database and return the response
        $response = DeleteInvoice::dispatchNow($id);

        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, null);
    }
}
