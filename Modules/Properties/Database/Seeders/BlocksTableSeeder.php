<?php

namespace Modules\Properties\Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Database\Eloquent\Model;
use Modules\Properties\Entities\Block;
use Modules\Properties\Entities\Site;

class BlocksTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Model::unguard();
        $sites = Site::all();
        $count = 0;
        foreach($sites as $site){
            for($i=1;$i<=3;$i++){
                $count++;
                Block::create([
                    "site_id"=>$site->id, 
                    "name"=>"Block ". $count, 
                    "floors"=>1,
                    'picture' => "{\"files\":[\"public\/2021\/01\/18\/property_category\/placeholder.jpg\"],\"permissions\":[]}",
                    "address"=> "Random address " . $count,
                    ]);
            }
        }
        
        //$this->call("OthersTableSeeder");
    }
}
