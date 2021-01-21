<?php

namespace Modules\Incomes\Database\Seeders;

use Carbon\Carbon;
use Illuminate\Database\Seeder;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\Request;
use Modules\Accounts\Entities\Category;
use Modules\Accounts\Entities\Transaction;
use Modules\Incomes\Entities\Revenue;
use Modules\Incomes\Entities\Tenant;
use Modules\Incomes\Jobs\Invoice\CreateInvoice;
use Modules\Incomes\Jobs\Revenue\CreateRevenue;

class RevenuesTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Model::unguard();

        $tenants = Tenant::all();
        $categories = Category::where('type', '=', 'income')->get();

        foreach ($tenants as $tenant) {
            $price = rand(100, 3000);
            foreach ($categories as $category) {
                $transaction = Transaction::create([
                    'type'=>'income',
                    'category_id'=>$category->id,
                    'account_id'=>1,
                    'tax_id'=>1,
                    'amount'=>$price,
                    'note'=>'random note',
                    'transaction_date'=>Carbon::now(),
                    'payment_method_id'=>1
                ]);
                Revenue::create([
                    'tenant_id'=>$tenant->id,
                    'category_id'=>$category->id,
                    'price'=>$price,
                    'transaction_id'=>$transaction->id,
                ]);
            }
        }

        // $this->call("OthersTableSeeder");
    }
}
