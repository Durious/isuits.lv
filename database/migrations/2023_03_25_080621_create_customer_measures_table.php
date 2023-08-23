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
        Schema::create('customer_measures', function (Blueprint $table) {
            $table->id();
            $table->integer('customer_id');
            $table->date('dob');
            $table->double('height');
            $table->double('weight');
            $table->double('chest');
            $table->double('neck');
            $table->double('shoulder');
            $table->double('back_length');
            $table->double('arm_length');
            $table->double('biceps');
            $table->double('wrist');
            $table->double('stomach');
            $table->double('waistline');
            $table->double('hip');
            $table->double('inside_length');
            $table->double('thigh');
            $table->enum('shoulder_type', ['high', 'regular', 'low'])->default('regular');
            $table->enum('chest_type', ['chiselled', 'regular', 'robust'])->default('regular');
            $table->enum('stomach_type', ['flat', 'regular', 'protruding'])->default('regular');
            $table->enum('back_type', ['straight', 'regular', 'curved'])->default('regular');
            $table->enum('rear_type', ['flat', 'regular', 'protruding'])->default('regular');
            $table->enum('fit', ['comfort', 'regular', 'slim'])->default('slim');
            $table->softDeletes();
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
        Schema::dropIfExists('customer_measures');
    }
};
