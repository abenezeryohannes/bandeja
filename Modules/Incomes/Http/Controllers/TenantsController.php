<?php

namespace Modules\Incomes\Http\Controllers;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Validator;
use Modules\Accounts\Entities\Transaction;
use Modules\Incomes\Entities\Invoice;
use Modules\Incomes\Entities\Tenant;
use Modules\Incomes\Jobs\Tenant\CreateTenant;
use Modules\Incomes\Jobs\Tenant\DeleteTenant;
use Modules\Incomes\Jobs\Tenant\SearchAndSortTenant;
use Modules\Incomes\Jobs\Tenant\UpdateTenant;
use Modules\Incomes\Transformers\ResponseWrapper;
use Modules\Incomes\Transformers\Tenant\Index;

class TenantsController extends Controller
{

    public $perpage = 20;

    public function index(Request $request)
    {
        $tenants = SearchAndSortTenant::dispatchNow($request['search'],$request['sort_by'],$request['order']);
        return Index::Collection($tenants);
    }

    public function create()
    {
        $form = new \Modules\Incomes\UI\Forms\TenantsForm('create');
        return response()->json($form->generate());
    }


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


    public function show($id)
    {
        $tenant = Tenant::find($id);
        if($tenant==null)$tenant = "No Tenant found with this id";
        return ResponseWrapper::WrapSuccess($tenant, 'showTenant');
    }


    public function invoices($id)
    {
        $tenant = Tenant::find($id);
        if($tenant==null)$tenant = "No Tenant found with this id";
        $invoices =$tenant->invoices()->simplepaginate($this->perpage);
        return ResponseWrapper::WrapSuccess($invoices, 'indexInvoiceCollection');
    }

    public function transactions($id)
    {
        $tenant = Tenant::find($id);
        if($tenant==null)$tenant = "No Tenant found with this id";
        $transactionInv = Transaction::TenantInvoiceTransactions($tenant->id)->get();
        $transactionRev = Transaction::TenantRevenueTransactions($tenant->id)->get();
        $transactions = $transactionRev->concat($transactionInv);
        $transactions = $transactions->sortByDesc('transaction_date');
        return ResponseWrapper::WrapSuccess($transactions, 'indexTransactionCollection');
    }

    public function edit($id)
    {
        return view('accounts::edit');
    }

    public function update(Request $request, $id)
    {
        //save to database and return the response
        $response = UpdateTenant::dispatchNow($request, $id);

        //$response returns the data inserted into the database
        return $response;//ResponseWrapper::WrapSuccess($response, 'Account');
    }


    public function destroy($id)
    {
        //save to database and return the response
        $response = DeleteTenant::dispatchNow($id);

        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, null);
    }




    public function destroyAll(Request $request)
    {
        $request->validate(['ids'=>'required']);

        $ids = explode(',', $request['ids']);

        foreach ($ids as $id){
            $response = DeleteTenant::dispatchNow($id);
        }

        return ResponseWrapper::WrapSuccess($response, 'Nothing');
    }
}
