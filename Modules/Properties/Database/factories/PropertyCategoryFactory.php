<?php
namespace Modules\Properties\Database\factories;

use Illuminate\Database\Eloquent\Factories\Factory;

class PropertyCategoryFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = \Modules\Properties\Entities\PropertyCategory::class;

    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {
        return [
            "name"=>"Category" . rand(1, 100),
            "description"=>"random discription text",
            "rent_price"=>rand(100, 2000), 
            "sell_price"=>rand(1000000, 4000000),
            'picture' => "{\"files\":[\"public\/2021\/01\/18\/property_category\/placeholder.jpg\"],\"permissions\":[]}",
            "size"=>rand(10, 100) . "sqft", 
        ];
    }
}

