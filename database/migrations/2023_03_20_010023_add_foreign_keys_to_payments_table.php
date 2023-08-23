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
        Schema::table('payments', function (Blueprint $table) {
            $table->foreign(['customer_id'])->references(['id'])->on('customers');
            $table->foreign(['account_id'])->references(['id'])->on('accounts');
            $table->foreign(['user_id'])->references(['id'])->on('users');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('payments', function (Blueprint $table) {
            $table->dropForeign('payments_customer_id_foreign');
            $table->dropForeign('payments_account_id_foreign');
            $table->dropForeign('payments_user_id_foreign');
        });
    }
};
