<!DOCTYPE html>
<html  style="height: auto; min-height: 100%;">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>{{$meta['title']}}</title>
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

    <!-- Font -->
    <link rel="stylesheet" href="{{url('vendor/opensans/css/opensans.css')}}" type="text/css">

    <!-- Icons -->
    <link rel="stylesheet" href="{{url('vendor/nucleo/css/nucleo.css')}}" type="text/css">
    <link rel="stylesheet" href="{{url('vendor/fontawesome/css/all.min.css')}}" type="text/css">

    <!-- Css -->
    <link rel="stylesheet" href="{{url('css/argon.css')}}" type="text/css">
    <link rel="stylesheet" href="{{url('css/akaunting-color.css')}}" type="text/css">
    <link rel="stylesheet" href="{{url('css/custom.css')}}" type="text/css">
    <link rel="stylesheet" href="{{url('css/element.css')}}" type="text/css">


    <script src="{{ mix('js/manifest.js') }}" defer></script>
    <script src="{{ mix('js/vendor.js') }}" defer></script>

    <script src="{{ mix('js/components.js').'?v='.env('FRONTEND_VERSION') }}" defer></script>
    <script src="{{ mix('js/app.js').'?v='.env('FRONTEND_VERSION') }}" defer></script>
</head>
<body  id="leftMenu" class="g-sidenav-show g-sidenav-pinned" style="" data-new-gr-c-s-check-loaded="14.990.0" data-gr-ext-installed="" cz-shortcut-listen="true">
<div id="app" v-cloak>
    <router-view 
    ></router-view>
</div>

<style>
    [v-cloak] > * {
        display: none;
    }
    [v-cloak]::before {
        content: url({{url('/img/loading.gif')}});
        text-align: center;
        display: block;
        height:100%;
        vertical-align: middle;
        position: relative;
        background-color: white;
    }
</style>

</body>
</html>
