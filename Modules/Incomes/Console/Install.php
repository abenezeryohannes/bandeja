<?php

namespace Modules\Incomes\Console;

use Illuminate\Console\Command;
use Modules\Accounts\Database\Seeders\AccountsDatabaseSeeder;
use Modules\Incomes\Database\Seeders\IncomesDatabaseSeeder;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Input\InputArgument;

class install extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'install:incomes';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'installing tenants.';

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
        //
        $this->comment('installing tenants, invoices, revenues...');
        $Seeder = new IncomesDatabaseSeeder();
        $Seeder->run();
    }

    /**
     * Get the console command arguments.
     *
     * @return array
     */
    protected function getArguments()
    {
        return [
            ['example', InputArgument::REQUIRED, 'An example argument.'],
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
