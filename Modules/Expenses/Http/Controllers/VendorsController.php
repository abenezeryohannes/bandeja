<?php

namespace Modules\Expenses\Http\Controllers;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Modules\Accounts\Entities\Transaction;
use Modules\Expenses\Entities\Vendor;
use Modules\Expenses\Jobs\Vendor\CreateVendor;
use Modules\Expenses\Jobs\Vendor\DeleteVendor;
use Modules\Expenses\Jobs\Vendor\SearchAndSortVendor;
use Modules\Expenses\Jobs\Vendor\UpdateVendor;
use Modules\Expenses\Transformers\ResponseWrapper;
use Modules\Expenses\Transformers\Vendor\Index;

class VendorsController extends Controller
{
    public $perpage = 20;


    public function index(Request $request)
    {
        $vendors = SearchAndSortVendor::dispatchNow($request['search'],$request['sort_by'],$request['order']);
        return Index::Collection($vendors);
    }


    public function create()
    {
        return view('accounts::create');
    }



    public function store(Request $request)
    {
        //validating the input fields
        $request->validate([
            'vendor_category_id' => 'required',
        ]);

        //save to database and return the response
        $response = CreateVendor::dispatchNow($request);
        return ResponseWrapper::WrapSuccess($response, 'MiniVendor');
    }



    public function show($id)
    {
        $vendor = Vendor::find($id);
        if($vendor==null)$vendor = "No vendor found with this id";
        return ResponseWrapper::WrapSuccess($vendor, 'showVendor');
    }


    public function edit($id)
    {
        return view('accounts::edit');
    }


    public function update(Request $request, $id)
    {
        //save to database and return the response
        $response = UpdateVendor::dispatchNow($request, $id);

        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, 'MiniVendor');

    }


    public function transactions( $id){
        $vendor = Vendor::find($id);
        if($vendor==null)$vendor = "No vendor found with this id";
        $paymentTransaction = Transaction::where('transactions.id','>', 0)->VendorPaymentTransactions($vendor->id)->get();
        $billTransaction = Transaction::where('transactions.id','>', 0)->VendorBillTransactions($vendor->id)->get();
        $transaction = $paymentTransaction->concat($billTransaction);
        //TODO sort transaction
        return ResponseWrapper::WrapSuccess($transaction, 'indexTransactionCollection');
    }

    public function bills($id){
        $vendor = Vendor::find($id);
        if($vendor==null)$vendor = "No vendor found with this id";

//    return  $vendor->bills()->get();
        return ResponseWrapper::WrapSuccess($vendor->bills()->get(), 'indexBillCollection');
    }



    public function destroy($id)
    {
        //save to database and return the response
        $response = DeleteVendor::dispatchNow($id);

        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, null);
    }




    public function destroyAll(Request $request)
    {
        $request->validate(['ids'=>'required']);

        $ids = explode(',', $request['ids']);

        foreach ($ids as $id){ $response = DeleteVendor::dispatchNow($id); }

        return ResponseWrapper::WrapSuccess($response, 'Nothing');
    }
}
