<?php

namespace Modules\User\Entities;

use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;

class User extends Authenticatable
{
    use HasFactory, Notifiable;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */

    protected $fillable = [
        'name', 'sex', 'avatar', 'locale',
        'email', 'email_generated', 'phone_number',
        'password', 'password_generated', 
        'role', 'elevated_permissions',


    ];




    public function getPpAttribute()
    {
        if ($this->avatar) {
            return $this->avatar;
        }
        return url('img/user.svg');
        if ($this->sex == "M") {
            return url('img/avatar/male.png');
        }
        return url('img/avatar/female.png');
    }

    protected $appends = ["pp"];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'password',
        'remember_token',
        'password_generated'
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
        'elevated_permissions' => 'array'
    ];
}
