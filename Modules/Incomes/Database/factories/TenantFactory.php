<?php
namespace Modules\Incomes\Database\factories;

use Illuminate\Database\Eloquent\Factories\Factory;

class TenantsFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = \Modules\Incomes\Entities\Tenant::class;

    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {
        return [
            'name'=>$this->faker->company,
            'type'=>rand(0, 1)==0?"Private Company":"Government institution" ,
            'phone_number'=>$this->faker->phoneNumber,
            'business_type'=>$this->faker->jobTitle,
            'postal_address'=>$this->faker->postcode,
            'physical_address'=>$this->faker->address,
            'email_address'=>$this->faker->companyEmail,
            'tin_number'=>$this->faker->creditCardNumber,
        ];
    }
}

