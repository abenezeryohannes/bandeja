<?php

namespace Modules\User\Http\Controllers;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Hash;

class ProfileController extends Controller
{

    public function __construct()
    {
        $this->middleware('auth');
    }
    /**
     * Display a listing of the resource.
     * @return Renderable
     */
    public function index()
    {
        return view('user::index');
    }

    /**
     * Show the form for creating a new resource.
     * @return Renderable
     */
    public function create()
    {
        return response()->json([
            'user' => auth()->user(),
            'form' => [
                'fields' => [
                    [ 'label' => 'Name', 'required' => 'required', 'icon' => 'fa fa-font', 'type' => 'input', 'column' => 'col-md-6', 'input_type' => 'text', 'default' =>  auth()->user()->name, 'name' => 'name' ],
                    [ 'label' => 'Email', 'required' => 'required', 'icon' => 'fa fa-envelope', 'type' => 'input', 'column' => 'col-md-6', 'input_type' => 'email', 'default' =>  auth()->user()->email, 'name' => 'email' ],

                    [ 'label' => 'Password', 'required' => 'required', 'icon' => 'fa fa-key', 'type' => 'input', 'column' => 'col-md-6', 'input_type' => 'password', 'default' =>  null, 'name' => 'password1' ],
                    [ 'label' => 'Confirm Password', 'required' => 'required', 'icon' => 'fa fa-key', 'type' => 'input', 'column' => 'col-md-6', 'input_type' => 'password', 'default' =>  null, 'name' => 'password2' ],

                    [ 'label' => 'Language', 'required' => 'required', 'icon' => 'fa fa-save', 'type' => 'select', 'column' => 'col-md-6', 'options' => [ [ 'label' => '- Select Language -', 'value' => 0],[ 'label' => 'Amharic', 'value' => 'am'],[ 'label' => 'English', 'value' => 'en']  ], 'default' =>  auth()->user()->locale, 'name' => 'locale' ],
                    [ 'label' => 'File Uploader', 'required' => 'required', 'icon' => 'fa fa-key', 'type' => 'file', 'column' => 'col-md-6', 'file_types' => 'img', 'default' =>  null, 'name' => 'picture' ],
                ],
                'strings' => [
                    'save' => 'Update',
                    'saving' => 'Updating ...',
                    // 'save' => 'Update',
                    'cancel' => 'cancel'
                ]
            ] 
        ]);
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
        return view('user::show');
    }

    /**
     * Show the form for editing the specified resource.
     * @param int $id
     * @return Renderable
     */
    public function edit($id)
    {
        return view('user::edit');
    }

    /**
     * Update the specified resource in storage.
     * @param Request $request
     * @param int $id
     * @return Renderable
     */
    public function update(Request $request, $id)
    {
        if ($request['password1'] != $request['password2']) {
            return response()->json([
                'errors' => [
                    // 'password1' => ['Passwords do not match'],
                    'password2' => [__('validation.confirmed',['attribute'=>'password'])],
                ]
            ], 422);
        }
        $request->validate([
            'name' => 'required',
            'email' => 'required|email',
        ]);
        $me = auth()->user();
        $me['name'] = $request['name'];
        $me['email'] = $request['email'];
        $me['locale'] = $request['locale'];
        if ($request['password']) {
            # code...
            $me['password'] = Hash::make($request['password']) ;
        }

        $me->save();
        return $request->all();
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
