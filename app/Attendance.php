<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Attendance extends Model
{    
	public $incrementing = false; 
	public $timestamps = false;
	protected $casts = [
		'date' => 'datetime:Y-m-d',
		'checkin_at' => 'datetime:H-i-s',		
		'checkout_at' => 'datetime:H-i-s',		
	];

	public function attendanceType()
    {        
		return $this->belongsTo('App\AttendanceType','type');
    }
	
	public function user()
    {
        return $this->belongsTo('App\User','nrp');
    }
}