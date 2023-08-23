<?php

namespace Database\Factories;

use App\Models\User;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Hash;
use Illuminate\Database\Eloquent\Factories\Factory;

class UserFactory extends Factory
{
    protected $model = User::class;

    public function definition()
    {
        $email = $this->faker->unique()->safeEmail;

        list($username, $domain) = explode('@', $email);

        return [
            'active'         => true,
            'owner'          => false,
            'email'          => $email,
            'username'       => $username,
            'remember_token' => Str::random(10),
            'password'       => Hash::make('12345678'),
            'phone'          => $this->faker->e164PhoneNumber,
            'salary'         => $this->faker->numberBetween(800, 1800),
            'name'           => $this->faker->firstName . ' ' . $this->faker->lastName,
            // 'photo_path'     => $this->faker->image(storage_path('app/users'), $width = 640, $height = 480),
        ];
    }
}
