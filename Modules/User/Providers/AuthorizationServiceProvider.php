<?php

namespace Modules\User\Providers;

use Illuminate\Support\ServiceProvider;

use Illuminate\Http\Request;
use Auth;
use Modules\User\Services\Authorization;
class AuthorizationServiceProvider extends ServiceProvider
{
    /**
     * Register the service provider.
     *
     * @return void
     */
    public function register()
    {
        // $this->app->singleton(Authorization::class, function ($app) {
        $this->app->singleton('authorization', function ($app) {
            return new Authorization();
        });
    }

    /**
     * Get the services provided by the provider.
     *
     * @return array
     */
    public function provides()
    {
        return [];
    }

    public function boot(Request $request)
    {
        // if (Auth::user()) {
        //     $request->_roles = "sth";
        // }else{
        //     $request->_roles = "sths";
        // }
        // dd($request);
    }
}
