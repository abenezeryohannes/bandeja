<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreatePropertiesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('properties', function (Blueprint $table) {
            $table->id();
            $table->string("name");
            $table->boolean("inside_block")->default(true);
            $table->unsignedBigInteger("site_id")->nullable();
            $table->unsignedBigInteger("block_id")->nullable();
            $table->unsignedBigInteger("property_category_id");
            $table->unsignedInteger("floor")->nullable();
            $table->text("address")->nullable();
            $table->timestamp("available_after")->default(DB::raw('CURRENT_TIMESTAMP'));
            $table->boolean("enabled")->default(true);

            $table->timestamps();
        });


        Schema::table('properties', function(Blueprint $table){
            $table->foreign('block_id')->references('id')->on('blocks');
            $table->foreign('property_category_id')->references('id')->on('property_categories');
            $table->foreign('site_id')->references('id')->on('sites');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('properties');
    }
}
