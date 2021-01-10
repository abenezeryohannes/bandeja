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

Route::prefix('api/v1/')->middleware('auth')->group(function() {
    Route::post('change_lang', 'ChangeLangController');
    Route::resource('user/profile', 'ProfileController');
});

