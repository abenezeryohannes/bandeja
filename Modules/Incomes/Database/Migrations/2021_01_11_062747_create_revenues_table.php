<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateRevenuesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('revenues', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('tenant_id');
            $table->unsignedBigInteger('category_id');
            $table->unsignedBigInteger('transaction_id')->nullable();


            $table->double('price')->default(0);
            $table->double('discount')->default(0);

            $table->string('status')->default("waiting");
            $table->boolean('enabled')->default(true);

            $table->timestamps();
        });

        Schema::table('revenues', function (Blueprint $table) {
            $table->foreign('category_id')->references('id')->on('categories');

            $table->foreign('transaction_id')->references('id')->on('transactions');

            $table->foreign('tenant_id')->references('id')->on('tenants');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('revenues');
    }
}
