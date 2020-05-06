<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Session extends Model
{   
	public $incrementing = false; 
	 protected $casts = [        
        'last_activity' => 'datetime:Y-m-d H:i:s',
    ];
	
	public function user(){
        return $this->belongsTo('App\User','user_id','nrp');
    }
}