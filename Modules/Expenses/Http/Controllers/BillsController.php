<?php

namespace Modules\Expenses\Http\Controllers;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Validator;
use Modules\Accounts\Entities\Transaction;
use Modules\Expenses\Entities\Bill;
use Modules\Expenses\Jobs\Bill\CancelBill;
use Modules\Expenses\Jobs\Bill\CreateBill;
use Modules\Expenses\Jobs\Bill\DeleteBill;
use Modules\Expenses\Jobs\Bill\SearchAndSortBill;
use Modules\Expenses\Jobs\Bill\UpdateBill;
use Modules\Expenses\Jobs\BillPayment\PayBill;
use Modules\Expenses\Transformers\Bill\Index;
use Modules\Expenses\Transformers\Bill\Show;
use Modules\Expenses\Transformers\Bill\Mini;
use Modules\Expenses\Transformers\ResponseWrapper;

class BillsController extends Controller
{

    public $perpage = 20;


    public function index(Request $request)
    {
        $bills = SearchAndSortBill::dispatchNow($request['search'],$request['sort_by'],$request['order']);
        return Index::Collection($bills);
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
            'start_date' => 'required',
            'due_date' => 'required',
            'price' => 'required',
        ]);

        //save to database and return the response
        $response = CreateBill::dispatchNow($request);
        return ResponseWrapper::WrapSuccess($response, 'MiniBill');
    }



    public function show($id)
    {
        $bill = Bill::find($id);
        if($bill==null)$bill = "No bill found with this id";
        return ResponseWrapper::WrapSuccess($bill, 'showBill');
    }



    public function transactions($id)
    {
        $bill = Bill::find($id);
        if($bill==null)$bill = "No bill found with this id";
        $transactions = Transaction::where('transactions.id', '>', 0)->BillTransactions($bill->id)->get();
        return ResponseWrapper::WrapSuccess($transactions, 'indextransactioncollection');
    }


    public function edit($id)
    {
        return view('accounts::edit');
    }



    public function update(Request $request, $id)
    {
        //save to database and return the response
        $response = UpdateBill::dispatchNow($request, $id);

        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, 'MiniBill');

    }

    public function pay(Request $request, $id)
    {

        //validating the input fields
        $request->validate([
            'bill_payment_id' => 'bail|required',
            'period' => 'bail|required',
            'amount' => 'bail|required',
            'transaction_date' => 'bail|required',
        ]);

        //save to database and return the response
        $response = PayBill::dispatchNow($request, $id);

        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, 'BillPaymentResponse');

    }


    public function cancel($id)
    {

        //save to database and return the response
        $response = CancelBill::dispatchNow($id);

        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, 'MiniBill');

    }


    public function destroy($id)
    {
        //save to database and return the response
        $response = DeleteBill::dispatchNow($id);

        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, null);
    }




    public function destroyAll(Request $request)
    {
        $request->validate(['ids'=>'required']);

        $ids = explode(',', $request['ids']);

        foreach ($ids as $id){ $response = DeleteBill::dispatchNow($id); }

        return ResponseWrapper::WrapSuccess($response, 'Nothing');
    }
}
