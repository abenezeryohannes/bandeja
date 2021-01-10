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

Route::prefix('properties')->group(function() {
    Route::get('/', 'PropertiesController@index');
    Route::post('/store', 'PropertiesController@store');
    Route::get('/show/{id}', 'PropertiesController@show');
    Route::post('/update/{id}', 'PropertiesController@update');
    Route::get('/destroy/{id}', 'PropertiesController@destroy');
});

Route::prefix('sites')->group(function() {
    Route::get('/', 'SitesController@index');
    Route::post('/store', 'SitesController@store');
    Route::get('/show/{id}', 'SitesController@show');
    Route::post('/update/{id}', 'SitesController@update');
    Route::get('/destroy/{id}', 'SitesController@destroy');
});

Route::prefix('blocks')->group(function() {
    Route::get('/', 'BlocksController@index');
    Route::post('/store', 'BlocksController@store');
    Route::get('/show/{id}', 'BlocksController@show');
    Route::post('/update/{id}', 'BlocksController@update');
    Route::get('/destroy/{id}', 'BlocksController@destroy');
});
Route::get('csrf', 'PropertiesController@csrf');

Route::prefix('propertycategories')->group(function() {
    Route::get('/', 'PropertyCategoriesController@index');
    Route::post('/store', 'PropertyCategoriesController@store');
    Route::get('/show/{id}', 'PropertyCategoriesController@show');
    Route::post('/update/{id}', 'PropertyCategoriesController@update');
    Route::get('/destroy/{id}', 'PropertyCategoriesController@destroy');
});
