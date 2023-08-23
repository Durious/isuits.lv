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
        Schema::table('salaries', function (Blueprint $table) {
            $table->foreign(['staff_id'])->references(['id'])->on('users');
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
        Schema::table('salaries', function (Blueprint $table) {
            $table->dropForeign('salaries_staff_id_foreign');
            $table->dropForeign('salaries_account_id_foreign');
            $table->dropForeign('salaries_user_id_foreign');
        });
    }
};
