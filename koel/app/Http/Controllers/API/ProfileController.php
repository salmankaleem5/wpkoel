<?php

namespace App\Http\Controllers\API;

use App\Http\Requests\API\ProfileUpdateRequest;
use Hash;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use RuntimeException;
use GuzzleHttp\Client;
use GuzzleHttp\Psr7;
use GuzzleHttp\Exception\TransferException;

use Illuminate\Support\Facades\Log;

class ProfileController extends Controller
{
    /**
     * Get the current user's profile.
     *
     * @param Request $request
     *
     * @return JsonResponse
     */
    public function show(Request $request)
    {
        return response()->json($request->user());
    }

    /**
     * Update the current user's profile.
     *
     * @param ProfileUpdateRequest $request
     *
     * @throws RuntimeException
     *
     * @return JsonResponse
     */
    public function update(ProfileUpdateRequest $request)
    {
        $data = $request->only('name', 'email');

        if ($request->password) {
            $data['password'] = Hash::make($request->password);
        }

        $this->updateWPUser( $request->user()->wpid, $request );

        return response()->json($request->user()->update($data));
    }

    private function updateWPUser( $wpid, Request $request ){
        $guzzleClient = new Client();
        $formParams = [
            'nickname' => $request->name,
            'name' => $request->name,
            'email' => $request->email,
            'meta' => [
                'koel_email' => $request->email,
            ]
        ];

        try {
            $res = $guzzleClient->request('POST', "http://localhost/wp/wp-json/wp/v2/users/{$wpid}",[
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
}
