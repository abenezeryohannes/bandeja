<?php

namespace Modules\User\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

use Modules\User\Services\Authorization;
use Auth;
class Permission
{

    private $authorize;

    public function __construct()
    {
        $this->authorize = app('authorization');
    }
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle(Request $request, Closure $next, ...$permissions)
    {
        $this->authorize->setUser(Auth::user());
        $p1 = $this->authorize->hasPermissions($permissions);
        // dump($p1);
        if (!$p1) {
            return response([
                "message" => "unauthorized"
            ],403);
        }
        return $next($request);
    }
}
