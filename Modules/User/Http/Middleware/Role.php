<?php

namespace Modules\User\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

use Modules\User\Services\Authorization;
use Auth;
class Role
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
    public function handle(Request $request, Closure $next, ...$roles)
    {
        $this->authorize->setUser(Auth::user());
        $p1 = $this->authorize->hasRoles($roles);
        // dump($p1);
        if (!$p1) {
            return response([
                "message" => "unauthorized"
            ],403);
        }
        return $next($request);
    }
}
