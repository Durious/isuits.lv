<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('orders', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('account_id')->index();
            $table->string('reference');
            $table->date('delivery_date');
            $table->decimal('total', 25, 4);
            $table->string('discount')->nullable();
            $table->decimal('discount_amount', 25, 4)->nullable();
            $table->decimal('tax_amount', 25, 4)->nullable();
            $table->decimal('grand_total', 25, 4);
            $table->string('status')->default('Received');
            $table->tinyInteger('priority')->nullable();
            $table->text('note')->nullable();
            $table->string('hash')->nullable()->index();
            $table->boolean('paid')->nullable()->default(false);
            $table->string('photo_path')->nullable();
            $table->string('transaction_id')->nullable();
            $table->unsignedBigInteger('user_id')->index();
            $table->unsignedBigInteger('customer_id')->index();
            $table->unsignedBigInteger('assigned_to')->nullable()->index();
            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('orders');
    }
};
