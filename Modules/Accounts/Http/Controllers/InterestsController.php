<?php

namespace Modules\Accounts\Http\Controllers;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Modules\Accounts\Entities\Interest;
use Modules\Accounts\Jobs\Interest\CreateInterest;
use Modules\Accounts\Jobs\Interest\DeleteInterest;
use Modules\Accounts\Jobs\Interest\UpdateInterest;
use Modules\Accounts\Transformers\Index\Account as AccountIndex;
use Modules\Accounts\Transformers\ResponseWrapper;
use Modules\Accounts\Jobs\Interest\SearchAndSortInterest;

class InterestsController extends Controller
{

    public $perpage = 20;

    public function index(Request $request)
    {
        $interests = SearchAndSortInterest::dispatchNow($request['search'],$request['sort_by'],$request['order']);
        return \Modules\Accounts\Transformers\Mini\Interest::Collection($interests);
    }

    public function create()
    {
        return view('accounts::create');
    }


    public function store(Request $request)
    {
        //validating the input fields
        $request->validate( [
            'account_id' => 'required|string',
            'amount' => 'required|string',
        ]);

        //save to database and return the response
        $response = CreateInterest::dispatchNow($request);
        return ResponseWrapper::WrapSuccess($response, 'InterestIndex');
    }



    public function edit($id)
    {
        return view('accounts::edit');
    }


    public function update(Request $request, $id)
    {
        //save to database and return the response
        $response = UpdateInterest::dispatchNow($request, $id);

        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, 'InterestIndex');

    }


    public function destroy($id)
    {
        //save to database and return the response
        $response = DeleteInterest::dispatchNow($id);

        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, null);
    }



    public function destroyAll(Request $request)
    {
        $request->validate(['ids'=>'required']);

        $ids = explode(',', $request['ids']);

        foreach ($ids as $id){
            $response = DeleteInterest::dispatchNow($id);
        }

        return ResponseWrapper::WrapSuccess($response, 'Nothing');
    }
}
