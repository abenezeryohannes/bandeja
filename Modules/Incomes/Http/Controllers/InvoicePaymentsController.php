<?php

namespace Modules\Incomes\Http\Controllers;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Validator;
use Modules\Incomes\Entities\InvoicePayment;
use Modules\Incomes\Jobs\InvoicePayment\CreateInvoicePayment;
use Modules\Incomes\Jobs\InvoicePayment\DeleteInvoicePayment;
use Modules\Incomes\Jobs\InvoicePayment\UpdateInvoicePayment;
use Modules\Incomes\Transformers\ResponseWrapper;

class InvoicePaymentsController extends Controller
{
    public $perpage = 20;

    public function index()
    {
        $invoice_payment = InvoicePayment::simplepaginate($this->perpage);
        return $invoice_payment;//AccountIndex::Collection($account);
    }

    public function create()
    {
        return view('accounts::create');
    }


    public function store(Request $request)
    {
        //validating the input fields
        $validator = Validator::make($request->all(), [
            'invoice_id' => 'bail|required',
            'due_date' => 'bail|required',
            'invoice_date' => 'bail|required',
        ]);

        //returning the error if input is not correct
        if ($validator->fails()) {
            return ResponseWrapper::WrapSuccess(
                $validator->errors()->first("invoice_id").
                $validator->errors()->first("due_date").
                $validator->errors()->first("invoice_date"), null);
        }

        //save to database and return the response
        $response = CreateInvoicePayment::dispatchNow($request);
        return $response;//ResponseWrapper::WrapSuccess($response, 'Account');
    }


    public function show($id)
    {
        $invoice_payment = InvoicePayment::find($id);
        if($invoice_payment==null)$invoice_payment = "No invoice payment found with this id";
        return $invoice_payment;//ResponseWrapper::WrapSuccess($account, 'showAccount');
    }


    public function edit($id)
    {
        return view('accounts::edit');
    }


    public function update(Request $request, $id)
    {
        //save to database and return the response
        $response = UpdateInvoicePayment::dispatchNow($request, $id);

        //$response returns the data inserted into the database
        return $response;//ResponseWrapper::WrapSuccess($response, 'Account');

    }


    public function destroy($id)
    {
        //save to database and return the response
        $response = DeleteInvoicePayment::dispatchNow($id);

        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, null);
    }
}
