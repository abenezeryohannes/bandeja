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
use Modules\Accounts\Transformers\ResponseWrapper;
use Modules\Properties\Entities\site;
use \Modules\Accounts\Transformers\Index\Account as AccountIndex;

class AccountsController extends Controller
{

    public $perpage = 20;
    /**
     * Display a listing of the resource.
     * @return \Illuminate\Http\Resources\Json\AnonymousResourceCollection
     */
    public function index()
    {
        $account = Account::simplepaginate($this->perpage);
        return AccountIndex::Collection($account);
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
            'name' => 'bail|required|string',
        ]);

        //returning the error if input is not correct
        if ($validator->fails()) {
            return ResponseWrapper::WrapSuccess($validator->errors()->first("name"), null);
        }


        //save to database and return the response
        $response = CreateAccount::dispatchNow($request);
        return ResponseWrapper::WrapSuccess($response, 'Account');
    }

    /**
     * Show the specified resource.
     * @param int $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function show($id)
    {
        $account = Account::find($id);
        if($account==null)$account = "No account found with this id";
        return ResponseWrapper::WrapSuccess($account, 'showAccount');
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
        //validating the input fields
        $validator = Validator::make($request->all(), [
            'name' => 'bail|required|string',
        ]);

        //returning the error if input is not correct
        if ($validator->fails())
            return ResponseWrapper::WrapSuccess($validator->errors()->first("name"), null);

        //save to database and return the response
        $response = UpdateAccount::dispatchNow($request, $id);

        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, 'Account');

    }

    /**
     * Remove the specified resource from storage.
     * @param int $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function destroy($id)
    {
        //save to database and return the response
        $response = DeleteAccount::dispatchNow($id);

        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, null);
    }
}
