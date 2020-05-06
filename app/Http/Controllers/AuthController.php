<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Carbon\Carbon;
use App\User;
use Auth;

class AuthController extends Controller
{
  public function getLogin()
  {	  
    return view('auth/login');
  }

  public function postLogin(Request $request)
  {

      // Validate the form data
    $this->validate($request, [
      'nip' => 'required',
      'password' => 'required|min:8'
    ]);

      // Attempt to log the user in
      // Passwordnya pake bcrypt
    if (Auth()->attempt(['nip' => $request->nip, 'password' => $request->password])) {		
		return redirect()->intended(Auth()->user()->last_login_at ? '/home' : '/reset-password');	  
    }else{
		return redirect('/login')->withErrors(['<b>Login Gagal!</b>','User atau Password Tidak Terdaftar']);
	}	
  }

  public function logout()
  {
    Auth()->logout();

    return redirect('/login');

  }
  
  public function getResetPassword()
  {	 
	if(Auth()->user()->last_login_at){
		$userId = Auth::id();
		$user = User::findOrFail($userId);		
		$user->last_login_at = Carbon::now();
		$user->last_login_ip = \Request::ip();
		$user->last_login_ua = \Request::header('user-agent');
		$user->save();	
		return redirect('/home');		
	}else{
		return view('auth/reset-password');
	}
  }
  
  public function postResetPassword(Request $request)
  {
	$this->validate($request, [
	  'password'=>'required|confirmed|min:8',
      'password_confirmation'=>'',
	]);	
			
	$userId = Auth::id();
    $user = User::findOrFail($userId);
	$user->password = Hash::make($request->password);
	$user->last_login_at = Carbon::now();
	$user->last_login_ip = $request->ip();
	$user->last_login_ua = $request->header('user-agent');
	$user->save();	
	return redirect('/home');
  }
}