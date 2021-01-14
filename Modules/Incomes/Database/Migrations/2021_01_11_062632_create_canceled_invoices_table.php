<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateCanceledInvoicesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('canceled_invoices', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("invoice_id");
            $table->text("reason");
            $table->String("by");
            $table->timestamp("previous_end_date");
            $table->timestamps();
        });

        Schema::table('canceled_invoices', function (Blueprint $table) {
            $table->foreign('invoice_id')->references('id')->on('invoices');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('canceled_invoices');
    }
}
