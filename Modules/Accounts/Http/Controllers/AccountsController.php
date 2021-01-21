<?php

namespace Modules\Accounts\Http\Controllers;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Validator;
use Modules\Accounts\Entities\Account;
use Modules\Accounts\Jobs\Account\CreateAccount;
use Modules\Accounts\Jobs\Account\DeleteAccount;
use Modules\Accounts\Jobs\Account\UpdateAccount;
use Modules\Accounts\Transformers\Index\Transaction;
use Modules\Accounts\Transformers\ResponseWrapper;
use Modules\Properties\Entities\site;
use \Modules\Accounts\Transformers\Index\Account as AccountIndex;

class AccountsController extends Controller
{

    public $perpage = 20;

    public function index()
    {
        $account = Account::simplepaginate($this->perpage);
        return AccountIndex::Collection($account);
    }


    public function create()
    {
        return view('accounts::create');
    }



    public function store(Request $request)
    {
        //validating the input fields
        $request->validate([
            'name' => 'required|string',
            'bank' => 'required|string',
            'opening_balance' => 'required',
            'account_number' => 'required',
        ]);

        //save to database and return the response
        $response = CreateAccount::dispatchNow($request);
        return ResponseWrapper::WrapSuccess($response, 'AccountIndex');
    }



    public function show($id)
    {
        $account = Account::find($id);
        if($account==null)$account = "No account found with this id";
        return new \Modules\Accounts\Transformers\Show\Account($account);
    }


    public function transactions($id)
    {
        $account = Account::find($id);
        if($account==null)$account = "No account found with this id";
        $transactions = \Modules\Accounts\Entities\Transaction::where('account_id', '=', $account->id)->get();
        return Transaction::collection($transactions);
    }


    public function edit($id)
    {
        return view('accounts::edit');
    }

    public function update(Request $request, $id)
    {

        //save to database and return the response
        $response = UpdateAccount::dispatchNow($request, $id);

        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, 'AccountIndex');

    }

    public function destroy($id)
    {
        //save to database and return the response
        $response = DeleteAccount::dispatchNow($id);

        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, null);
    }
}
