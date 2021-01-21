<?php

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateBillPaymentsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('bill_payments', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("bill_id");
            $table->timestamp("bill_date")->default(DB::raw('CURRENT_TIMESTAMP'));
            $table->double("price")->default(0);
            $table->unsignedInteger("period")->default(1);
            $table->timestamp('due_date')->default(DB::raw('TIMESTAMPADD(DAY,5,CURRENT_TIMESTAMP)'));
            $table->unsignedBigInteger("transaction_id")->nullable();
            $table->timestamps();
        });

        Schema::table('bill_payments', function (Blueprint $table) {
            $table->foreign('transaction_id')->references('id')->on('transactions');
            $table->foreign('bill_id')->references('id')->on('bills');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('bill_payments');
    }
}
