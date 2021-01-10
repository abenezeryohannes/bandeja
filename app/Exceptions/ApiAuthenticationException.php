<?php

namespace App\Exceptions;

use Exception;

use Illuminate\Http\Request;
class ApiAuthenticationException extends Exception
{

	public function __construct($message = 'Unauthenticated.')
    {
        parent::__construct($message);
    }

    public function render(Request $request)
    {
    	return response()->json([
    		"message" => $this->message,
    		"redirect_to" => url('/login')
    	], 401);
	 }

}
