<?php

namespace App\Http\Middleware;

use Closure;
use GuzzleHttp\Client;
use Illuminate\Http\JsonResponse;

use GuzzleHttp\Psr7;
use GuzzleHttp\Exception\TransferException;

use Illuminate\Support\Facades\Log;

class WPUserMirror
{
    private $guzzleClient;
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next)
    {
        $requestInfo = $request->route()->action['as'];
        
        $this->guzzleClient = new Client();

        if( strpos($requestInfo, 'store') !== FALSE ){
            $request = $this->storeUser( $request );
        } else if( strpos($requestInfo, 'update') !== FALSE ){
            $request = $this->updateUser( $request );
        } else if( strpos($requestInfo, 'destroy') !== FALSE ){
            $request = $this->destroyUser( $request );
        }

        return $next($request);
    }

    private function storeUser($request){
        // Create corresponding WordPress user
        try {
            $res = $this->guzzleClient->request('POST', 'http://localhost/wp/wp-json/wp/v2/users', [
                'headers' => [
                    'Authorization' => 'Basic ' . base64_encode( 'salman' . ':' . 'test' ),
                    'Cache-Control' => 'no-cache',
                    "Content-Type" => "application/x-www-form-urlencoded",
                    "Accept" => 'application/json',
                ],
                'form_params' => [
                    'username' => $request->name,
                    'email' => $request->email,
                    'password' => $request->password,
                    'url' => "http://koel.com",
                    'meta' => [
                        'created_from_koel' => true,
                        'koel_email' => $request->email,
                    ]
                ]
            ]);
            
            Log::info('WP Create User', ['response' => $res->getBody()]);

            $body = json_decode($res->getBody(), true);

            $request->merge([
                'wpid' => $body['id'],
            ]);
        } catch (TransferException $e) {
            Log::info('WP Create User', ['error' => $e]);  
            return $request;
        }

        return $request;
    }

    private function updateUser($request){
        $userInfo = $request->route()->parameters['user'];

        if( $userInfo['wpid'] != NULL ){

            $formParams = [
                'nickname' => $request->name,
                'name' => $request->name,
                'email' => $request->email,
                'meta' => [
                    'koel_email' => $request->email,
                ]
            ];

            try {
                $res = $this->guzzleClient->request('POST', "http://localhost/wp/wp-json/wp/v2/users/{$userInfo['wpid']}",[
                    'headers' => [
                        'Authorization' => 'Basic ' . base64_encode( 'salman' . ':' . 'test' ),
                        'Cache-Control' => 'no-cache',
                        "Content-Type" => "application/x-www-form-urlencoded",
                    ],
                    'form_params' => $formParams
                ]);
                Log::info('WP Update User', ['response' => $res->getBody()]);
            } catch (TransferException $e) {
                Log::info('WP Update User', ['error' => $e]);  
                return $request;
            }
        }

        return $request;
    }

    private function destroyUser($request){
        $userInfo = $request->route()->parameters['user'];

        if( $userInfo['wpid'] != NULL ){
            try {
                $res = $this->guzzleClient->request('DELETE', "http://localhost/wp/wp-json/wp/v2/users/{$userInfo['wpid']}",[
                    'headers' => [
                        'Authorization' => 'Basic ' . base64_encode( 'salman' . ':' . 'test' ),
                        'Cache-Control' => 'no-cache',
                        "Content-Type" => "application/x-www-form-urlencoded",
                    ],
                    'form_params' => [
                        'force' => true,
                        'reassign' => 1,
                    ]
                ]);
                Log::info('WP DELETE User', ['response' => $res->getBody()]);   
            } catch (TransferException $e) {
                Log::info('WP DELETE User', ['error' => $e]);   
                return $request;
            }     
        }

        return $request;
    }
}
