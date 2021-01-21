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

Route::get('app/{vue_capture?}', 'AppController')->where('vue_capture', '[\/\w\.-]*');
Route::get('login', 'AuthController@login')->name('login');
Route::get('logout', 'AuthController@logout')->name('logout');
Route::post('login', 'AuthController@login_post')->name('login.post');

Route::prefix('print')->group(function() {
    Route::get('/invoice/{id}', 'WebsiteController@printable_invoice');
});
