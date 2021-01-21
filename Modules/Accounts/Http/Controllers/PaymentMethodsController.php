<?php

namespace Modules\Accounts\Http\Controllers;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Validator;
use Modules\Accounts\Entities\PaymentMethod;
use Modules\Accounts\Jobs\PaymentMethod\CreatePaymentMethods;
use Modules\Accounts\Jobs\PaymentMethod\DeletePaymentMethods;
use Modules\Accounts\Jobs\PaymentMethod\UpdatePaymentMethods;
use Modules\Accounts\Transformers\ResponseWrapper;

class PaymentMethodsController extends Controller
{
    public $perpage = 20;

    public function index()
    {
        $payment_method = PaymentMethod::simplepaginate($this->perpage);
        return \Modules\Accounts\Transformers\Mini\PaymentMethod::Collection($payment_method);
    }

    public function create()
    {
        return view('accounts::create');
    }

    public function store(Request $request)
    {
        //validating the input fields
        $request->validate( [
            'name' => 'bail|required|string',
        ]);

        //save to database and return the response
        $response = CreatePaymentMethods::dispatchNow($request);
        return ResponseWrapper::WrapSuccess($response, 'PaymentMethodIndex');
    }


    public function show($id)
    {
        $payment_method = PaymentMethod::find($id);
        if($payment_method==null)$payment_method = "No payment method found with this id";
        return new \Modules\Accounts\Transformers\Mini\PaymentMethod($payment_method);
    }


    public function edit($id)
    {
        return view('accounts::edit');
    }


    public function update(Request $request, $id)
    {

        //save to database and return the response
        $response = UpdatePaymentMethods::dispatchNow($request, $id);

        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, 'PaymentMethodIndex');

    }

    public function destroy($id)
    {
        //save to database and return the response
        $response = DeletePaymentMethods::dispatchNow($id);

        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, null);
    }
}
