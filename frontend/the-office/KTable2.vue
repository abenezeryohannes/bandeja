<template>
    <div class="card">
        <div class="card-header border-bottom-0">
            <form method="GET" action="http://localhost:8000/sales/invoices" accept-charset="UTF-8" role="form" class="mb-0">
                <div class="align-items-center">
                    <div class="el-select pl-20 mr-40">
                        <div class="el-input el-input--suffix">
                            <input type="text" readonly="readonly" autocomplete="off" placeholder="Type to search.." class="el-input__inner">
                            <span class="el-input__suffix">
                                <span class="el-input__suffix-inner">
                                    <i class="el-select__caret el-input__icon el-icon-"></i>
                                </span>
                            </span>
                        </div>
                        <div class="el-select-dropdown el-popper" style="display: none; min-width: 993px;">
                            <div class="el-scrollbar" style="display: none;">
                                <div class="el-select-dropdown__wrap el-scrollbar__wrap" style="margin-bottom: -15px; margin-right: -15px;">
                                    <ul class="el-scrollbar__view el-select-dropdown__list">
                                        <!---->
                                        <!---->
                                    </ul>
                                </div>
                                <div class="el-scrollbar__bar is-horizontal">
                                    <div class="el-scrollbar__thumb" style="transform: translateX(0%);"></div>
                                </div>
                                <div class="el-scrollbar__bar is-vertical">
                                    <div class="el-scrollbar__thumb" style="transform: translateY(0%);"></div>
                                </div>
                            </div>
                            <!---->
                        </div>
                    </div>
                </div>
                <!---->
                <!---->
            </form>
        </div>
        <div class="table-responsive">
            <table class="table table-flush table-hover">
                <thead class="thead-light">
                    <tr class="row table-head-line">
                        <th class="col-sm-2 col-md-1 col-lg-1 col-xl-1 d-none d-sm-block">
                            <div class="custom-control custom-checkbox"><input id="table-check-all" type="checkbox" class="custom-control-input"> <label for="table-check-all" class="custom-control-label"></label></div>
                        </th>
                        <th class="col-md-2 col-lg-1 col-xl-1 d-none d-md-block"><a href="http://localhost:8000/sales/invoices?filter=active%2C+visible&amp;sort=invoice_number&amp;direction=asc" rel="nofollow" class="col-aka">Number</a>&nbsp; <i class="fas fa-sort-numeric-up"></i></th>
                        <th class="col-xs-4 col-sm-4 col-md-4 col-lg-2 col-xl-2 text-left"><a href="http://localhost:8000/sales/invoices?sort=contact_name&amp;direction=asc">Customer</a>&nbsp; <i class="fas fa-arrow-down sort-icon"></i></th>
                        <th class="col-xs-4 col-sm-4 col-md-3 col-lg-2 col-xl-2 text-right"><a href="http://localhost:8000/sales/invoices?sort=amount&amp;direction=asc">Amount</a>&nbsp; <i class="fas fa-arrow-down sort-icon"></i></th>
                        <th class="col-lg-2 col-xl-2 d-none d-lg-block text-left"><a href="http://localhost:8000/sales/invoices?sort=invoiced_at&amp;direction=asc">Invoice Date</a>&nbsp; <i class="fas fa-arrow-down sort-icon"></i></th>
                        <th class="col-lg-2 col-xl-2 d-none d-lg-block text-left"><a href="http://localhost:8000/sales/invoices?sort=due_at&amp;direction=asc">Due Date</a>&nbsp; <i class="fas fa-arrow-down sort-icon"></i></th>
                        <th class="col-lg-1 col-xl-1 d-none d-lg-block text-center"><a href="http://localhost:8000/sales/invoices?sort=status&amp;direction=asc">Status</a>&nbsp; <i class="fas fa-arrow-down sort-icon"></i></th>
                        <th class="col-xs-4 col-sm-2 col-md-2 col-lg-1 col-xl-1 text-center"><a>Actions</a></th>
                    </tr>
                </thead>
                <tbody>
                    <tr class="row align-items-center border-top-1">
                        <td class="col-sm-2 col-md-1 col-lg-1 col-xl-1 d-none d-sm-block">
                            <div class="custom-control custom-checkbox"><input type="checkbox" id="bulk-action-28" data-bulk-action="28" class="custom-control-input" value="28"> <label for="bulk-action-28" class="custom-control-label"></label></div>
                        </td>
                        <td class="col-md-2 col-lg-1 col-xl-1 d-none d-md-block"><a href="http://localhost:8000/sales/invoices/28" class="col-aka">INV-99783</a></td>
                        <td class="col-xs-4 col-sm-4 col-md-4 col-lg-2 col-xl-2 text-left">Freddie Ward</td>
                        <td class="col-xs-4 col-sm-4 col-md-3 col-lg-2 col-xl-2 text-right">$269.22</td>
                        <td class="col-lg-2 col-xl-2 d-none d-lg-block text-left">20 Mar 2020</td>
                        <td class="col-lg-2 col-xl-2 d-none d-lg-block text-left">20 Mar 2020</td>
                        <td class="col-lg-1 col-xl-1 d-none d-lg-block text-center"><span class="badge badge-pill badge-info">Partial</span></td>
                        <td class="col-xs-4 col-sm-2 col-md-2 col-lg-1 col-xl-1 text-center">
                            <div class="dropdown"><a href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="btn btn-neutral btn-sm text-light items-align-center py-2"><i class="fa fa-ellipsis-h text-muted"></i></a>
                                <div class="dropdown-menu dropdown-menu-right dropdown-menu-arrow"><a href="http://localhost:8000/sales/invoices/28" class="dropdown-item">Show</a> <a href="http://localhost:8000/sales/invoices/28/edit" class="dropdown-item">Edit</a>
                                    <div class="dropdown-divider"></div> <a href="http://localhost:8000/sales/invoices/28/duplicate" class="dropdown-item">Duplicate</a>
                                    <div class="dropdown-divider"></div> <a href="http://localhost:8000/sales/invoices/28/cancelled" class="dropdown-item">Cancel</a> <button type="button" title="Delete" class="dropdown-item action-delete">Delete</button>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="row align-items-center border-top-1">
                        <td class="col-sm-2 col-md-1 col-lg-1 col-xl-1 d-none d-sm-block">
                            <div class="custom-control custom-checkbox"><input type="checkbox" id="bulk-action-57" data-bulk-action="57" class="custom-control-input" value="57"> <label for="bulk-action-57" class="custom-control-label"></label></div>
                        </td>
                        <td class="col-md-2 col-lg-1 col-xl-1 d-none d-md-block"><a href="http://localhost:8000/sales/invoices/57" class="col-aka">INV-98950</a></td>
                        <td class="col-xs-4 col-sm-4 col-md-4 col-lg-2 col-xl-2 text-left">Greg Brown</td>
                        <td class="col-xs-4 col-sm-4 col-md-3 col-lg-2 col-xl-2 text-right">$262.85</td>
                        <td class="col-lg-2 col-xl-2 d-none d-lg-block text-left">02 Jul 2020</td>
                        <td class="col-lg-2 col-xl-2 d-none d-lg-block text-left">02 Jul 2020</td>
                        <td class="col-lg-1 col-xl-1 d-none d-lg-block text-center"><span class="badge badge-pill badge-success">Paid</span></td>
                        <td class="col-xs-4 col-sm-2 col-md-2 col-lg-1 col-xl-1 text-center">
                            <div class="dropdown"><a href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="btn btn-neutral btn-sm text-light items-align-center py-2"><i class="fa fa-ellipsis-h text-muted"></i></a>
                                <div class="dropdown-menu dropdown-menu-right dropdown-menu-arrow"><a href="http://localhost:8000/sales/invoices/57" class="dropdown-item">Show</a> <a href="http://localhost:8000/sales/invoices/57/edit" class="dropdown-item">Edit</a>
                                    <div class="dropdown-divider"></div> <a href="http://localhost:8000/sales/invoices/57/duplicate" class="dropdown-item">Duplicate</a>
                                    <div class="dropdown-divider"></div> <a href="http://localhost:8000/sales/invoices/57/cancelled" class="dropdown-item">Cancel</a> <button type="button" title="Delete" class="dropdown-item action-delete">Delete</button>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="row align-items-center border-top-1">
                        <td class="col-sm-2 col-md-1 col-lg-1 col-xl-1 d-none d-sm-block">
                            <div class="custom-control custom-checkbox"><input type="checkbox" id="bulk-action-75" data-bulk-action="75" class="custom-control-input" value="75"> <label for="bulk-action-75" class="custom-control-label"></label></div>
                        </td>
                        <td class="col-md-2 col-lg-1 col-xl-1 d-none d-md-block"><a href="http://localhost:8000/sales/invoices/75" class="col-aka">INV-98602</a></td>
                        <td class="col-xs-4 col-sm-4 col-md-4 col-lg-2 col-xl-2 text-left">Abigail Russell</td>
                        <td class="col-xs-4 col-sm-4 col-md-3 col-lg-2 col-xl-2 text-right">$776.13</td>
                        <td class="col-lg-2 col-xl-2 d-none d-lg-block text-left">30 Mar 2020</td>
                        <td class="col-lg-2 col-xl-2 d-none d-lg-block text-left">30 Mar 2020</td>
                        <td class="col-lg-1 col-xl-1 d-none d-lg-block text-center"><span class="badge badge-pill badge-info">Partial</span></td>
                        <td class="col-xs-4 col-sm-2 col-md-2 col-lg-1 col-xl-1 text-center">
                            <div class="dropdown"><a href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="btn btn-neutral btn-sm text-light items-align-center py-2"><i class="fa fa-ellipsis-h text-muted"></i></a>
                                <div class="dropdown-menu dropdown-menu-right dropdown-menu-arrow"><a href="http://localhost:8000/sales/invoices/75" class="dropdown-item">Show</a> <a href="http://localhost:8000/sales/invoices/75/edit" class="dropdown-item">Edit</a>
                                    <div class="dropdown-divider"></div> <a href="http://localhost:8000/sales/invoices/75/duplicate" class="dropdown-item">Duplicate</a>
                                    <div class="dropdown-divider"></div> <a href="http://localhost:8000/sales/invoices/75/cancelled" class="dropdown-item">Cancel</a> <button type="button" title="Delete" class="dropdown-item action-delete">Delete</button>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="row align-items-center border-top-1">
                        <td class="col-sm-2 col-md-1 col-lg-1 col-xl-1 d-none d-sm-block">
                            <div class="custom-control custom-checkbox"><input type="checkbox" id="bulk-action-42" data-bulk-action="42" class="custom-control-input" value="42"> <label for="bulk-action-42" class="custom-control-label"></label></div>
                        </td>
                        <td class="col-md-2 col-lg-1 col-xl-1 d-none d-md-block"><a href="http://localhost:8000/sales/invoices/42" class="col-aka">INV-98284</a></td>
                        <td class="col-xs-4 col-sm-4 col-md-4 col-lg-2 col-xl-2 text-left">Abigail Rogers</td>
                        <td class="col-xs-4 col-sm-4 col-md-3 col-lg-2 col-xl-2 text-right">$406.62</td>
                        <td class="col-lg-2 col-xl-2 d-none d-lg-block text-left">19 Nov 2020</td>
                        <td class="col-lg-2 col-xl-2 d-none d-lg-block text-left">19 Nov 2020</td>
                        <td class="col-lg-1 col-xl-1 d-none d-lg-block text-center"><span class="badge badge-pill badge-success">Paid</span></td>
                        <td class="col-xs-4 col-sm-2 col-md-2 col-lg-1 col-xl-1 text-center">
                            <div class="dropdown"><a href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="btn btn-neutral btn-sm text-light items-align-center py-2"><i class="fa fa-ellipsis-h text-muted"></i></a>
                                <div class="dropdown-menu dropdown-menu-right dropdown-menu-arrow"><a href="http://localhost:8000/sales/invoices/42" class="dropdown-item">Show</a> <a href="http://localhost:8000/sales/invoices/42/edit" class="dropdown-item">Edit</a>
                                    <div class="dropdown-divider"></div> <a href="http://localhost:8000/sales/invoices/42/duplicate" class="dropdown-item">Duplicate</a>
                                    <div class="dropdown-divider"></div> <a href="http://localhost:8000/sales/invoices/42/cancelled" class="dropdown-item">Cancel</a> <button type="button" title="Delete" class="dropdown-item action-delete">Delete</button>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="row align-items-center border-top-1">
                        <td class="col-sm-2 col-md-1 col-lg-1 col-xl-1 d-none d-sm-block">
                            <div class="custom-control custom-checkbox"><input type="checkbox" id="bulk-action-31" data-bulk-action="31" class="custom-control-input" value="31"> <label for="bulk-action-31" class="custom-control-label"></label></div>
                        </td>
                        <td class="col-md-2 col-lg-1 col-xl-1 d-none d-md-block"><a href="http://localhost:8000/sales/invoices/31" class="col-aka">INV-96675</a></td>
                        <td class="col-xs-4 col-sm-4 col-md-4 col-lg-2 col-xl-2 text-left">Jodie James</td>
                        <td class="col-xs-4 col-sm-4 col-md-3 col-lg-2 col-xl-2 text-right">$547.18</td>
                        <td class="col-lg-2 col-xl-2 d-none d-lg-block text-left">28 Jan 2020</td>
                        <td class="col-lg-2 col-xl-2 d-none d-lg-block text-left">28 Jan 2020</td>
                        <td class="col-lg-1 col-xl-1 d-none d-lg-block text-center"><span class="badge badge-pill badge-warning">Viewed</span></td>
                        <td class="col-xs-4 col-sm-2 col-md-2 col-lg-1 col-xl-1 text-center">
                            <div class="dropdown"><a href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="btn btn-neutral btn-sm text-light items-align-center py-2"><i class="fa fa-ellipsis-h text-muted"></i></a>
                                <div class="dropdown-menu dropdown-menu-right dropdown-menu-arrow"><a href="http://localhost:8000/sales/invoices/31" class="dropdown-item">Show</a> <a href="http://localhost:8000/sales/invoices/31/edit" class="dropdown-item">Edit</a>
                                    <div class="dropdown-divider"></div> <a href="http://localhost:8000/sales/invoices/31/duplicate" class="dropdown-item">Duplicate</a>
                                    <div class="dropdown-divider"></div> <a href="http://localhost:8000/sales/invoices/31/cancelled" class="dropdown-item">Cancel</a> <button type="button" title="Delete" class="dropdown-item action-delete">Delete</button>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="row align-items-center border-top-1">
                        <td class="col-sm-2 col-md-1 col-lg-1 col-xl-1 d-none d-sm-block">
                            <div class="custom-control custom-checkbox"><input type="checkbox" id="bulk-action-29" data-bulk-action="29" class="custom-control-input" value="29"> <label for="bulk-action-29" class="custom-control-label"></label></div>
                        </td>
                        <td class="col-md-2 col-lg-1 col-xl-1 d-none d-md-block"><a href="http://localhost:8000/sales/invoices/29" class="col-aka">INV-93210</a></td>
                        <td class="col-xs-4 col-sm-4 col-md-4 col-lg-2 col-xl-2 text-left">Roxanne Wilson</td>
                        <td class="col-xs-4 col-sm-4 col-md-3 col-lg-2 col-xl-2 text-right">$577.86</td>
                        <td class="col-lg-2 col-xl-2 d-none d-lg-block text-left">09 Feb 2020</td>
                        <td class="col-lg-2 col-xl-2 d-none d-lg-block text-left">09 Feb 2020</td>
                        <td class="col-lg-1 col-xl-1 d-none d-lg-block text-center"><span class="badge badge-pill badge-dark">Cancelled</span></td>
                        <td class="col-xs-4 col-sm-2 col-md-2 col-lg-1 col-xl-1 text-center">
                            <div class="dropdown"><a href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="btn btn-neutral btn-sm text-light items-align-center py-2"><i class="fa fa-ellipsis-h text-muted"></i></a>
                                <div class="dropdown-menu dropdown-menu-right dropdown-menu-arrow"><a href="http://localhost:8000/sales/invoices/29" class="dropdown-item">Show</a> <a href="http://localhost:8000/sales/invoices/29/edit" class="dropdown-item">Edit</a>
                                    <div class="dropdown-divider"></div> <button type="button" title="Delete" class="dropdown-item action-delete">Delete</button>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="row align-items-center border-top-1">
                        <td class="col-sm-2 col-md-1 col-lg-1 col-xl-1 d-none d-sm-block">
                            <div class="custom-control custom-checkbox"><input type="checkbox" id="bulk-action-72" data-bulk-action="72" class="custom-control-input" value="72"> <label for="bulk-action-72" class="custom-control-label"></label></div>
                        </td>
                        <td class="col-md-2 col-lg-1 col-xl-1 d-none d-md-block"><a href="http://localhost:8000/sales/invoices/72" class="col-aka">INV-91821</a></td>
                        <td class="col-xs-4 col-sm-4 col-md-4 col-lg-2 col-xl-2 text-left">Jodie James</td>
                        <td class="col-xs-4 col-sm-4 col-md-3 col-lg-2 col-xl-2 text-right">$543.08</td>
                        <td class="col-lg-2 col-xl-2 d-none d-lg-block text-left">05 Feb 2020</td>
                        <td class="col-lg-2 col-xl-2 d-none d-lg-block text-left">05 Feb 2020</td>
                        <td class="col-lg-1 col-xl-1 d-none d-lg-block text-center"><span class="badge badge-pill badge-dark">Cancelled</span></td>
                        <td class="col-xs-4 col-sm-2 col-md-2 col-lg-1 col-xl-1 text-center">
                            <div class="dropdown"><a href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="btn btn-neutral btn-sm text-light items-align-center py-2"><i class="fa fa-ellipsis-h text-muted"></i></a>
                                <div class="dropdown-menu dropdown-menu-right dropdown-menu-arrow"><a href="http://localhost:8000/sales/invoices/72" class="dropdown-item">Show</a> <a href="http://localhost:8000/sales/invoices/72/edit" class="dropdown-item">Edit</a>
                                    <div class="dropdown-divider"></div> <button type="button" title="Delete" class="dropdown-item action-delete">Delete</button>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="row align-items-center border-top-1">
                        <td class="col-sm-2 col-md-1 col-lg-1 col-xl-1 d-none d-sm-block">
                            <div class="custom-control custom-checkbox"><input type="checkbox" id="bulk-action-5" data-bulk-action="5" class="custom-control-input" value="5"> <label for="bulk-action-5" class="custom-control-label"></label></div>
                        </td>
                        <td class="col-md-2 col-lg-1 col-xl-1 d-none d-md-block"><a href="http://localhost:8000/sales/invoices/5" class="col-aka">INV-91638</a></td>
                        <td class="col-xs-4 col-sm-4 col-md-4 col-lg-2 col-xl-2 text-left">Greg Brown</td>
                        <td class="col-xs-4 col-sm-4 col-md-3 col-lg-2 col-xl-2 text-right">$741.54</td>
                        <td class="col-lg-2 col-xl-2 d-none d-lg-block text-left">22 Jan 2020</td>
                        <td class="col-lg-2 col-xl-2 d-none d-lg-block text-left">22 Jan 2020</td>
                        <td class="col-lg-1 col-xl-1 d-none d-lg-block text-center"><span class="badge badge-pill badge-warning">Viewed</span></td>
                        <td class="col-xs-4 col-sm-2 col-md-2 col-lg-1 col-xl-1 text-center">
                            <div class="dropdown"><a href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="btn btn-neutral btn-sm text-light items-align-center py-2"><i class="fa fa-ellipsis-h text-muted"></i></a>
                                <div class="dropdown-menu dropdown-menu-right dropdown-menu-arrow"><a href="http://localhost:8000/sales/invoices/5" class="dropdown-item">Show</a> <a href="http://localhost:8000/sales/invoices/5/edit" class="dropdown-item">Edit</a>
                                    <div class="dropdown-divider"></div> <a href="http://localhost:8000/sales/invoices/5/duplicate" class="dropdown-item">Duplicate</a>
                                    <div class="dropdown-divider"></div> <a href="http://localhost:8000/sales/invoices/5/cancelled" class="dropdown-item">Cancel</a> <button type="button" title="Delete" class="dropdown-item action-delete">Delete</button>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="row align-items-center border-top-1">
                        <td class="col-sm-2 col-md-1 col-lg-1 col-xl-1 d-none d-sm-block">
                            <div class="custom-control custom-checkbox"><input type="checkbox" id="bulk-action-54" data-bulk-action="54" class="custom-control-input" value="54"> <label for="bulk-action-54" class="custom-control-label"></label></div>
                        </td>
                        <td class="col-md-2 col-lg-1 col-xl-1 d-none d-md-block"><a href="http://localhost:8000/sales/invoices/54" class="col-aka">INV-90301</a></td>
                        <td class="col-xs-4 col-sm-4 col-md-4 col-lg-2 col-xl-2 text-left">Greg Brown</td>
                        <td class="col-xs-4 col-sm-4 col-md-3 col-lg-2 col-xl-2 text-right">$80.12</td>
                        <td class="col-lg-2 col-xl-2 d-none d-lg-block text-left">08 Feb 2020</td>
                        <td class="col-lg-2 col-xl-2 d-none d-lg-block text-left">08 Feb 2020</td>
                        <td class="col-lg-1 col-xl-1 d-none d-lg-block text-center"><span class="badge badge-pill badge-success">Paid</span></td>
                        <td class="col-xs-4 col-sm-2 col-md-2 col-lg-1 col-xl-1 text-center">
                            <div class="dropdown"><a href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="btn btn-neutral btn-sm text-light items-align-center py-2"><i class="fa fa-ellipsis-h text-muted"></i></a>
                                <div class="dropdown-menu dropdown-menu-right dropdown-menu-arrow"><a href="http://localhost:8000/sales/invoices/54" class="dropdown-item">Show</a> <a href="http://localhost:8000/sales/invoices/54/edit" class="dropdown-item">Edit</a>
                                    <div class="dropdown-divider"></div> <a href="http://localhost:8000/sales/invoices/54/duplicate" class="dropdown-item">Duplicate</a>
                                    <div class="dropdown-divider"></div> <a href="http://localhost:8000/sales/invoices/54/cancelled" class="dropdown-item">Cancel</a> <button type="button" title="Delete" class="dropdown-item action-delete">Delete</button>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="row align-items-center border-top-1">
                        <td class="col-sm-2 col-md-1 col-lg-1 col-xl-1 d-none d-sm-block">
                            <div class="custom-control custom-checkbox"><input type="checkbox" id="bulk-action-82" data-bulk-action="82" class="custom-control-input" value="82"> <label for="bulk-action-82" class="custom-control-label"></label></div>
                        </td>
                        <td class="col-md-2 col-lg-1 col-xl-1 d-none d-md-block"><a href="http://localhost:8000/sales/invoices/82" class="col-aka">INV-8928</a></td>
                        <td class="col-xs-4 col-sm-4 col-md-4 col-lg-2 col-xl-2 text-left">Will Holmes</td>
                        <td class="col-xs-4 col-sm-4 col-md-3 col-lg-2 col-xl-2 text-right">$151.11</td>
                        <td class="col-lg-2 col-xl-2 d-none d-lg-block text-left">21 May 2020</td>
                        <td class="col-lg-2 col-xl-2 d-none d-lg-block text-left">21 May 2020</td>
                        <td class="col-lg-1 col-xl-1 d-none d-lg-block text-center"><span class="badge badge-pill badge-warning">Viewed</span></td>
                        <td class="col-xs-4 col-sm-2 col-md-2 col-lg-1 col-xl-1 text-center">
                            <div class="dropdown"><a href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="btn btn-neutral btn-sm text-light items-align-center py-2"><i class="fa fa-ellipsis-h text-muted"></i></a>
                                <div class="dropdown-menu dropdown-menu-right dropdown-menu-arrow"><a href="http://localhost:8000/sales/invoices/82" class="dropdown-item">Show</a> <a href="http://localhost:8000/sales/invoices/82/edit" class="dropdown-item">Edit</a>
                                    <div class="dropdown-divider"></div> <a href="http://localhost:8000/sales/invoices/82/duplicate" class="dropdown-item">Duplicate</a>
                                    <div class="dropdown-divider"></div> <a href="http://localhost:8000/sales/invoices/82/cancelled" class="dropdown-item">Cancel</a> <button type="button" title="Delete" class="dropdown-item action-delete">Delete</button>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="row align-items-center border-top-1">
                        <td class="col-sm-2 col-md-1 col-lg-1 col-xl-1 d-none d-sm-block">
                            <div class="custom-control custom-checkbox"><input type="checkbox" id="bulk-action-7" data-bulk-action="7" class="custom-control-input" value="7"> <label for="bulk-action-7" class="custom-control-label"></label></div>
                        </td>
                        <td class="col-md-2 col-lg-1 col-xl-1 d-none d-md-block"><a href="http://localhost:8000/sales/invoices/7" class="col-aka">INV-8798</a></td>
                        <td class="col-xs-4 col-sm-4 col-md-4 col-lg-2 col-xl-2 text-left">Tom Hill</td>
                        <td class="col-xs-4 col-sm-4 col-md-3 col-lg-2 col-xl-2 text-right">$102.31</td>
                        <td class="col-lg-2 col-xl-2 d-none d-lg-block text-left">18 Jun 2020</td>
                        <td class="col-lg-2 col-xl-2 d-none d-lg-block text-left">18 Jun 2020</td>
                        <td class="col-lg-1 col-xl-1 d-none d-lg-block text-center"><span class="badge badge-pill badge-dark">Cancelled</span></td>
                        <td class="col-xs-4 col-sm-2 col-md-2 col-lg-1 col-xl-1 text-center">
                            <div class="dropdown"><a href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="btn btn-neutral btn-sm text-light items-align-center py-2"><i class="fa fa-ellipsis-h text-muted"></i></a>
                                <div class="dropdown-menu dropdown-menu-right dropdown-menu-arrow"><a href="http://localhost:8000/sales/invoices/7" class="dropdown-item">Show</a> <a href="http://localhost:8000/sales/invoices/7/edit" class="dropdown-item">Edit</a>
                                    <div class="dropdown-divider"></div> <button type="button" title="Delete" class="dropdown-item action-delete">Delete</button>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="row align-items-center border-top-1">
                        <td class="col-sm-2 col-md-1 col-lg-1 col-xl-1 d-none d-sm-block">
                            <div class="custom-control custom-checkbox"><input type="checkbox" id="bulk-action-4" data-bulk-action="4" class="custom-control-input" value="4"> <label for="bulk-action-4" class="custom-control-label"></label></div>
                        </td>
                        <td class="col-md-2 col-lg-1 col-xl-1 d-none d-md-block"><a href="http://localhost:8000/sales/invoices/4" class="col-aka">INV-87968</a></td>
                        <td class="col-xs-4 col-sm-4 col-md-4 col-lg-2 col-xl-2 text-left">Freddie Ward</td>
                        <td class="col-xs-4 col-sm-4 col-md-3 col-lg-2 col-xl-2 text-right">$497.30</td>
                        <td class="col-lg-2 col-xl-2 d-none d-lg-block text-left">12 Jun 2020</td>
                        <td class="col-lg-2 col-xl-2 d-none d-lg-block text-left">12 Jun 2020</td>
                        <td class="col-lg-1 col-xl-1 d-none d-lg-block text-center"><span class="badge badge-pill badge-success">Paid</span></td>
                        <td class="col-xs-4 col-sm-2 col-md-2 col-lg-1 col-xl-1 text-center">
                            <div class="dropdown"><a href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="btn btn-neutral btn-sm text-light items-align-center py-2"><i class="fa fa-ellipsis-h text-muted"></i></a>
                                <div class="dropdown-menu dropdown-menu-right dropdown-menu-arrow"><a href="http://localhost:8000/sales/invoices/4" class="dropdown-item">Show</a> <a href="http://localhost:8000/sales/invoices/4/edit" class="dropdown-item">Edit</a>
                                    <div class="dropdown-divider"></div> <a href="http://localhost:8000/sales/invoices/4/duplicate" class="dropdown-item">Duplicate</a>
                                    <div class="dropdown-divider"></div> <a href="http://localhost:8000/sales/invoices/4/cancelled" class="dropdown-item">Cancel</a> <button type="button" title="Delete" class="dropdown-item action-delete">Delete</button>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="row align-items-center border-top-1">
                        <td class="col-sm-2 col-md-1 col-lg-1 col-xl-1 d-none d-sm-block">
                            <div class="custom-control custom-checkbox"><input type="checkbox" id="bulk-action-18" data-bulk-action="18" class="custom-control-input" value="18"> <label for="bulk-action-18" class="custom-control-label"></label></div>
                        </td>
                        <td class="col-md-2 col-lg-1 col-xl-1 d-none d-md-block"><a href="http://localhost:8000/sales/invoices/18" class="col-aka">INV-87765</a></td>
                        <td class="col-xs-4 col-sm-4 col-md-4 col-lg-2 col-xl-2 text-left">Justine Russell</td>
                        <td class="col-xs-4 col-sm-4 col-md-3 col-lg-2 col-xl-2 text-right">$646.01</td>
                        <td class="col-lg-2 col-xl-2 d-none d-lg-block text-left">27 Apr 2020</td>
                        <td class="col-lg-2 col-xl-2 d-none d-lg-block text-left">27 Apr 2020</td>
                        <td class="col-lg-1 col-xl-1 d-none d-lg-block text-center"><span class="badge badge-pill badge-info">Partial</span></td>
                        <td class="col-xs-4 col-sm-2 col-md-2 col-lg-1 col-xl-1 text-center">
                            <div class="dropdown"><a href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="btn btn-neutral btn-sm text-light items-align-center py-2"><i class="fa fa-ellipsis-h text-muted"></i></a>
                                <div class="dropdown-menu dropdown-menu-right dropdown-menu-arrow"><a href="http://localhost:8000/sales/invoices/18" class="dropdown-item">Show</a> <a href="http://localhost:8000/sales/invoices/18/edit" class="dropdown-item">Edit</a>
                                    <div class="dropdown-divider"></div> <a href="http://localhost:8000/sales/invoices/18/duplicate" class="dropdown-item">Duplicate</a>
                                    <div class="dropdown-divider"></div> <a href="http://localhost:8000/sales/invoices/18/cancelled" class="dropdown-item">Cancel</a> <button type="button" title="Delete" class="dropdown-item action-delete">Delete</button>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="row align-items-center border-top-1">
                        <td class="col-sm-2 col-md-1 col-lg-1 col-xl-1 d-none d-sm-block">
                            <div class="custom-control custom-checkbox"><input type="checkbox" id="bulk-action-69" data-bulk-action="69" class="custom-control-input" value="69"> <label for="bulk-action-69" class="custom-control-label"></label></div>
                        </td>
                        <td class="col-md-2 col-lg-1 col-xl-1 d-none d-md-block"><a href="http://localhost:8000/sales/invoices/69" class="col-aka">INV-87004</a></td>
                        <td class="col-xs-4 col-sm-4 col-md-4 col-lg-2 col-xl-2 text-left">Justine Russell</td>
                        <td class="col-xs-4 col-sm-4 col-md-3 col-lg-2 col-xl-2 text-right">$1,014.07</td>
                        <td class="col-lg-2 col-xl-2 d-none d-lg-block text-left">03 Jul 2020</td>
                        <td class="col-lg-2 col-xl-2 d-none d-lg-block text-left">03 Jul 2020</td>
                        <td class="col-lg-1 col-xl-1 d-none d-lg-block text-center"><span class="badge badge-pill badge-success">Paid</span></td>
                        <td class="col-xs-4 col-sm-2 col-md-2 col-lg-1 col-xl-1 text-center">
                            <div class="dropdown"><a href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="btn btn-neutral btn-sm text-light items-align-center py-2"><i class="fa fa-ellipsis-h text-muted"></i></a>
                                <div class="dropdown-menu dropdown-menu-right dropdown-menu-arrow"><a href="http://localhost:8000/sales/invoices/69" class="dropdown-item">Show</a> <a href="http://localhost:8000/sales/invoices/69/edit" class="dropdown-item">Edit</a>
                                    <div class="dropdown-divider"></div> <a href="http://localhost:8000/sales/invoices/69/duplicate" class="dropdown-item">Duplicate</a>
                                    <div class="dropdown-divider"></div> <a href="http://localhost:8000/sales/invoices/69/cancelled" class="dropdown-item">Cancel</a> <button type="button" title="Delete" class="dropdown-item action-delete">Delete</button>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="row align-items-center border-top-1">
                        <td class="col-sm-2 col-md-1 col-lg-1 col-xl-1 d-none d-sm-block">
                            <div class="custom-control custom-checkbox"><input type="checkbox" id="bulk-action-85" data-bulk-action="85" class="custom-control-input" value="85"> <label for="bulk-action-85" class="custom-control-label"></label></div>
                        </td>
                        <td class="col-md-2 col-lg-1 col-xl-1 d-none d-md-block"><a href="http://localhost:8000/sales/invoices/85" class="col-aka">INV-83761</a></td>
                        <td class="col-xs-4 col-sm-4 col-md-4 col-lg-2 col-xl-2 text-left">Tom Hill</td>
                        <td class="col-xs-4 col-sm-4 col-md-3 col-lg-2 col-xl-2 text-right">$656.49</td>
                        <td class="col-lg-2 col-xl-2 d-none d-lg-block text-left">22 Jan 2020</td>
                        <td class="col-lg-2 col-xl-2 d-none d-lg-block text-left">22 Jan 2020</td>
                        <td class="col-lg-1 col-xl-1 d-none d-lg-block text-center"><span class="badge badge-pill badge-warning">Viewed</span></td>
                        <td class="col-xs-4 col-sm-2 col-md-2 col-lg-1 col-xl-1 text-center">
                            <div class="dropdown"><a href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="btn btn-neutral btn-sm text-light items-align-center py-2"><i class="fa fa-ellipsis-h text-muted"></i></a>
                                <div class="dropdown-menu dropdown-menu-right dropdown-menu-arrow"><a href="http://localhost:8000/sales/invoices/85" class="dropdown-item">Show</a> <a href="http://localhost:8000/sales/invoices/85/edit" class="dropdown-item">Edit</a>
                                    <div class="dropdown-divider"></div> <a href="http://localhost:8000/sales/invoices/85/duplicate" class="dropdown-item">Duplicate</a>
                                    <div class="dropdown-divider"></div> <a href="http://localhost:8000/sales/invoices/85/cancelled" class="dropdown-item">Cancel</a> <button type="button" title="Delete" class="dropdown-item action-delete">Delete</button>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="row align-items-center border-top-1">
                        <td class="col-sm-2 col-md-1 col-lg-1 col-xl-1 d-none d-sm-block">
                            <div class="custom-control custom-checkbox"><input type="checkbox" id="bulk-action-3" data-bulk-action="3" class="custom-control-input" value="3"> <label for="bulk-action-3" class="custom-control-label"></label></div>
                        </td>
                        <td class="col-md-2 col-lg-1 col-xl-1 d-none d-md-block"><a href="http://localhost:8000/sales/invoices/3" class="col-aka">INV-83698</a></td>
                        <td class="col-xs-4 col-sm-4 col-md-4 col-lg-2 col-xl-2 text-left">Freddie Ward</td>
                        <td class="col-xs-4 col-sm-4 col-md-3 col-lg-2 col-xl-2 text-right">$254.54</td>
                        <td class="col-lg-2 col-xl-2 d-none d-lg-block text-left">25 Sep 2020</td>
                        <td class="col-lg-2 col-xl-2 d-none d-lg-block text-left">25 Sep 2020</td>
                        <td class="col-lg-1 col-xl-1 d-none d-lg-block text-center"><span class="badge badge-pill badge-dark">Cancelled</span></td>
                        <td class="col-xs-4 col-sm-2 col-md-2 col-lg-1 col-xl-1 text-center">
                            <div class="dropdown"><a href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="btn btn-neutral btn-sm text-light items-align-center py-2"><i class="fa fa-ellipsis-h text-muted"></i></a>
                                <div class="dropdown-menu dropdown-menu-right dropdown-menu-arrow"><a href="http://localhost:8000/sales/invoices/3" class="dropdown-item">Show</a> <a href="http://localhost:8000/sales/invoices/3/edit" class="dropdown-item">Edit</a>
                                    <div class="dropdown-divider"></div> <button type="button" title="Delete" class="dropdown-item action-delete">Delete</button>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="row align-items-center border-top-1">
                        <td class="col-sm-2 col-md-1 col-lg-1 col-xl-1 d-none d-sm-block">
                            <div class="custom-control custom-checkbox"><input type="checkbox" id="bulk-action-13" data-bulk-action="13" class="custom-control-input" value="13"> <label for="bulk-action-13" class="custom-control-label"></label></div>
                        </td>
                        <td class="col-md-2 col-lg-1 col-xl-1 d-none d-md-block"><a href="http://localhost:8000/sales/invoices/13" class="col-aka">INV-8369</a></td>
                        <td class="col-xs-4 col-sm-4 col-md-4 col-lg-2 col-xl-2 text-left">Neil Martin</td>
                        <td class="col-xs-4 col-sm-4 col-md-3 col-lg-2 col-xl-2 text-right">$641.41</td>
                        <td class="col-lg-2 col-xl-2 d-none d-lg-block text-left">18 Jun 2020</td>
                        <td class="col-lg-2 col-xl-2 d-none d-lg-block text-left">18 Jun 2020</td>
                        <td class="col-lg-1 col-xl-1 d-none d-lg-block text-center"><span class="badge badge-pill badge-info">Partial</span></td>
                        <td class="col-xs-4 col-sm-2 col-md-2 col-lg-1 col-xl-1 text-center">
                            <div class="dropdown"><a href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="btn btn-neutral btn-sm text-light items-align-center py-2"><i class="fa fa-ellipsis-h text-muted"></i></a>
                                <div class="dropdown-menu dropdown-menu-right dropdown-menu-arrow"><a href="http://localhost:8000/sales/invoices/13" class="dropdown-item">Show</a> <a href="http://localhost:8000/sales/invoices/13/edit" class="dropdown-item">Edit</a>
                                    <div class="dropdown-divider"></div> <a href="http://localhost:8000/sales/invoices/13/duplicate" class="dropdown-item">Duplicate</a>
                                    <div class="dropdown-divider"></div> <a href="http://localhost:8000/sales/invoices/13/cancelled" class="dropdown-item">Cancel</a> <button type="button" title="Delete" class="dropdown-item action-delete">Delete</button>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="row align-items-center border-top-1">
                        <td class="col-sm-2 col-md-1 col-lg-1 col-xl-1 d-none d-sm-block">
                            <div class="custom-control custom-checkbox"><input type="checkbox" id="bulk-action-41" data-bulk-action="41" class="custom-control-input" value="41"> <label for="bulk-action-41" class="custom-control-label"></label></div>
                        </td>
                        <td class="col-md-2 col-lg-1 col-xl-1 d-none d-md-block"><a href="http://localhost:8000/sales/invoices/41" class="col-aka">INV-81616</a></td>
                        <td class="col-xs-4 col-sm-4 col-md-4 col-lg-2 col-xl-2 text-left">Justine Russell</td>
                        <td class="col-xs-4 col-sm-4 col-md-3 col-lg-2 col-xl-2 text-right">$370.12</td>
                        <td class="col-lg-2 col-xl-2 d-none d-lg-block text-left">12 Mar 2020</td>
                        <td class="col-lg-2 col-xl-2 d-none d-lg-block text-left">12 Mar 2020</td>
                        <td class="col-lg-1 col-xl-1 d-none d-lg-block text-center"><span class="badge badge-pill badge-success">Paid</span></td>
                        <td class="col-xs-4 col-sm-2 col-md-2 col-lg-1 col-xl-1 text-center">
                            <div class="dropdown"><a href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="btn btn-neutral btn-sm text-light items-align-center py-2"><i class="fa fa-ellipsis-h text-muted"></i></a>
                                <div class="dropdown-menu dropdown-menu-right dropdown-menu-arrow"><a href="http://localhost:8000/sales/invoices/41" class="dropdown-item">Show</a> <a href="http://localhost:8000/sales/invoices/41/edit" class="dropdown-item">Edit</a>
                                    <div class="dropdown-divider"></div> <a href="http://localhost:8000/sales/invoices/41/duplicate" class="dropdown-item">Duplicate</a>
                                    <div class="dropdown-divider"></div> <a href="http://localhost:8000/sales/invoices/41/cancelled" class="dropdown-item">Cancel</a> <button type="button" title="Delete" class="dropdown-item action-delete">Delete</button>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="row align-items-center border-top-1">
                        <td class="col-sm-2 col-md-1 col-lg-1 col-xl-1 d-none d-sm-block">
                            <div class="custom-control custom-checkbox"><input type="checkbox" id="bulk-action-94" data-bulk-action="94" class="custom-control-input" value="94"> <label for="bulk-action-94" class="custom-control-label"></label></div>
                        </td>
                        <td class="col-md-2 col-lg-1 col-xl-1 d-none d-md-block"><a href="http://localhost:8000/sales/invoices/94" class="col-aka">INV-81475</a></td>
                        <td class="col-xs-4 col-sm-4 col-md-4 col-lg-2 col-xl-2 text-left">Abigail Russell</td>
                        <td class="col-xs-4 col-sm-4 col-md-3 col-lg-2 col-xl-2 text-right">$461.86</td>
                        <td class="col-lg-2 col-xl-2 d-none d-lg-block text-left">23 Nov 2020</td>
                        <td class="col-lg-2 col-xl-2 d-none d-lg-block text-left">23 Nov 2020</td>
                        <td class="col-lg-1 col-xl-1 d-none d-lg-block text-center"><span class="badge badge-pill badge-warning">Viewed</span></td>
                        <td class="col-xs-4 col-sm-2 col-md-2 col-lg-1 col-xl-1 text-center">
                            <div class="dropdown"><a href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="btn btn-neutral btn-sm text-light items-align-center py-2"><i class="fa fa-ellipsis-h text-muted"></i></a>
                                <div class="dropdown-menu dropdown-menu-right dropdown-menu-arrow"><a href="http://localhost:8000/sales/invoices/94" class="dropdown-item">Show</a> <a href="http://localhost:8000/sales/invoices/94/edit" class="dropdown-item">Edit</a>
                                    <div class="dropdown-divider"></div> <a href="http://localhost:8000/sales/invoices/94/duplicate" class="dropdown-item">Duplicate</a>
                                    <div class="dropdown-divider"></div> <a href="http://localhost:8000/sales/invoices/94/cancelled" class="dropdown-item">Cancel</a> <button type="button" title="Delete" class="dropdown-item action-delete">Delete</button>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="row align-items-center border-top-1">
                        <td class="col-sm-2 col-md-1 col-lg-1 col-xl-1 d-none d-sm-block">
                            <div class="custom-control custom-checkbox"><input type="checkbox" id="bulk-action-44" data-bulk-action="44" class="custom-control-input" value="44"> <label for="bulk-action-44" class="custom-control-label"></label></div>
                        </td>
                        <td class="col-md-2 col-lg-1 col-xl-1 d-none d-md-block"><a href="http://localhost:8000/sales/invoices/44" class="col-aka">INV-80655</a></td>
                        <td class="col-xs-4 col-sm-4 col-md-4 col-lg-2 col-xl-2 text-left">Justine Russell</td>
                        <td class="col-xs-4 col-sm-4 col-md-3 col-lg-2 col-xl-2 text-right">$161.76</td>
                        <td class="col-lg-2 col-xl-2 d-none d-lg-block text-left">26 Mar 2020</td>
                        <td class="col-lg-2 col-xl-2 d-none d-lg-block text-left">26 Mar 2020</td>
                        <td class="col-lg-1 col-xl-1 d-none d-lg-block text-center"><span class="badge badge-pill badge-danger">Sent</span></td>
                        <td class="col-xs-4 col-sm-2 col-md-2 col-lg-1 col-xl-1 text-center">
                            <div class="dropdown"><a href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="btn btn-neutral btn-sm text-light items-align-center py-2"><i class="fa fa-ellipsis-h text-muted"></i></a>
                                <div class="dropdown-menu dropdown-menu-right dropdown-menu-arrow"><a href="http://localhost:8000/sales/invoices/44" class="dropdown-item">Show</a> <a href="http://localhost:8000/sales/invoices/44/edit" class="dropdown-item">Edit</a>
                                    <div class="dropdown-divider"></div> <a href="http://localhost:8000/sales/invoices/44/duplicate" class="dropdown-item">Duplicate</a>
                                    <div class="dropdown-divider"></div> <a href="http://localhost:8000/sales/invoices/44/cancelled" class="dropdown-item">Cancel</a> <button type="button" title="Delete" class="dropdown-item action-delete">Delete</button>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="row align-items-center border-top-1">
                        <td class="col-sm-2 col-md-1 col-lg-1 col-xl-1 d-none d-sm-block">
                            <div class="custom-control custom-checkbox"><input type="checkbox" id="bulk-action-79" data-bulk-action="79" class="custom-control-input" value="79"> <label for="bulk-action-79" class="custom-control-label"></label></div>
                        </td>
                        <td class="col-md-2 col-lg-1 col-xl-1 d-none d-md-block"><a href="http://localhost:8000/sales/invoices/79" class="col-aka">INV-78964</a></td>
                        <td class="col-xs-4 col-sm-4 col-md-4 col-lg-2 col-xl-2 text-left">Justine Russell</td>
                        <td class="col-xs-4 col-sm-4 col-md-3 col-lg-2 col-xl-2 text-right">$444.22</td>
                        <td class="col-lg-2 col-xl-2 d-none d-lg-block text-left">05 Jan 2020</td>
                        <td class="col-lg-2 col-xl-2 d-none d-lg-block text-left">05 Jan 2020</td>
                        <td class="col-lg-1 col-xl-1 d-none d-lg-block text-center"><span class="badge badge-pill badge-danger">Sent</span></td>
                        <td class="col-xs-4 col-sm-2 col-md-2 col-lg-1 col-xl-1 text-center">
                            <div class="dropdown"><a href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="btn btn-neutral btn-sm text-light items-align-center py-2"><i class="fa fa-ellipsis-h text-muted"></i></a>
                                <div class="dropdown-menu dropdown-menu-right dropdown-menu-arrow"><a href="http://localhost:8000/sales/invoices/79" class="dropdown-item">Show</a> <a href="http://localhost:8000/sales/invoices/79/edit" class="dropdown-item">Edit</a>
                                    <div class="dropdown-divider"></div> <a href="http://localhost:8000/sales/invoices/79/duplicate" class="dropdown-item">Duplicate</a>
                                    <div class="dropdown-divider"></div> <a href="http://localhost:8000/sales/invoices/79/cancelled" class="dropdown-item">Cancel</a> <button type="button" title="Delete" class="dropdown-item action-delete">Delete</button>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="row align-items-center border-top-1">
                        <td class="col-sm-2 col-md-1 col-lg-1 col-xl-1 d-none d-sm-block">
                            <div class="custom-control custom-checkbox"><input type="checkbox" id="bulk-action-12" data-bulk-action="12" class="custom-control-input" value="12"> <label for="bulk-action-12" class="custom-control-label"></label></div>
                        </td>
                        <td class="col-md-2 col-lg-1 col-xl-1 d-none d-md-block"><a href="http://localhost:8000/sales/invoices/12" class="col-aka">INV-78037</a></td>
                        <td class="col-xs-4 col-sm-4 col-md-4 col-lg-2 col-xl-2 text-left">Jason Martin</td>
                        <td class="col-xs-4 col-sm-4 col-md-3 col-lg-2 col-xl-2 text-right">$871.64</td>
                        <td class="col-lg-2 col-xl-2 d-none d-lg-block text-left">15 Jul 2020</td>
                        <td class="col-lg-2 col-xl-2 d-none d-lg-block text-left">15 Jul 2020</td>
                        <td class="col-lg-1 col-xl-1 d-none d-lg-block text-center"><span class="badge badge-pill badge-danger">Sent</span></td>
                        <td class="col-xs-4 col-sm-2 col-md-2 col-lg-1 col-xl-1 text-center">
                            <div class="dropdown"><a href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="btn btn-neutral btn-sm text-light items-align-center py-2"><i class="fa fa-ellipsis-h text-muted"></i></a>
                                <div class="dropdown-menu dropdown-menu-right dropdown-menu-arrow"><a href="http://localhost:8000/sales/invoices/12" class="dropdown-item">Show</a> <a href="http://localhost:8000/sales/invoices/12/edit" class="dropdown-item">Edit</a>
                                    <div class="dropdown-divider"></div> <a href="http://localhost:8000/sales/invoices/12/duplicate" class="dropdown-item">Duplicate</a>
                                    <div class="dropdown-divider"></div> <a href="http://localhost:8000/sales/invoices/12/cancelled" class="dropdown-item">Cancel</a> <button type="button" title="Delete" class="dropdown-item action-delete">Delete</button>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="row align-items-center border-top-1">
                        <td class="col-sm-2 col-md-1 col-lg-1 col-xl-1 d-none d-sm-block">
                            <div class="custom-control custom-checkbox"><input type="checkbox" id="bulk-action-25" data-bulk-action="25" class="custom-control-input" value="25"> <label for="bulk-action-25" class="custom-control-label"></label></div>
                        </td>
                        <td class="col-md-2 col-lg-1 col-xl-1 d-none d-md-block"><a href="http://localhost:8000/sales/invoices/25" class="col-aka">INV-7765</a></td>
                        <td class="col-xs-4 col-sm-4 col-md-4 col-lg-2 col-xl-2 text-left">Tom Hill</td>
                        <td class="col-xs-4 col-sm-4 col-md-3 col-lg-2 col-xl-2 text-right">$807.40</td>
                        <td class="col-lg-2 col-xl-2 d-none d-lg-block text-left">20 Mar 2020</td>
                        <td class="col-lg-2 col-xl-2 d-none d-lg-block text-left">20 Mar 2020</td>
                        <td class="col-lg-1 col-xl-1 d-none d-lg-block text-center"><span class="badge badge-pill badge-success">Paid</span></td>
                        <td class="col-xs-4 col-sm-2 col-md-2 col-lg-1 col-xl-1 text-center">
                            <div class="dropdown"><a href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="btn btn-neutral btn-sm text-light items-align-center py-2"><i class="fa fa-ellipsis-h text-muted"></i></a>
                                <div class="dropdown-menu dropdown-menu-right dropdown-menu-arrow"><a href="http://localhost:8000/sales/invoices/25" class="dropdown-item">Show</a> <a href="http://localhost:8000/sales/invoices/25/edit" class="dropdown-item">Edit</a>
                                    <div class="dropdown-divider"></div> <a href="http://localhost:8000/sales/invoices/25/duplicate" class="dropdown-item">Duplicate</a>
                                    <div class="dropdown-divider"></div> <a href="http://localhost:8000/sales/invoices/25/cancelled" class="dropdown-item">Cancel</a> <button type="button" title="Delete" class="dropdown-item action-delete">Delete</button>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="row align-items-center border-top-1">
                        <td class="col-sm-2 col-md-1 col-lg-1 col-xl-1 d-none d-sm-block">
                            <div class="custom-control custom-checkbox"><input type="checkbox" id="bulk-action-22" data-bulk-action="22" class="custom-control-input" value="22"> <label for="bulk-action-22" class="custom-control-label"></label></div>
                        </td>
                        <td class="col-md-2 col-lg-1 col-xl-1 d-none d-md-block"><a href="http://localhost:8000/sales/invoices/22" class="col-aka">INV-75313</a></td>
                        <td class="col-xs-4 col-sm-4 col-md-4 col-lg-2 col-xl-2 text-left">Freddie Ward</td>
                        <td class="col-xs-4 col-sm-4 col-md-3 col-lg-2 col-xl-2 text-right">$608.56</td>
                        <td class="col-lg-2 col-xl-2 d-none d-lg-block text-left">17 Nov 2020</td>
                        <td class="col-lg-2 col-xl-2 d-none d-lg-block text-left">17 Nov 2020</td>
                        <td class="col-lg-1 col-xl-1 d-none d-lg-block text-center"><span class="badge badge-pill badge-info">Partial</span></td>
                        <td class="col-xs-4 col-sm-2 col-md-2 col-lg-1 col-xl-1 text-center">
                            <div class="dropdown"><a href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="btn btn-neutral btn-sm text-light items-align-center py-2"><i class="fa fa-ellipsis-h text-muted"></i></a>
                                <div class="dropdown-menu dropdown-menu-right dropdown-menu-arrow"><a href="http://localhost:8000/sales/invoices/22" class="dropdown-item">Show</a> <a href="http://localhost:8000/sales/invoices/22/edit" class="dropdown-item">Edit</a>
                                    <div class="dropdown-divider"></div> <a href="http://localhost:8000/sales/invoices/22/duplicate" class="dropdown-item">Duplicate</a>
                                    <div class="dropdown-divider"></div> <a href="http://localhost:8000/sales/invoices/22/cancelled" class="dropdown-item">Cancel</a> <button type="button" title="Delete" class="dropdown-item action-delete">Delete</button>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="row align-items-center border-top-1">
                        <td class="col-sm-2 col-md-1 col-lg-1 col-xl-1 d-none d-sm-block">
                            <div class="custom-control custom-checkbox"><input type="checkbox" id="bulk-action-55" data-bulk-action="55" class="custom-control-input" value="55"> <label for="bulk-action-55" class="custom-control-label"></label></div>
                        </td>
                        <td class="col-md-2 col-lg-1 col-xl-1 d-none d-md-block"><a href="http://localhost:8000/sales/invoices/55" class="col-aka">INV-72120</a></td>
                        <td class="col-xs-4 col-sm-4 col-md-4 col-lg-2 col-xl-2 text-left">Jodie James</td>
                        <td class="col-xs-4 col-sm-4 col-md-3 col-lg-2 col-xl-2 text-right">$1,119.11</td>
                        <td class="col-lg-2 col-xl-2 d-none d-lg-block text-left">04 Jul 2020</td>
                        <td class="col-lg-2 col-xl-2 d-none d-lg-block text-left">04 Jul 2020</td>
                        <td class="col-lg-1 col-xl-1 d-none d-lg-block text-center"><span class="badge badge-pill badge-dark">Cancelled</span></td>
                        <td class="col-xs-4 col-sm-2 col-md-2 col-lg-1 col-xl-1 text-center">
                            <div class="dropdown"><a href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="btn btn-neutral btn-sm text-light items-align-center py-2"><i class="fa fa-ellipsis-h text-muted"></i></a>
                                <div class="dropdown-menu dropdown-menu-right dropdown-menu-arrow"><a href="http://localhost:8000/sales/invoices/55" class="dropdown-item">Show</a> <a href="http://localhost:8000/sales/invoices/55/edit" class="dropdown-item">Edit</a>
                                    <div class="dropdown-divider"></div> <button type="button" title="Delete" class="dropdown-item action-delete">Delete</button>
                                </div>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="card-footer table-action">
            <div class="row">
                <div class="col-xs-12 col-sm-5 d-flex align-items-center"><select name="limit" class="form-control form-control-sm d-inline-block w-auto d-none d-md-block">
                        <option value="10">10</option>
                        <option value="25" selected="selected">25</option>
                        <option value="50">50</option>
                        <option value="100">100</option>
                    </select> <span class="table-text d-none d-lg-block ml-2">
                        per page.
                        1-25 of 100 records.
                    </span></div>
                <div class="col-xs-12 col-sm-7 pagination-xs">
                    <nav class="float-right">
                        <ul class="pagination mb-0">
                            <li class="page-item disabled"><span class="page-link">«</span></li>
                            <li class="page-item active"><span class="page-link">1</span></li>
                            <li class="page-item"><a href="http://localhost:8000/sales/invoices?sort=invoice_number&amp;direction=desc&amp;page=2" class="page-link">2</a></li>
                            <li class="page-item"><a href="http://localhost:8000/sales/invoices?sort=invoice_number&amp;direction=desc&amp;page=3" class="page-link">3</a></li>
                            <li class="page-item d-none d-sm-block"><a href="http://localhost:8000/sales/invoices?sort=invoice_number&amp;direction=desc&amp;page=4" class="page-link">4</a></li>
                            <li class="page-item"><a href="http://localhost:8000/sales/invoices?sort=invoice_number&amp;direction=desc&amp;page=2" rel="next" class="page-link">»</a></li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </div>
</template>
