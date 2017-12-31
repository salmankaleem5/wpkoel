<?php

use Illuminate\Http\Request;

Route::group(['namespace' => 'API'], function () {
	Route::post('verify', 'WPAuthController@verify');
	Route::resource('user', 'APIUserController', ['only' => ['store', 'update', 'destroy']]);
});