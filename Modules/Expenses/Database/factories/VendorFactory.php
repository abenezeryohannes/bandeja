<?php
namespace Modules\Expenses\Database\factories;

use Illuminate\Database\Eloquent\Factories\Factory;

class VendorFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = \Modules\Expenses\Entities\Vendor::class;

    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {
        return[
            'name'=>$this->faker->name,
            'vendor_category_id'=>1,//rand(1, 3),
            'phone_number'=>$this->faker->phoneNumber,
            'position'=>$this->faker->jobTitle,
            'postal_address'=>$this->faker->postcode,
            'physical_address'=>$this->faker->address,
            //'tin_number'=>$this->faker->numberBetween(100000000, 999999999),
            'email_address'=>$this->faker->email,
            'bank'=>"CBE",
            'account_number'=>'1000' . rand(100000, 999999)
        ];
    }
}

