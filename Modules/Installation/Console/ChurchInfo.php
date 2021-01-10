<?php

namespace Modules\Installation\Console;

use Illuminate\Console\Command;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Input\InputArgument;
use Modules\Org\Entities\OrgInfo;
use Modules\Church\Entities\ChurchBranch;

class ChurchInfo extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'install:info';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Command description.';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Execute the console command.
     *
     * @return mixed
     */
    public function handle()
    {
        $this->comment("Installing data");

        $data = [
            [ 'code' => 'NAME','type' => 'text', 
            'value_en'=> 'Walta Ethiopia Share Company', 'value_am' => 'ዋልታ ኢትዮጲያ ሼር ድርጅት' ],
            [ 'code' => 'NAME_SHORT','type' => 'text', 
            'value_en'=> 'Walta', 'value_am'=> 'ዋልታ' ],
            // [ 'code' => '','type' => '', 
            // 'value_en'=> '', 'value_am'=> '' ],
            // [ 'code' => '','type' => '', 
            // 'value_en'=> '', 'value_am'=> '' ],
            // [ 'code' => '','type' => '', 
            // 'value_en'=> '', 'value_am'=> '' ],
            // [ 'code' => '','type' => '', 
            // 'value_en'=> '', 'value_am'=> '' ],
            // [ 'code' => '','type' => '', 
            // 'value_en'=> '', 'value_am'=> '' ],

        ];

        foreach ($data as $row) {
            $i = OrgInfo::firstOrNew(['code'=>$row['code']]);
            $i->type = $row['type'];
            $i->value_en = $row['value_en'];
            if (isset($row['value_am'])) {
                $i->value_am = $row['value_am'];
            }
            $i->save();
        }




        




    }

    /**
     * Get the console command arguments.
     *
     * @return array
     */
    protected function getArguments()
    {
        return [
            // ['example', InputArgument::REQUIRED, 'An example argument.'],
        ];
    }

    /**
     * Get the console command options.
     *
     * @return array
     */
    protected function getOptions()
    {
        return [
            ['example', null, InputOption::VALUE_OPTIONAL, 'An example option.', null],
        ];
    }
}
