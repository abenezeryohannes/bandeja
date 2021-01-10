<?php

namespace Modules\Util\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

class SetLocale
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle(Request $request, Closure $next)
    {

        // if user is authenticated check the setting
        if (auth()->user()) {
            app()->setLocale(auth()->user()->locale);
        }else{
            // else set english
            app()->setLocale('en');
        }
        return $next($request);
    }
}
