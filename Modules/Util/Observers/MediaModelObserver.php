<?php

namespace Modules\Util\Observers;

use Illuminate\Support\Facades\Route;
use Illuminate\Foundation\Support\Providers\RouteServiceProvider as ServiceProvider;

class MediaModelObserver
{

    public function created($model)
    {
        dd($model);
    }

}
