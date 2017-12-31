<?php

namespace App\Providers;

use Laravel\Passport\Passport;
use App\Models\Playlist;
use App\Models\User;
use App\Policies\PlaylistPolicy;
use App\Policies\UserPolicy;
use Illuminate\Foundation\Support\Providers\AuthServiceProvider as ServiceProvider;

class AuthServiceProvider extends ServiceProvider
{
    /**
     * The policy mappings for the application.
     *
     * @var array
     */
    protected $policies = [
        Playlist::class => PlaylistPolicy::class,
        User::class => UserPolicy::class,
    ];

    /**
     * Register any application authentication / authorization services.
     */
    public function boot()
    {
        $this->registerPolicies();

        //
        Passport::routes();
    }
}
