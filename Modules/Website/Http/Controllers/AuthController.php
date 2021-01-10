<?php

namespace Modules\Website\Http\Controllers;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Auth;

class AuthController extends Controller
{

    function __construct()
    {
        $this->middleware('guest')->except('logout');
    }

    public function logout(Request $request)
  {
    Auth::logout();
//    Auth::guard('admin')->logout();
      // session()->flash('user_permisssions');
      // session()->flash('main_menu');
    return redirect()->to('/login');
  }

    public function login()
    {
        $meta = [
            'title' => 'Walta '
        ];
        return view('login', compact('meta'));
    }

    public function login_post(Request $request)
    {
      if (
        Auth::attempt([
          'email' => $request['email'], 
          'password' => $request['password'] 
        ])
        ||
        Auth::attempt([
          'email_generated' => $request['email'],
          'password' => $request['password'] 
        ])
      ) {
            return redirect()->intended('/app');          
        }

        return redirect()->back();  
    }
}
