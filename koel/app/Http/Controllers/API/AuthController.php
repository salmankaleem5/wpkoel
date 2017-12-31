<?php

namespace App\Http\Controllers\API;

use App\Http\Requests\API\UserLoginRequest;
use Exception;
use Illuminate\Http\JsonResponse;
use JWTAuth;
use Log;
use Tymon\JWTAuth\Exceptions\JWTException;

use App\Models\User;
use DB;
use Corcel\Services\PasswordService;

class AuthController extends Controller
{
    /**
     * Log a user in.
     *
     * @param UserLoginRequest $request
     *
     * @return JsonResponse
     */
    public function login(UserLoginRequest $request)
    {
        /*
            If request->wplogincheck is set, then check if user login works in WordPress
                Yes: Get ID of user in WordPress. Get corresponding email and password of corresponding user in Koel
                No: Return invalid credentials
        */

        $credentials = $request->only('email', 'password');

        if( $request->input('wpLoginCheck') ){
            /* 
                check credentials in WordPress
                    hash password. query db to get user whose email matches request->email. if match, then check hashed password
            */
            $wpuser = DB::connection('wordpress')->table('users')->where('user_email', $request->input('email'))->first();
    
            if( $wpuser ){
                $passwordService = new PasswordService();
                if( $passwordService->check($request->input('password'), $wpuser->user_pass) ){
                    // get corresponding koel user based on wp user id
                    $user = User::where('wpid', $wpuser->ID)->get();
                    if( $user->isEmpty() ){
                        return response()->json(['error' => 'wp_user_not_found_in_koel'], 401);    
                    }
                    $token = JWTAuth::fromUser($user->first());
                    return response()->json(compact('token'));
                } else {
                    return response()->json(['error' => 'invalid_wp_credentials'], 401);    
                }
            } else {
                return response()->json(['error' => 'wp_user_not_found'], 401);
            }
        } else {
            try {
                if (!$token = JWTAuth::attempt( $credentials )) {
                    return response()->json(['error' => 'invalid_credentials'], 401);
                }
            } catch (JWTException $e) {
                Log::error($e);

                return response()->json(['error' => 'could_not_create_token'], 500);
            }

            return response()->json(compact('token'));
        }
    }

    /**
     * Log the current user out.
     *
     * @return JsonResponse
     */
    public function logout()
    {
        if ($token = JWTAuth::getToken()) {
            try {
                JWTAuth::invalidate($token);
            } catch (Exception $e) {
                Log::error($e);
            }
        }

        return response()->json();
    }
}
