<!DOCTYPE html>
<html lang="en">

<head>
    <title>{{$meta['title']}}</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Favicon -->
    <link rel="icon" href="{{ url('img/favicon.ico') }}" type="image/png">
    <!-- Font -->
    <link rel="stylesheet" href="{{ url('vendor/opensans/css/opensans.css?v=' . env('FRONTEND_VERSION')) }}" type="text/css">
    <!-- Icons -->
    <link rel="stylesheet" href="{{ url('vendor/nucleo/css/nucleo.css?v=' . env('FRONTEND_VERSION')) }}" type="text/css">
    <link rel="stylesheet" href="{{ url('vendor/fontawesome/css/all.min.css?v=' . env('FRONTEND_VERSION')) }}" type="text/css">
    <!-- Css -->
    <link rel="stylesheet" href="{{ url('css/argon.css?v=' . env('FRONTEND_VERSION')) }}" type="text/css">
    <link rel="stylesheet" href="{{ url('css/akaunting-color.css?v=' . env('FRONTEND_VERSION')) }}" type="text/css">
    <link rel="stylesheet" href="{{ url('css/custom.css?v=' . env('FRONTEND_VERSION')) }}" type="text/css">
    <link rel="stylesheet" href="{{ url('css/element.css?v=' . env('FRONTEND_VERSION')) }}" type="text/css">
</head>

<body class="login-page">
    <div class="main-content mt-4">
        <div class="header">
            <div class="container">
                <div class="header-body text-center">
                    <div class="row justify-content-center">
                        <div class="col-xl-5 col-lg-6 col-md-8">
                            <img class="mb-5" src="{{url('img/akaunting-logo-white.svg')}}" width="22%" alt="Akaunting" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-5 col-md-7">
                    <div class="card mb-0 login-card-bg">
                        <div class="card-body px-lg-5 py-lg-5">
                            <div class="text-center text-white mb-4">
                                <small>Login to start your session</small>
                            </div>
                            <div id="app">
                                <div role="alert" class="alert alert-danger d-none" :class="(form.response.error) ? 'show' : ''" v-if="form.response.error" v-html="form.response.message"></div>
                                
                                <form method="POST" action="{{url('login')}}" accept-charset="UTF-8" id="login"  role="form" class="form-loading-button" novalidate enctype="multipart/form-data">
                                  @csrf
                                    <div class="form-group has-feedback" :class="[{'has-error': form.errors.get(&quot;email&quot;) }]">
                                        <div class="input-group input-group-merge input-group-alternative">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text">
                                                    <i class="fa fa-envelope"></i>
                                                </span>
                                            </div>
                                            <input class="form-control" data-name="email" placeholder="Email" v-model="form.email" name="email" type="email">
                                        </div>
                                        <div class="invalid-feedback d-block" v-if="form.errors.has(&quot;email&quot;)" v-html="form.errors.get(&quot;email&quot;)">
                                        </div>
                                    </div>
                                    <div class="form-group has-feedback" :class="[{'has-error': form.errors.get(&quot;password&quot;) }]">
                                        <div class="input-group input-group-merge input-group-alternative">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text">
                                                    <i class="fa fa-unlock-alt"></i>
                                                </span>
                                            </div>
                                            <input class="form-control" data-name="password" placeholder="Password" v-model="form.password" name="password" type="password" value="">
                                        </div>
                                        <div class="invalid-feedback d-block" v-if="form.errors.has(&quot;password&quot;)" v-html="form.errors.get(&quot;password&quot;)">
                                        </div>
                                    </div>
                                    <div class="row align-items-center">
                                        <div class="col-xs-12 col-sm-8">
                                            <div class="custom-control custom-control-alternative custom-checkbox">
                                                <input id="checkbox-remember" class="custom-control-input" v-model="form.remember" name="remember" type="checkbox" value="1">
                                                <label class="custom-control-label" for="checkbox-remember">
                                                    <span class="text-white">Remember Me</span>
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col-xs-12 col-sm-4">
                                            <button :disabled="form.loading" type="submit" class="btn btn-success float-right header-button-top" data-loading-text="Loading...">
                                                <div class="aka-loader"></div> <span>Login</span>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="mt-5 mb--4">
                                        <a href="#" class="text-white"><small>I forgot my password</small></a>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <footer>
            <div class="container mt-5 mb-4">
                <div class="row align-items-center justify-content-xl-between">
                    <div class="col-xl-12">
                        <div class="copyright text-center text-white">
                            <small>
                                Powered By : <a href="https://melfantech.com" target="_blank" class="text-white">Melfan Tech</a>
                            </small>
                        </div>
                    </div>
                </div>
            </div>
        </footer>
    </div>
    <!-- <script src="{{url('login_assets/js/main.js')}}"></script> -->
</body>

</html>
