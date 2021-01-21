<?php

namespace Modules\Expenses\Http\Controllers;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Modules\Expenses\Entities\Recurring;
use Modules\Expenses\Jobs\Recurring\CreateRecurring;
use Modules\Expenses\Jobs\Recurring\DeleteRecurring;
use Modules\Expenses\Jobs\Recurring\UpdateRecurring;
use Modules\Expenses\Transformers\ResponseWrapper;
use Modules\Expenses\Transformers\Recurring\Mini;

class RecurringsController extends Controller
{
    public $perpage = 20;

    public function index()
    {
        $reccuring = Recurring::all();
        return Mini::Collection($reccuring);
    }

    public function create()
    {
        return view('accounts::create');
    }


    public function store(Request $request)
    {
        //validating the input fields
        $request->validate([
            'name' => 'required',
            'interval' => 'required'
        ]);

        //save to database and return the response
        $response = CreateRecurring::dispatchNow($request);
        return ResponseWrapper::WrapSuccess($response, 'MiniRecurring');
    }


    public function edit($id)
    {
        return view('accounts::edit');
    }


    public function update(Request $request, $id)
    {
        //save to database and return the response
        $response = UpdateRecurring::dispatchNow($request, $id);

        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, 'MiniRecurring');

    }


    public function destroy($id)
    {
        //save to database and return the response
        $response = DeleteRecurring::dispatchNow($id);

        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, null);
    }
}
