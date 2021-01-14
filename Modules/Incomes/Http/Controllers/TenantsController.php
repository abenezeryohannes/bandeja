<?php

namespace Modules\Incomes\Http\Controllers;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Validator;
use Modules\Incomes\Entities\Invoice;
use Modules\Incomes\Entities\Tenant;
use Modules\Incomes\Jobs\Tenant\CreateTenant;
use Modules\Incomes\Jobs\Tenant\DeleteTenant;
use Modules\Incomes\Jobs\Tenant\UpdateTenant;
use Modules\Incomes\Transformers\ResponseWrapper;
use Modules\Incomes\Transformers\Tenant\Index;

class TenantsController extends Controller
{

    public $perpage = 20;
    /**
     * Display a listing of the resource.
     * @return \Illuminate\Http\Resources\Json\AnonymousResourceCollection
     */
    public function index()
    {
        $tenants = Tenant::simplepaginate($this->perpage);
        return Index::Collection($tenants);
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
        $response = CreateTenant::dispatchNow($request);
        return $response;//ResponseWrapper::WrapSuccess($response, 'Account');
    }

    /**
     * Show the specified resource.
     * @param int $id
     * @return string
     */
    public function show($id)
    {
        $tenant = Tenant::find($id);
        if($tenant==null)$tenant = "No Tenant found with this id";
        return ResponseWrapper::WrapSuccess($tenant, 'showTenant');
    }
 /**
     * Show the specified resource.
     * @param int $id
     * @return string
     */
    public function invoices($id)
    {
        $tenant = Tenant::find($id);
        if($tenant==null)$tenant = "No Tenant found with this id";
        $invoices =$tenant->invoices()->simplepaginate($this->perpage);
        return ResponseWrapper::WrapSuccess($invoices, 'indexInvoiceCollection');
    }
 /**
     * Show the specified resource.
     * @param int $id
     * @return string
     */
    public function transactions($id)
    {
        $tenant = Tenant::find($id);
        if($tenant==null)$tenant = "No Tenant found with this id";
        $transactionInv = $tenant->TransactionsInv()->get();
        $transactionRev = $tenant->TransactionRev()->get();
        $transactions = $transactionRev->concat($transactionInv);
        $transactions = $transactions->sortByDesc('transaction_date');
        return ResponseWrapper::WrapSuccess($transactions, 'indexTransactionCollection');
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
        $response = UpdateTenant::dispatchNow($request, $id);

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
        $response = DeleteTenant::dispatchNow($id);

        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, null);
    }
}
