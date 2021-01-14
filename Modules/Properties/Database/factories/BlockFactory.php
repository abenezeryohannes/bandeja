<?php
namespace Modules\Properties\Database\factories;

/** @var Factory $factory */

use Illuminate\Database\Eloquent\Factory;
use Illuminate\Support\Str;
use Faker\Generator as Faker;
use \Modules\Properties\Entities\Block;

$factory->define(Block::class, function (Faker $faker) {
    return [
        'phone_number' => $faker->phoneNumber,
        'first_name' => $faker->name,
        'sex' => rand(1, 2) == 1? "Man":"Woman",
        'facebook' => Str::random(20),
        'instagram' => Str::random(20),
        'email_verified_at' => now(),
        'password' => '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', // password
        'remember_token' => Str::random(10),
        'email' =>  $faker->unique()->email ,
    ];
});
