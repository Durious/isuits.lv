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
        Schema::create('measurement_field_service', function (Blueprint $table) {
            $table->unsignedBigInteger('service_id')->index();
            $table->unsignedBigInteger('measurement_field_id')->index();
            $table->primary(['service_id', 'measurement_field_id']);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('measurement_field_service');
    }
};
