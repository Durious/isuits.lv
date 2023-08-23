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
        Schema::table('frontend_settings', function (Blueprint $table) {
            $table->text('limited')->nullable();
            $table->text('discount')->nullable();
            $table->text('embrace')->nullable();
            $table->text('testimonial')->nullable();
            $table->text('service')->nullable();
            $table->text('subscribe')->nullable();
            $table->text('instagram')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('frontend_settings', function (Blueprint $table) {
            $table->dropColumn('limited');
            $table->dropColumn('discount');
            $table->dropColumn('embrace');
            $table->dropColumn('testimonial');
            $table->dropColumn('service');
            $table->dropColumn('subscribe');
            $table->dropColumn('instagram');
        });
    }
};
