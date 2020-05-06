<?php

namespace App\Http\Middleware;

use Closure;
use Auth;

class CheckLastLogin
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next)
    {
		if(Auth()->user()->last_login_at == null){
			return redirect('/reset-password');
		}
        return $next($request);
    }
}
