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
        Schema::table('orders', function (Blueprint $table) {
            $table->foreign(['assigned_to'])->references(['id'])->on('users');
            $table->foreign(['user_id'])->references(['id'])->on('users');
            $table->foreign(['account_id'])->references(['id'])->on('accounts');
            $table->foreign(['customer_id'])->references(['id'])->on('customers');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('orders', function (Blueprint $table) {
            $table->dropForeign('orders_assigned_to_foreign');
            $table->dropForeign('orders_user_id_foreign');
            $table->dropForeign('orders_account_id_foreign');
            $table->dropForeign('orders_customer_id_foreign');
        });
    }
};
