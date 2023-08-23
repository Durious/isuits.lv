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
        Schema::create('taxes', function (Blueprint $table) {
            $table->increments('id');
            $table->unsignedBigInteger('account_id')->index();
            $table->string('name');
            $table->string('code', 20)->unique();
            $table->decimal('rate')->nullable();
            $table->text('description')->nullable();
            $table->boolean('state')->nullable();
            $table->boolean('same')->nullable();
            $table->boolean('compound')->nullable();
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
        Schema::dropIfExists('taxes');
    }
};
