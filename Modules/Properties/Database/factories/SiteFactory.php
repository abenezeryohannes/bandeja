<?php
namespace Modules\Properties\Database\factories;

use Illuminate\Database\Eloquent\Factories\Factory;

class SiteFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = \Modules\Properties\Entities\Site::class;

    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {
        return [
            'name' => $this->faker->city,
            'address' => $this->faker->address,
            'picture' => "picture" . rand(1, 10) . ".jpg",
            'enabled' => rand(1, 2) == 1? 1:0,
        ];
    }
}

