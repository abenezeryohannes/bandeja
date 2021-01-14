<?php

namespace Modules\Incomes\Http\Controllers;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Validator;
use Modules\Incomes\Entities\Revenue;
use Modules\Incomes\Jobs\Revenue\CreateRevenue;
use Modules\Incomes\Jobs\Revenue\DeleteRevenue;
use Modules\Incomes\Jobs\Revenue\UpdateRevenue;
use Modules\Incomes\Transformers\ResponseWrapper;
use Modules\Incomes\Transformers\Revenue\Index;

class RevenuesController extends Controller
{


    public $perpage = 20;
    /**
     * Display a listing of the resource.
     * @return \Illuminate\Http\Resources\Json\AnonymousResourceCollection
     */
    public function index()
    {
        $revenues = Revenue::where('transaction_id', '!=', null)->simplepaginate($this->perpage);
        return Index::Collection($revenues);
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
            'tenant_id' => 'bail|required|string',
            'category_id' => 'bail|required|string',
          ]);

        //returning the error if input is not correct
        if ($validator->fails()) {
            return ResponseWrapper::WrapSuccess($validator->errors()->first("name"), null);
        }


        //save to database and return the response
        $response = CreateRevenue::dispatchNow($request);
        return $response;//ResponseWrapper::WrapSuccess($response, 'Account');
    }

    /**
     * Show the specified resource.
     * @param int $id
     * @return string
     */
    public function show($id)
    {
        $revenues = Revenue::find($id);
        if($revenues==null)$revenues = "No Revenue found with this id";
        return ResponseWrapper::WrapSuccess($revenues, 'showRevenue');
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
        $response = UpdateRevenue::dispatchNow($request, $id);

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
        $response = DeleteRevenue::dispatchNow($id);

        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, null);
    }
}
