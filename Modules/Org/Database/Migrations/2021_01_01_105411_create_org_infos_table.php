<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateOrgInfosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('org_infos', function (Blueprint $table) {
            $table->id();

            
            $table->string('code')->unique();
            $table->string('value_en');
            $table->string('value_am')->nullable();
            $table->string('type')->default('text');


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
        Schema::dropIfExists('org_infos');
    }
}
