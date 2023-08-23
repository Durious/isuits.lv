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
        Schema::create('accounts', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->string('name', 50);
            $table->string('phone', 50)->index();
            $table->string('email', 50)->nullable();
            $table->string('address')->nullable();
            $table->string('header')->nullable();
            $table->string('footer')->nullable();
            $table->string('state')->nullable();
            $table->string('per_page')->default('10');
            $table->string('logo_path')->nullable();
            $table->string('gateways')->nullable();
            $table->boolean('notifications')->nullable();
            $table->boolean('email_enabled')->nullable();
            $table->boolean('sms_enabled')->nullable();
            $table->unsignedInteger('default_tax')->nullable();
            $table->timestamps();
            $table->boolean('stripe')->nullable();
            $table->boolean('payu')->nullable();
            $table->string('language', 2)->default('en');
            $table->string('direction', 3)->default('ltr');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('accounts');
    }
};
