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
        Schema::table('order_services', function (Blueprint $table) {
            $table->foreign(['order_id'])->references(['id'])->on('orders')->onDelete('CASCADE');
            $table->foreign(['measurement_id'])->references(['id'])->on('measurements');
            $table->foreign(['service_id'])->references(['id'])->on('services');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('order_services', function (Blueprint $table) {
            $table->dropForeign('order_services_order_id_foreign');
            $table->dropForeign('order_services_measurement_id_foreign');
            $table->dropForeign('order_services_service_id_foreign');
        });
    }
};
