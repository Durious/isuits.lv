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
        Schema::create('customers', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('account_id')->nullable()->index();
            $table->string('name', 100)->index();
            $table->string('email', 50)->nullable();
            $table->string('phone', 50)->nullable()->index();
            $table->string('address')->nullable();
            $table->string('state')->nullable();
            $table->string('photo')->nullable();
            $table->string('password', 255)->nullable();
            $table->string('description')->nullable();
            $table->decimal('opening_balance', 15, 5)->nullable();
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
        Schema::dropIfExists('customers');
    }
};
