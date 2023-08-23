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
        Schema::create('order_tax', function (Blueprint $table) {
            $table->unsignedInteger('tax_id');
            $table->unsignedBigInteger('order_id')->index();
            $table->decimal('amount', 15, 4)->nullable();
            $table->decimal('total_amount', 15, 4)->nullable();
            $table->decimal('calculated_on', 15, 4)->nullable();

            $table->index(['tax_id', 'order_id']);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('order_tax');
    }
};
