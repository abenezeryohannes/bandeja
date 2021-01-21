<?php


 Route::get('api/v1/csrf', 'PropertiesController@csrf');

Route::prefix('api/v1/properties')->group(function() {
    Route::get('/', 'PropertiesController@index');
    Route::get('/available_properties', 'PropertiesController@availableProperties');
    Route::patch('/store', 'PropertiesController@store');
    Route::get('/create', 'PropertiesController@create');
    Route::get('/show/{id}', 'PropertiesController@show');
    Route::get('/invoices/{id}', 'PropertiesController@invoices');
    Route::post('/update/{id}', 'PropertiesController@update');
    Route::get('/destroy/{id}', 'PropertiesController@destroy');
    Route::patch('/destroyAll', 'PropertiesController@destroyAll');
});

Route::prefix('api/v1/sites')->group(function() {
    Route::get('/', 'SitesController@index');
    Route::patch('/store', 'SitesController@store');
    Route::get('/create', 'SitesController@create');
    Route::get('/show/{id}', 'SitesController@show');
    Route::post('/update/{id}', 'SitesController@update');
    Route::get('/destroy/{id}', 'SitesController@destroy');
    Route::patch('/destroyAll', 'SitesController@destroyAll');
});

Route::prefix('api/v1/blocks')->group(function() {
    Route::get('/', 'BlocksController@index');
    Route::patch('/store', 'BlocksController@store');
    Route::get('/create', 'BlocksController@create');
    Route::get('/show/{id}', 'BlocksController@show');
    Route::post('/update/{id}', 'BlocksController@update');
    Route::get('/destroy/{id}', 'BlocksController@destroy');
    Route::patch('/destroyAll', 'BlocksController@destroyAll');
});



// Route::resource('api/v1/propertycategories', 'PropertyCategoriesController');

Route::prefix('api/v1/propertycategories')->group(function() {
    Route::get('/', 'PropertyCategoriesController@index');
    Route::patch('/store', 'PropertyCategoriesController@store');
    Route::get('/create', 'PropertyCategoriesController@create');
    Route::get('/show/{id}', 'PropertyCategoriesController@show');
    Route::get('/edit/{id}', 'PropertyCategoriesController@edit');
    Route::put('/update/{id}', 'PropertyCategoriesController@update');
    Route::get('/destroy/{id}', 'PropertyCategoriesController@destroy');
    Route::patch('/destroyAll', 'PropertyCategoriesController@destroyAll');
});
