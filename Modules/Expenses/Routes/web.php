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





Route::prefix('api/v1/bills')->group(function() {
    Route::get('/', 'BillsController@index');
    Route::post('/store', 'BillsController@store');
    Route::post('/update/{id}', 'BillsController@update');
    Route::get('/destroy/{id}', 'BillsController@destroy');
    Route::get('/show/{id}', 'BillsController@show');
    Route::get('/transactions/{id}', 'BillsController@transactions');
    Route::get('/cancel/{id}', 'BillsController@cancel');
    Route::post('/pay/{id}', 'BillsController@pay');
});


Route::prefix('api/v1/vendors')->group(function() {
    Route::get('/', 'VendorsController@index');
    Route::post('/store', 'VendorsController@store');
    Route::post('/update/{id}', 'VendorsController@update');
    Route::get('/destroy/{id}', 'VendorsController@destroy');
    Route::get('/show/{id}', 'VendorsController@show');
    Route::get('/transactions/{id}', 'VendorsController@transactions');
    Route::get('/bills/{id}', 'VendorsController@bills');
});

Route::prefix('api/v1/payments')->group(function() {
    Route::get('/', 'PaymentsController@index');
    Route::post('/store', 'PaymentsController@store');
    Route::post('/update/{id}', 'PaymentsController@update');
    Route::get('/destroy/{id}', 'PaymentsController@destroy');
    Route::get('/show/{id}', 'PaymentsController@show');
});



Route::prefix('api/v1/vendor_categories')->group(function() {
    Route::get('/', 'VendorCategoriesController@index');
    Route::post('/store', 'VendorCategoriesController@store');
    Route::post('/update/{id}', 'VendorCategoriesController@update');
    Route::get('/destroy/{id}', 'VendorCategoriesController@destroy');
});


Route::prefix('api/v1/recurrings')->group(function() {
    Route::get('/', 'RecurringsController@index');
    Route::post('/store', 'RecurringsController@store');
    Route::post('/update/{id}', 'RecurringsController@update');
    Route::get('/destroy/{id}', 'RecurringsController@destroy');
});
