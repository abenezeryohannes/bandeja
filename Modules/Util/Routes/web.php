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

Route::get('/api/v1/boot', 'BootController');
Route::get('/api/v1/notification', 'NotificationController');

// Route::get('/', 'UtilController@index');

Route::get('media/{path?}', 'MediaController')->where('path', '[\/\w\.-]*')->name('media');

Route::prefix('util')->group(function() {
    Route::get('/', 'UtilController@index');
});
