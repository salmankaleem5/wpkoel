<?php

namespace App\Http\Controllers\API\Interaction;

use App\Events\SongStartedPlaying;
use App\Models\Interaction;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

use Illuminate\Support\Facades\DB;

class PlayCountController extends Controller
{
    /**
     * Increase a song's play count as the currently authenticated user.
     *
     * @param Request $request
     *
     * @return JsonResponse
     */
    public function store(Request $request)
    {
        $interaction = Interaction::increasePlayCount($request->song, $request->user());
        if ($interaction) {
            event(new SongStartedPlaying($interaction->song, $interaction->user));
        }

        $this->record_in_play_log( $request->song, $request->user()->id );

        return response()->json($interaction);
    }

    private function record_in_play_log( $song_id, $user_id ){
        DB::table('play_log')->insert([
            'user_id' => $user_id,
            'song_id' => $song_id,
            "created_at" =>  \Carbon\Carbon::now(), # \Datetime()
            "updated_at" => \Carbon\Carbon::now(),  # \Datetime()
        ]);
    }

    public function update(Request $request){
        if( $request->has('songID', 'listenTime') ){
            $interaction = Interaction::where([
                'song_id' => $request->songID,
                'user_id' => $request->user()->id,
            ])->firstOrFail();

            if( $interaction->listen_time == 0 ){
                $interaction->listen_time = $request->listenTime;
            } else {
                $interaction->listen_time = ( $interaction->listen_time + $request->listenTime ) / 2;
            }
            $interaction->save();

            return response()->json( [$interaction, $request->listenTime] );
        }
    }   
}
