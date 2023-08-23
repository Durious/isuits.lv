<?php

namespace App\Http\Controllers;

use Inertia\Inertia;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class ProfileController extends Controller
{
    public function changePassword(Request $request)
    {
        $user = $request->user();
        $request->validate([
            'current'  => 'required|max:50',
            'password' => 'required|string|min:8|max:50|confirmed',
        ]);

        if (demo() && $user->isDemoUser()) {
            return back()->with('error', 'Changing the password of demo user is not allowed.');
        }

        if (!(Hash::check($request->get('current'), $user->password))) {
            return back()->with('error', 'Please provide correct current password.');
        }

        if ($request->get('password')) {
            $user->update(['password' => Hash::make($request->get('password'))]);
        }

        return back()->with('success', 'Your password has been successfully changed.');
    }

    public function edit()
    {
        $user = auth()->user();
        return Inertia::render('Profile/Edit', [
            'profile' => [
                'id'       => $user->id,
                'name'     => $user->name,
                'phone'    => $user->phone,
                'username' => $user->username,
                'email'    => $user->email,
                'photo'    => $user->photoUrl(['w' => 60, 'h' => 60, 'fit' => 'crop']),
            ],
        ]);
    }

    public function password()
    {
        $user = auth()->user();
        return Inertia::render('Profile/Password', [
            'profile' => [
                'id'    => $user->id,
                'name'  => $user->name,
                'phone' => $user->phone,
                'photo' => $user->photoUrl(['w' => 60, 'h' => 60, 'fit' => 'crop']),
            ],
        ]);
    }

    public function update(Request $request)
    {
        $user = $request->user();
        $request->validate([
            'photo'    => 'nullable|image',
            'name'     => 'required|max:50',
            'phone'    => 'required|max:50',
            'email'    => 'required|max:50|email|unique:users,email,' . $user->id,
            'username' => 'required|max:25|alpha_dash|unique:users,username,' . $user->id,
        ]);

        if (demo() && $user->isDemoUser()) {
            return back()->with('error', 'Updating the demo user is not allowed.');
        }

        $user->update($request->only('name', 'phone', 'email', 'username'));

        if ($request->file('photo')) {
            $user->update(['photo_path' => $request->file('photo')->store('avatars', 'storage')]);
        }

        return back()->with('success', 'Profile has been successfully updated.');
    }
}
