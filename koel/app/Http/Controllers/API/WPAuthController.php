<?php

namespace App\Http\Controllers\API;

use App\Http\Requests\API\UserLoginRequest;
use Exception;
use Illuminate\Http\JsonResponse;
use Tymon\JWTAuth\Exceptions\JWTException;
use Illuminate\Support\Facades\Auth;
use App\Models\User;

class WPAuthController extends Controller {
	public function verify( UserLoginRequest $request ){
		$credentials = $request->only('email', 'password');

		if( Auth::attempt( $credentials ) ){
			$user = User::where('email', $credentials['email'])->first();
			return response()->json(['isCredentialsValid' => true, 'wpid' => $user->wpid], 200);

			Auth::logout();
		} else {
			return response()->json(['isCredentialsValid' => false], 500);
		}
	}
}