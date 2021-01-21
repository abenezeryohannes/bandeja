<?php

namespace Modules\Installation\Console;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\Artisan;
use Modules\Accounts\Database\Seeders\AccountsDatabaseSeeder;
use Modules\Expenses\Database\Seeders\ExpensesDatabaseSeeder;
use Modules\Incomes\Database\Seeders\IncomesDatabaseSeeder;
use Modules\Properties\Database\Seeders\SitesTableSeeder;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Input\InputArgument;

class install extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'install:all';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'installing all modules';

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

        //installing properties
        $this->comment('Installing properties ...');
        //populate sites
        $seeder = new SitesTableSeeder();
        $seeder->run();

        //installing accounts
        $this->comment('installing bank_account, taxes, categories, payment_methods ...');
        $accountSeeder = new AccountsDatabaseSeeder();
        $accountSeeder->run();

        //install incomes
        $this->comment('installing tenants, invoices, revenues...');
        $Seeder = new IncomesDatabaseSeeder();
        $Seeder->run();

        //install expenses
        $this->comment('installing vendors, payments, bills, bill_payments ...');
        $seeder = new ExpensesDatabaseSeeder();
        $seeder->run();
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
