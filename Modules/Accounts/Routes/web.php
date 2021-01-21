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

Route::prefix('api/v1/accounts')->group(function() {
    Route::get('/', 'AccountsController@index');
    Route::post('/store', 'AccountsController@store');
    Route::get('/transactions/{id}', 'AccountsController@transactions');
    Route::post('/update/{id}', 'AccountsController@update');
    Route::get('/destroy/{id}', 'AccountsController@destroy');
    Route::get('/show/{id}', 'AccountsController@show');
});



Route::prefix('api/v1/payment_methods')->group(function() {
    Route::get('/', 'PaymentMethodsController@index');
    Route::post('/store', 'PaymentMethodsController@store');
    Route::post('/update/{id}', 'PaymentMethodsController@update');
    Route::get('/destroy/{id}', 'PaymentMethodsController@destroy');
    Route::get('/show/{id}', 'PaymentMethodsController@show');
});



Route::prefix('api/v1/transactions')->group(function() {
    Route::get('/', 'TransactionsController@index');
    Route::post('/store', 'TransactionsController@store');
    Route::post('/update/{id}', 'TransactionsController@update');
    Route::get('/destroy/{id}', 'TransactionsController@destroy');
    Route::get('/show/{id}', 'TransactionsController@show');
});



Route::prefix('api/v1/taxes')->group(function() {
    Route::get('/', 'TaxesController@index');
    Route::post('/store', 'TaxesController@store');
    Route::post('/update/{id}', 'TaxesController@update');
    Route::get('/destroy/{id}', 'TaxesController@destroy');
    Route::get('/show/{id}', 'TaxesController@show');
});



Route::prefix('api/v1/categories')->group(function() {
    Route::get('/', 'CategoriesController@index');
    Route::post('/store', 'CategoriesController@store');
    Route::post('/update/{id}', 'CategoriesController@update');
    Route::get('/destroy/{id}', 'CategoriesController@destroy');
    Route::get('/show/{id}', 'CategoriesController@show');
});

Route::prefix('api/v1/interests')->group(function() {
    Route::get('/', 'InterestsController@index');
    Route::post('/store', 'InterestsController@store');
    Route::post('/update/{id}', 'InterestsController@update');
    Route::get('/destroy/{id}', 'InterestsController@destroy');
});