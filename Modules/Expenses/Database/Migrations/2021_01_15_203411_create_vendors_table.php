<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateVendorsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('vendors', function (Blueprint $table) {
            $table->id();
            $table->string("name");
            $table->unsignedBigInteger('vendor_category_id')->nullable();
            $table->string('phone_number')->nullable();
            $table->string('position')->nullable();
            $table->string('postal_address')->nullable();
            $table->text('physical_address')->nullable();
            $table->string('email_address')->nullable();
            $table->string('tin_number')->nullable();
            $table->string('memo')->nullable();
            $table->string('bank')->nullable();
            $table->string('account_number')->nullable();
            $table->boolean('enabled')->default(true);
            $table->timestamps();
        });

        Schema::table('vendors', function (Blueprint $table) {
            $table->foreign('vendor_category_id')->references('id')->on('vendor_categories');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('vendors');
    }
}
