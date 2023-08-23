<?php

use App\Models\User;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    public function run()
    {
        factory(User::class)->create([
            'account_id' => '1',
            'owner'      => true,
            'username'   => 'admin',
            'name'       => 'Shop Owner',
            'phone'      => '0123456789',
            'email'      => 'owner@tecdiary.com',
            'salary'     => null,
        ]);
    }
}
