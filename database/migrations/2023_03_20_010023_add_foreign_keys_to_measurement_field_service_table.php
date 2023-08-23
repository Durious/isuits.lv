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
        Schema::table('measurement_field_service', function (Blueprint $table) {
            $table->foreign(['service_id'])->references(['id'])->on('services');
            $table->foreign(['measurement_field_id'])->references(['id'])->on('measurement_fields')->onDelete('CASCADE');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('measurement_field_service', function (Blueprint $table) {
            $table->dropForeign('measurement_field_service_service_id_foreign');
            $table->dropForeign('measurement_field_service_measurement_field_id_foreign');
        });
    }
};
