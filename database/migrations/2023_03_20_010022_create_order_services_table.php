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
        Schema::create('order_services', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->string('code');
            $table->string('name');
            $table->decimal('qty', 15, 4);
            $table->decimal('price', 25, 4);
            $table->decimal('amount', 25, 4);
            $table->unsignedBigInteger('measurement_id')->index('order_services_measurement_id_foreign');
            $table->unsignedBigInteger('order_id')->index();
            $table->unsignedBigInteger('service_id')->index();
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
        Schema::dropIfExists('order_services');
    }
};
