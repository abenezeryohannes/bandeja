<!DOCTYPE html>
<html  style="height: auto; min-height: 100%;">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title></title>
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



</head>
<body  id="leftMenu" class="g-sidenav-show g-sidenav-pinned" style="" data-new-gr-c-s-check-loaded="14.990.0" data-gr-ext-installed="" cz-shortcut-listen="true">
<div id="row" >
    <div class="card">
        <div class="card-header status-info">
            <h3 class="text-white mb-0 float-right">{{$the_data->status}}</h3>
        </div>
        <div class="card-body">
            <div class="row mx--4">
                <div class="col-md-7 border-bottom-1">
                    <div class="table-responsive mt-2">
                        <table class="table table-borderless">
                            <tbody>
                                <tr>
                                    <th><img src="data:image/png;base64,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" alt="My Company"></th>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="col-md-5 border-bottom-1">
                    <div class="table-responsive">
                        <table class="table table-borderless">
                            <tbody>
                                <tr>
                                    <th> Walta Eth </th>
                                </tr>
                                <tr>
                                    <th> Ethiopia, Addis Ababa </th>
                                </tr>
                                <tr>
                                    <th>Tax No: 35 </th>
                                </tr>
                                <tr>
                                    <th> my@company.com </th>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-7 long-texts">
                    <div class="table-responsive">
                        <table class="table table-borderless">
                            <tbody>
                                <tr>
                                    <th> Bill To <strong class="d-block">{{$the_data->tenant->name}}</strong></th>
                                </tr>
                                <tr>
                                    <th> {{$the_data->tenant->physical_address}}</th>
                                </tr>
                                <tr>
                                    <th> Tin Numbers: {{$the_data->tenant->tin_number}} </th>
                                </tr>
                                <tr>
                                    <th> {{$the_data->tenant->phone_number}} </th>
                                </tr>
                                <tr>
                                    <th> {{$the_data->tenant->email_address}} </th>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="col-md-5 long-texts">
                    <div class="table-responsive">
                        <table class="table table-borderless">
                            <tbody>
                                <tr>
                                    <th>Invoice Number:</th>
                                    <td class="text-right">{{$the_data->invoice_number}}</td>
                                </tr>
                                <tr>
                                    <th>Invoice Date:</th>
                                    <td class="text-right">{{$the_data->invoice_date}}</td>
                                </tr>
                                <tr>
                                    <th>Payment Due:</th>
                                    <td class="text-right">{{$the_data->due_date}}</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="row show-table">
                <div class="col-md-12">
                    <div class="table-responsive overflow-y-hidden">
                        <table class="table table-striped">
                            <tbody>
                                <tr class="d-flex flex-nowrap">
                                    <th class="col-sm-3 pl-5">Property</th>
                                    <th class="col-sm-2 text-center">From</th>
                                    <th class="col-sm-2 text-right d-none d-sm-block">Period</th>
                                    <th class="col-sm-2 text-center">Price</th>
                                    <th class="col-sm-3 text-right pr-5">Total</th>
                                </tr>
                                <tr class="d-flex flex-nowrap">
                                    <td class="col-sm-3 pl-5"> Quibusdam et. <br><small class="text-pre-nowrap">Tempora dolor delectus ex eaque et sed. Officiis quaerat repellendus sed. Molestias dolor sit et.<small></small></small></td>
                                    <td class="col-sm-2 text-center">1</td>
                                    <td class="col-sm-2 text-right d-none d-sm-block">$330.86</td>
                                    <td class="col-sm-2 text-center">1</td>
                                    <td class="col-sm-3 text-right pr-5">$330.86</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="row mt-5">
                <div class="col-md-7">
                    <!-- <div class="table-responsive">
                        <table class="table table-borderless">
                            <tbody>
                                <tr>
                                    <th>
                                        <p class="form-control-label">Notes</p>
                                        <p class="text-muted long-texts">Qui.</p>
                                    </th>
                                </tr>
                            </tbody>
                        </table>
                    </div> -->
                </div>
                <div class="col-md-5">
                    <div class="table-responsive">
                        <table class="table">
                            <tbody>
                                <tr>
                                    <th>Subtotal:</th>
                                    <td class="text-right">$330.86</td>
                                </tr>
                                <tr>
                                    <th>Id qui et. (18.63%):</th>
                                    <td class="text-right">$61.64</td>
                                </tr>
                                <tr>
                                    <th class="text-success"> Paid: </th>
                                    <td class="text-success text-right">- $110.00</td>
                                </tr>
                                <tr>
                                    <th>Total:</th>
                                    <td class="text-right">$159.22</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

    </div>






</div>

<script type="text/javascript">
    window.print()
</script>

</body>
</html>
