<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class carteController extends Controller
{
    public function getCarte(Request $request){
        $carte = DB::table('cartebanck')
            ->select( 'numbanck')
            ->orderBy('created_at', 'desc') // Tri par date décroissante
            ->get();

        $carte= $carte->map(function ($item, $index) {
            $item->num = $index + 1; // Ajoute un champ 'num' avec une numérotation croissante
            return $item;
        });

        return response()->json($carte);

    }
}
