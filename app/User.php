<?php

namespace App;

use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;

class User extends Authenticatable
{
    use Notifiable;
	
	public $incrementing = false; 	
	protected $primaryKey = 'nrp';

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'nrp', 'nip', 'email', 'nama', 'password', 'phone_number', 'kode_unit_kerja', 'kode_induk', 'nama_unit_kerja', 'nama_induk', 'kode_kanwil', 'nama_kanwil', 'kode_jabatan', 'nama_jabatan', 'kode_grade', 'grade', 'is_approver', 'timezone', 'image_path', 'role_id', 'status',
    ];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'password', 'remember_token', 'reset_password_token',
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
		'created_at' => 'datetime:Y-m-d H:i:s',
		'updated_at' => 'datetime:Y-m-d H:i:s',
    ];
	
	public function role()
    {
        return $this->belongsTo('App\Role');
    }
	
	public function timezone()
    {
        return $this->belongsTo('App\Timezone');
    }
	
	public function creator(){
        return $this->belongsTo('App\User','created_by', 'nrp');
    }

    public function editor(){
        return $this->belongsTo('App\User','updated_by', 'nrp');
    }
}
