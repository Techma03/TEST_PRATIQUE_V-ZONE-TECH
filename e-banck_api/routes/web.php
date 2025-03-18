<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\carteController;

Route::get('/', function () {
    return view('welcome');
});
Route::get('/getcart', [carteController::class, 'getCarte']);