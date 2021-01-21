<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateBillsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('bills', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('vendor_id');
            $table->unsignedBigInteger('category_id');
            $table->unsignedBigInteger('recurring_id');
            $table->unsignedBigInteger('tax_id')->nullable();
            $table->double('price')->default(0);

            $table->timestamp('start_date')->default(DB::raw('CURRENT_TIMESTAMP'));
            $table->timestamp('due_date')->default(DB::raw('TIMESTAMPADD(DAY,5,CURRENT_TIMESTAMP)'));

            $table->string('bill_number')->default("BLL" . rand(1, 9999999999));
            $table->text('note')->nullable();
            $table->string('attachment')->nullable();
            $table->boolean('canceled')->default(false);
            $table->boolean('fixed')->default(true);

            $table->timestamps();
        });

        Schema::table('bills', function (Blueprint $table) {
            $table->foreign('category_id')->references('id')->on('categories');
            $table->foreign('tax_id')->references('id')->on('taxes');
            $table->foreign('recurring_id')->references('id')->on('recurrings');

            $table->foreign('vendor_id')->references('id')->on('vendors');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('bills');
    }
}
