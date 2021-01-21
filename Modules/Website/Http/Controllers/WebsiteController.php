<?php

namespace Modules\Website\Http\Controllers;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;

class WebsiteController extends Controller
{
    /**
     * Display a listing of the resource.
     * @return Renderable
     */
    public function printable_invoice()
    {
        $the_data = (object)[ 'tenant' => (object)[ 'physical_address' => '', 'name' => '', 'tin_number' => '', 'phone_number' => '', 'email_address' => '' ], 'status' => '', 'invoice_number' =>1, 'invoice_date' => '', 'due_date' => 12 ];
        return view('printable_invoice', [
            'the_data' => $the_data  
        ]);
    }

    /**
     * Show the form for creating a new resource.
     * @return Renderable
     */
    public function create()
    {
        return view('website::create');
    }

    /**
     * Store a newly created resource in storage.
     * @param Request $request
     * @return Renderable
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Show the specified resource.
     * @param int $id
     * @return Renderable
     */
    public function show($id)
    {
        return view('website::show');
    }

    /**
     * Show the form for editing the specified resource.
     * @param int $id
     * @return Renderable
     */
    public function edit($id)
    {
        return view('website::edit');
    }

    /**
     * Update the specified resource in storage.
     * @param Request $request
     * @param int $id
     * @return Renderable
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     * @param int $id
     * @return Renderable
     */
    public function destroy($id)
    {
        //
    }
}
