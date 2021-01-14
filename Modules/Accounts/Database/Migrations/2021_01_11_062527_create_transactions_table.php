<?php

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateTransactionsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('transactions', function (Blueprint $table) {
            $table->id();
            $table->string('type');
            $table->unsignedBigInteger('category_id');
            $table->unsignedBigInteger('account_id');
            $table->unsignedBigInteger('payment_type_id')->nullable();

            $table->unsignedBigInteger('tax_id')->nullable();

            $table->unsignedBigInteger('transaction_id')->nullable();

            $table->double('amount')->default(0.0);
            $table->timestamp('transaction_date')->default(DB::raw('CURRENT_TIMESTAMP'));

            $table->text('note')->nullable();
            $table->string('attachment')->nullable();
            $table->timestamps();
        });

        Schema::table('transactions', function (Blueprint $table) {
            $table->foreign('category_id')->references('id')->on('categories');
            $table->foreign('account_id')->references('id')->on('accounts');
            $table->foreign('tax_id')->references('id')->on('taxes');

//            $table->foreign('invoice_payment_id')->references('id')->on('invoice_payments');
//            $table->foreign('revenue_id')->references('id')->on('revenues');

//            $table->foreign('bill_payment_id')->references('id')->on('bill_payments');
//            $table->foreign('purchase_id')->references('id')->on('purchases');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('transactions');
    }
}
