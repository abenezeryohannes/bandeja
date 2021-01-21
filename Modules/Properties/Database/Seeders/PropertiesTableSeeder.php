<?php

namespace Modules\Properties\Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Database\Eloquent\Model;

use Modules\Properties\Entities\Block;
use Modules\Properties\Entities\Property;
use Modules\Properties\Entities\PropertyCategory;
class PropertiesTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Model::unguard();
        $blocks = Block::all();
        $categories = PropertyCategory::all();
        $floors = 1;
        foreach($blocks as $block){
            $count = 0;
            for($i=1;$i<=$floors;$i++){
                foreach($categories as $category){
                    $count++;
                    Property::create([
                        "name"=>$block->site()->first()->name . " " . $block->name.  " Property ". $count,
                        "inside_block"=>true, 
                        "site_id"=>$block->site_id, 
                        "block_id"=>$block->id, 
                        "property_category_id"=>$category->id,
                        "floor"=>rand(1,$floors),
                        ]);
                }
            }
        }
        // $this->call("OthersTableSeeder");
    }
}
