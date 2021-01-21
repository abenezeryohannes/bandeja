<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateBlocksTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('blocks', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("site_id");
            $table->string("name");
            $table->unsignedInteger("floors")->default(1);
            $table->text("address");
            $table->string("picture")->nullable();
            $table->boolean("enabled")->default(true);

            $table->timestamps();
        });
        
        Schema::table('blocks', function(Blueprint $table){
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
        Schema::dropIfExists('blocks');
    }
}
