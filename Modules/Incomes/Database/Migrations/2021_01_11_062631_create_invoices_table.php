<?php

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateInvoicesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('invoices', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('tenant_id');
            $table->unsignedBigInteger('category_id');
            $table->unsignedBigInteger('property_id');
            $table->unsignedBigInteger('tax_id')->nullable();
            $table->double('price')->default(0);

            $table->timestamp('start_date')->default(DB::raw('CURRENT_TIMESTAMP'));
            $table->timestamp('end_date')->default(DB::raw('TIMESTAMPADD(YEAR,1,CURRENT_TIMESTAMP)'));
            $table->timestamp('due_date')->default(DB::raw('TIMESTAMPADD(DAY,5,CURRENT_TIMESTAMP)'));

            $table->string('invoice_number')->default("INV" . rand(10000, 99999));
            $table->unsignedBigInteger('renewed_invoice_id')->nullable();
            $table->text('note')->nullable();
            $table->string('attachment1')->nullable();
            $table->boolean('canceled')->default(false);
            $table->string('attachment2')->nullable();
            $table->string('attachment3')->nullable();

            $table->timestamps();
        });

        Schema::table('invoices', function (Blueprint $table) {
            $table->foreign('category_id')->references('id')->on('categories');
            $table->foreign('tax_id')->references('id')->on('taxes');
            $table->foreign('renewed_invoice_id')->references('id')->on('invoices');

            $table->foreign('tenant_id')->references('id')->on('tenants');
            $table->foreign('property_id')->references('id')->on('properties');
          });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('invoices');
    }
}
