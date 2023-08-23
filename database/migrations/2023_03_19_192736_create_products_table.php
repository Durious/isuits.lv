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
        Schema::create('products', function (Blueprint $table) {
            $table->increments('id');
            $table->string('name');
            $table->integer('category_id');
            $table->text('description')->nullable();
            $table->string('main_photo')->nullable();
            $table->text('sub_photos')->nullable();
            $table->integer('price')->default(0);
            $table->string('small_burst')->default('');
            $table->string('small_waist')->default('');
            $table->string('small_hips')->default('');
            $table->string('medium_burst')->default('');
            $table->string('medium_waist')->default('');
            $table->string('medium_hips')->default('');
            $table->string('large_burst')->default('');
            $table->string('large_waist')->default('');
            $table->string('large_hips')->default('');
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
        Schema::dropIfExists('products');
    }
};
