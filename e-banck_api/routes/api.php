<?php

use App\Http\Controllers\carteController;
use Illuminate\Support\Facades\Route;

Route::get('/getcart', [carteController::class, 'getCarte']);