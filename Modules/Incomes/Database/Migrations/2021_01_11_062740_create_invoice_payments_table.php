<?php

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateInvoicePaymentsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('invoice_payments', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('invoice_id');
            $table->unsignedBigInteger('transaction_id')->nullable();

            $table->unsignedInteger('period')->default(1);;
            $table->double('price')->default(0);

            $table->timestamp('due_date');
            $table->timestamp('invoice_date');
            $table->string('status')->default("waiting");
            
            $table->timestamps();
        });

        Schema::table('invoice_payments', function (Blueprint $table) {
            $table->foreign('transaction_id')->references('id')->on('transactions');
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
        Schema::dropIfExists('invoice_payments');
    }

}
