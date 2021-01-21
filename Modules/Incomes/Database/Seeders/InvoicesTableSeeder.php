<?php

namespace Modules\Incomes\Database\Seeders;

use Carbon\Carbon;
use Illuminate\Database\Seeder;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\Request;
use Modules\Accounts\Entities\Category;
use Modules\Accounts\Entities\Tax;
use Modules\Incomes\Entities\Invoice;
use Modules\Incomes\Entities\Tenant;
use Modules\Incomes\Jobs\Invoice\CreateInvoice;
use Modules\Properties\Entities\Property;

class InvoicesTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Model::unguard();
        $request = new Request();
        $tenants = Tenant::all();
        $properties = Property::all();
        $category = Category::where('id','>', 0)->first();
        $tax = Tax::where('id','>', 0)->first();



        $prop = null;
        foreach ($tenants as $tenant) {

            $prop = Property::whereDate("available_after", "<", Carbon::now())
                            ->orWhereDate('available_after', '=', Carbon::now())->first();
            if($prop == null) break;
                $price = rand(100, 3000);
                $request['tenant_id'] = $tenant->id;
                $request['category_id'] = ($category!=null)?$category->id:null;
                $request['property_id'] = $prop->id;
                $request['tax_id'] = ($tax!=null)?$tax->id:null;
                $request['start_date'] = Carbon::now();
                $request['end_date'] = Carbon::now()->addYear();
                $request['due_date'] = Carbon::now()->addDays(5);
                $request['invoice_number'] = "INV" . (rand(100000,942442));
                $request['note'] = "Random note";
                $request['price'] = $price;
                Invoice::create($request->all());
                $prop->update(["available_after"=>$request['end_date']]);
        }

        // $this->call("OthersTableSeeder");
    }
}
