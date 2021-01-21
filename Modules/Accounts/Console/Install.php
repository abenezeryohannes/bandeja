<?php

namespace Modules\Accounts\Console;

use Database\Seeders\DatabaseSeeder;
use Illuminate\Console\Command;
use Modules\Accounts\Database\Seeders\AccountsDatabaseSeeder;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Input\InputArgument;

class install extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'install:accounts';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'adding sample bank account, taxes, categories, payment methods';

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
        $this->comment('installing bank_account, taxes, categories, payment_methods ...');
        $accountSeeder = new AccountsDatabaseSeeder();
        $accountSeeder->run();
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
