<?php

namespace App\Http\Controllers\API;

/*use App\Http\Requests\API\UserStoreRequest;
use App\Http\Requests\API\UserUpdateRequest;*/
use Illuminate\Http\Request;
use App\Models\User;
use Exception;
use Hash;
use Illuminate\Auth\Access\AuthorizationException;
use Illuminate\Http\JsonResponse;
use RuntimeException;

class APIUserController extends Controller {
	public function store(Request $request){
        // User was created in WordPress, make corresponding account in Koel
        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
        ]);

        // Store WordPress ID with Koel user
        $user->wpid = $request->input('wpid');
        $user->save();

        return response()->json($user);
	}

    public function update(Request $request, $id)
    {
    	// find user based on provided wp id
        $user = User::where('wpid', $id)->first();

        if( $request->has('name') ){
            $data = $request->only('name');
        }

        if( $request->has('email') ){
            $data = $request->only('email');
        }

        return response()->json($user->update($data));
        
    }

    public function destroy(Request $request, $id)
    {
    	// find user based on provided wp id
        $user = User::where('wpid', $id)->first();
        return response()->json($user->delete());
    }
}