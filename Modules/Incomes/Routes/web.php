<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::prefix('api/v1/invoices')->group(function() {
    Route::get('/', 'InvoicesController@index');
    Route::get('/create', 'InvoicesController@create');
    Route::post('/store', 'InvoicesController@store');
    Route::post('/update/{id}', 'InvoicesController@update');
    Route::get('/destroy/{id}', 'InvoicesController@destroy');
    Route::get('/show/{id}', 'InvoicesController@show');
    Route::get('/transactions/{id}', 'InvoicesController@transactions');
    Route::post('/cancel/{id}', 'InvoicesController@cancel');
    Route::post('/pay/{id}', 'InvoicesController@pay');
    Route::get('/pay/{id}', 'InvoicesController@pay_form');

});

Route::prefix('api/v1/invoice_payments')->group(function() {
    Route::get('/', 'InvoicePaymentsController@index');
    Route::post('/store', 'InvoicePaymentsController@store');
    Route::post('/update/{id}', 'InvoicePaymentsController@update');
    Route::get('/destroy/{id}', 'InvoicePaymentsController@destroy');
    Route::get('/show/{id}', 'InvoicePaymentsController@show');
});

Route::prefix('api/v1/revenues')->group(function() {
    Route::get('/', 'RevenuesController@index');
    Route::post('/store', 'RevenuesController@store');
    Route::get('/create', 'RevenuesController@create');
    Route::post('/update/{id}', 'RevenuesController@update');
    Route::get('/destroy/{id}', 'RevenuesController@destroy');
    Route::get('/show/{id}', 'RevenuesController@show');
});

Route::prefix('api/v1/tenants')->group(function() {
    Route::get('/', 'TenantsController@index');
    Route::get('/create', 'TenantsController@create');
    Route::post('/store', 'TenantsController@store');
    Route::post('/update/{id}', 'TenantsController@update');
    Route::get('/destroy/{id}', 'TenantsController@destroy');
    Route::get('/show/{id}', 'TenantsController@show');
    Route::get('/invoices/{id}', 'TenantsController@invoices');
    Route::get('/transactions/{id}', 'TenantsController@transactions');
});

