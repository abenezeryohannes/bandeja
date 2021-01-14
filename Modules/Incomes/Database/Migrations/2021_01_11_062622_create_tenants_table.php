<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateTenantsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('tenants', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('type')->default('ordinary');
            $table->string('phone_number')->nullable();
            $table->string('business_type')->nullable();
            $table->string('postal_address')->nullable();
            $table->text('physical_address')->nullable();
            $table->string('email_address')->nullable();
            $table->string('tin_number')->nullable();
            $table->string('memo')->nullable();
            $table->boolean('enabled')->default(true);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('tenants');
    }
}
