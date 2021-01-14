<?php

namespace Modules\Incomes\Http\Controllers;

use Carbon\Carbon;
use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Validator;
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
    /**
     * Display a listing of the resource.
     * @return \Illuminate\Http\Resources\Json\AnonymousResourceCollection
     */
    public function index()
    {
        $invoices = Invoice::simplepaginate($this->perpage);
        return Index::Collection($invoices);
    }

    /**
     * Show the form for creating a new resource.
     * @return Renderable
     */
    public function create()
    {
        return view('accounts::create');
    }

    /**
     * Store a newly created resource in storage.
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(Request $request)
    {
        //validating the input fields
        $validator = Validator::make($request->all(), [
            'tenant_id' => 'bail|required',
            'category_id' => 'bail|required',
            'property_id' => 'bail|required',
        ]);

        //returning the error if input is not correct
        if ($validator->fails()) {
            return ResponseWrapper::WrapSuccess($validator->errors()->first("tenant_id") . $validator->errors()->first("category_id") . $validator->errors()->first("property_id") , null);
        }


        //save to database and return the response
        $response = CreateInvoice::dispatchNow($request);
        return $response;//ResponseWrapper::WrapSuccess($response, 'Account');
    }

    /**
     * Show the specified resource.
     * @param int $id
     * @return string
     */
    public function show($id)
    {
        $invoice = Invoice::find($id);
        if($invoice==null)$invoice = "No Invoice found with this id";
        return ResponseWrapper::WrapSuccess($invoice, 'showInvoice');
    } /**
     * Show the specified resource.
     * @param int $id
     * @return string
     */
    public function transactions($id)
    {
        $invoice = Invoice::find($id);
        if($invoice==null)$invoice = "No Invoice found with this id";
        $transactions = $invoice->transactions()->get();
        return ResponseWrapper::WrapSuccess($transactions, 'indextransactioncollection');
    }

    /**
     * Show the form for editing the specified resource.
     * @param int $id
     * @return Renderable
     */
    public function edit($id)
    {
        return view('accounts::edit');
    }

    /**
     * Update the specified resource in storage.
     * @param Request $request
     * @param int $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function update(Request $request, $id)
    {
        //save to database and return the response
        $response = UpdateInvoice::dispatchNow($request, $id);

        //$response returns the data inserted into the database
        return $response;//ResponseWrapper::WrapSuccess($response, 'Account');

    }

    public function pay(Request $request, $id)
    {

        //validating the input fields
        $validator = Validator::make($request->all(), [
            'invoice_payment_id' => 'bail|required',
            'period' => 'bail|required',
            'payed' => 'bail|required',
            'transaction_date' => 'bail|required',
        ]);

        //returning the error if input is not correct
        if ($validator->fails()) {
            return ResponseWrapper::WrapSuccess(
                $validator->errors()->first("invoice_payment_id") .
                $validator->errors()->first("period") .
                $validator->errors()->first("payed") .
                $validator->errors()->first("transaction_date")
                , null);
        }

        //save to database and return the response
        $response = PayInvoice::dispatchNow($request, $id);

        //$response returns the data inserted into the database
        return $response;//ResponseWrapper::WrapSuccess($response, 'Account');

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
            return ResponseWrapper::WrapSuccess($validator->errors()->first("tenant_id") . $validator->errors()->first("category_id") . $validator->errors()->first("property_id") , null);
        }


        //save to database and return the response
        $response = CancelInvoice::dispatchNow($request, $id);

        //$response returns the data inserted into the database
        return $response;//ResponseWrapper::WrapSuccess($response, 'Account');

    }

    /**
     * Remove the specified resource from storage.
     * @param int $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function destroy($id)
    {
        //save to database and return the response
        $response = DeleteInvoice::dispatchNow($id);

        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, null);
    }
}
