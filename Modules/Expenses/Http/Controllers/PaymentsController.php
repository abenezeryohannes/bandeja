<?php

namespace Modules\Expenses\Http\Controllers;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Modules\Expenses\Entities\Payment;
use Modules\Expenses\Jobs\Payment\CreatePayment;
use Modules\Expenses\Jobs\Payment\DeletePayment;
use Modules\Expenses\Jobs\Payment\SearchAndSortPayment;
use Modules\Expenses\Jobs\Payment\UpdatePayment;
use Modules\Expenses\Transformers\ResponseWrapper;
use Modules\Expenses\Transformers\Payment\Index;
use Modules\Expenses\Transformers\Payment\Show;
use Modules\Expenses\Transformers\Payment\Mini;

class PaymentsController extends Controller
{
    public $perpage = 20;



    public function index(Request $request)
    {
        $payments = SearchAndSortPayment::dispatchNow($request['search'],$request['sort_by'],$request['order']);
        return Index::Collection($payments);
    }



    public function create()
    {
        return view('accounts::create');
    }



    public function store(Request $request)
    {
        //validating the input fields
        $request->validate([
            'vendor_id' => 'required',
            'category_id' => 'required',
            'amount' => 'required',
            'transaction_date' => 'required',
            'account_id' => 'required',
        ]);

        //save to database and return the response
        $response = CreatePayment::dispatchNow($request);
        return ResponseWrapper::WrapSuccess($response, 'MiniPayment');
    }



    public function show($id)
    {
        $payment = Payment::find($id);
        if($payment==null)$bill = "No payment found with this id";
        return ResponseWrapper::WrapSuccess($payment, 'showPayment');
    }


    public function edit($id)
    {
        return view('accounts::edit');
    }



    public function update(Request $request, $id)
    {
        //save to database and return the response
        $response = UpdatePayment::dispatchNow($request, $id);

        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, 'MiniPayment');

    }


    public function destroy($id)
    {
        //save to database and return the response
        $response = DeletePayment::dispatchNow($id);

        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, null);
    }




    public function destroyAll(Request $request)
    {
        $request->validate(['ids'=>'required']);

        $ids = explode(',', $request['ids']);

        foreach ($ids as $id){ $response = DeletePayment::dispatchNow($id); }

        return ResponseWrapper::WrapSuccess($response, 'Nothing');
    }
}
