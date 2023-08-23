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
        Schema::create('users', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('account_id')->index();
            $table->string('name', 50);
            $table->string('phone', 50)->index();
            $table->string('email', 50)->unique();
            $table->string('username', 25)->unique();
            $table->string('password')->nullable();
            $table->boolean('owner')->default(false);
            $table->decimal('salary', 25, 4)->nullable();
            $table->string('photo_path')->nullable();
            $table->boolean('can_sms')->nullable()->default(false);
            $table->boolean('view_all')->nullable()->default(false);
            $table->boolean('edit_all')->nullable()->default(false);
            $table->rememberToken();
            $table->timestamps();
            $table->softDeletes();
            $table->boolean('active')->nullable()->default(true);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('users');
    }
};
