<?php

namespace Modules\Installation\Console;

use Illuminate\Console\Command;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Input\InputArgument;
use Modules\User\Entities\User;
use Modules\Church\Entities\ChurchBranch;
use Modules\HR\Entities\JobPosition;
use Modules\HR\Entities\EmploymentHistory;

use Illuminate\Support\Facades\Hash;
use Carbon\Carbon;
class Users extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'install:users';

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
        $this->comment('Installing users ...');

        
        
        $users = [
            [ 'name' => 'Admin', 'sex' => 'M', 'locale' => 'en', 'email' => 'admin@company.com', 'role' => 'admin'  ]
        ];

        $faker = \Faker\Factory::create();
        $domain = "gmail.com";

        foreach ($users as $user) {
            # code...
            do{
                $email_generated = $faker->lexify('?????@'.$domain);
            }while(User::where('email_generated', $email_generated)->first());
            $password_generated = $faker->lexify('??????');
            $password = Hash::make($password_generated);

            $email = $user['email'] ?? null;
            if ($email) {
                $u = User::firstOrNew(['email'  => $email]);
                $u->name = $user['name'];
            }else{
                $u = User::firstOrNew(['name'  => $user['name']]);
            }
            $u->sex = $user['sex'];
            $u->locale = $user['locale'];
            $u->email_generated = $email_generated;
            $u->password = $password;
            $u->password_generated = $password_generated;
            $u->role  = $user['role'];
            $u->save();



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
