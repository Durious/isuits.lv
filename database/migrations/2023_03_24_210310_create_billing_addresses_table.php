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
        Schema::create('billing_addresses', function (Blueprint $table) {
            $table->id();
            $table->string('fname');
            $table->string('lname');
            $table->string('country');
            $table->string('state');
            $table->string('address');
            $table->string('city');
            $table->string('zipcode');
            $table->string('vatcode');
            $table->string('fiscalcode');
            $table->string('recipientcode');
            $table->string('taxcode');
            $table->string('certified_email');
            $table->string('other')->nullable();
            $table->integer('customer_id');
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
        Schema::dropIfExists('billing_addressses');
    }
};
