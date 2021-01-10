<?php

namespace App\Http\Middleware;

use Illuminate\Auth\Middleware\Authenticate as Middleware;

use Illuminate\Auth\AuthenticationException;
class Authenticate extends Middleware
{
    /**
     * Get the path the user should be redirected to when they are not authenticated.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return string|null
     */
    protected function redirectTo($request)
    {
        // return response()->json([]);
        if (! $request->expectsJson()) {
            return route('login');
        }
        // dd("dds");
    }

    protected function unauthenticated($request, array $guards)
    {
        if ($request->is('api/*')) {
            throw new \App\Exceptions\ApiAuthenticationException(
                'Unauthenticated.'
            );
        }
        throw new AuthenticationException(
            'Unauthenticated.', $guards
        );
    }

}
