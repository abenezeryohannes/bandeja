<?php

namespace Modules\Accounts\Http\Controllers;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Validator;
use Modules\Accounts\Entities\Transaction;
use Modules\Accounts\Jobs\Transaction\CreateTransaction;
use Modules\Accounts\Jobs\Transaction\DeleteTransaction;
use Modules\Accounts\Jobs\Transaction\UpdateTransaction;
use Modules\Accounts\Transformers\ResponseWrapper;
use Modules\Accounts\Jobs\Transaction\SearchAndSortTransaction;

class TransactionsController extends Controller
{

    public $perpage = 20;

    public function index(Request $request)
    {
        $transactions = SearchAndSortTransaction::dispatchNow($request['search'],$request['sort_by'],$request['order']);
        return \Modules\Accounts\Transformers\Index\Transaction::Collection($transactions);
    }

    public function create()
    {
        return view('accounts::create');
    }


    public function store(Request $request)
    {
        //validating the input fields
        $request->validate([
            'type' => 'bail|required|string',
            'category_id' => 'bail|required|string',
        ]);

        //save to database and return the response
        $response = CreateTransaction::dispatchNow($request);
        return ResponseWrapper::WrapSuccess($response, 'TransactionIndex');
    }

    public function show($id)
    {
        $transaction = Transaction::find($id);
        if($transaction==null)$transaction = "No transaction found with this id";
        return new \Modules\Accounts\Transformers\Show\Transaction($transaction);
    }


    public function edit($id)
    {
        return view('accounts::edit');
    }


    public function update(Request $request, $id)
    {
        //save to database and return the response
        $response = UpdateTransaction::dispatchNow($request, $id);

        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, 'TransactionIndex');
    }


    public function destroy($id)
    {
        //save to database and return the response
        $response = DeleteTransaction::dispatchNow($id);

        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, null);
    }



    public function destroyAll(Request $request)
    {
        $request->validate(['ids'=>'required']);

        $ids = explode(',', $request['ids']);

        foreach ($ids as $id){
            $response = DeleteTransaction::dispatchNow($id);
        }

        return ResponseWrapper::WrapSuccess($response, 'Nothing');
    }
}
