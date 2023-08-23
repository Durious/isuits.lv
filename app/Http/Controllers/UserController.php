<?php

namespace App\Http\Controllers;

use App\Models\User;
use Inertia\Inertia;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;
use Illuminate\Support\Facades\Hash;
use App\Http\Resources\UserCollection;

class UserController extends Controller
{
    public function create()
    {
        return Inertia::render('Users/Create');
    }

    public function delete(User $user)
    {
        if (demo() && $user->isDemoUser()) {
            return back()->with('error', __('This actions is not allowed on the demo.'));
        }

        if ($user->id == auth()->id()) {
            return back()->with('error', __('You can not delete your own account.'));
        }
        $user->forceDelete();
        return redirect()->to('/users')->with('success', __('model_deleted', ['model' => __choice('User', 1)]));
    }

    public function destroy(User $user)
    {
        if ($user->orders()->exists() || $user->assignedTo()->exists()) {
            return back()->with('error', __('model_can_not_deleted', ['model' => __choice('User', 1), 'data' => __choice('Order', 2)]));
        }
        if (demo() && $user->isDemoUser()) {
            return back()->with('error', __('This actions is not allowed on the demo.'));
        }

        if ($user->id == auth()->id()) {
            return back()->with('error', __('You can not delete your own account.'));
        }
        log_activity('Deleting the user', ['user' => $user], $user);
        $user->delete();
        return back()->with('success', __('model_deleted', ['model' => __choice('User', 1)]));
    }

    public function edit(User $user)
    {
        return Inertia::render('Users/Edit', [
            'edit' => [
                'id'         => $user->id,
                'name'       => $user->name,
                'email'      => $user->email,
                'phone'      => $user->phone,
                'owner'      => $user->owner,
                'active'     => $user->active,
                'salary'     => $user->salary,
                'can_sms'    => $user->can_sms,
                'view_all'   => $user->view_all,
                'edit_all'   => $user->edit_all,
                'username'   => $user->username,
                'deleted_at' => $user->deleted_at,
                'photo'      => $user->photoUrl(['w' => 60, 'h' => 60, 'fit' => 'crop']),
            ],
        ]);
    }

    public function form(Request $request, $user = null)
    {
        return $request->validate([
            'phone'    => ['required'],
            'photo'    => ['nullable', 'image'],
            'name'     => ['required', 'max:50'],
            'owner'    => ['required', 'boolean'],
            'salary'   => ['nullable', 'numeric'],
            'active'   => ['nullable', 'boolean'],
            'can_sms'  => ['nullable', 'boolean'],
            'view_all' => ['nullable', 'boolean'],
            'edit_all' => ['nullable', 'boolean'],
            'password' => [$user ? 'nullable' : 'required', 'min:8'],
            'username' => ['required', 'max:25', 'regex:/^[\w\-_.]*$/'],
            'email'    => ['required', 'max:50', 'email', $user ? Rule::unique('users')->ignore($user->id) : 'unique:users'],
        ]);
    }

    public function index(Request $request)
    {
        $filters = $request->all('search', 'role', 'trashed');
        return Inertia::render('Users/Index', [
            'filters'   => $filters,
            'users'     => new UserCollection(
                User::filter($filters)->orderBy('name')->paginate()->withQueryString()
            ),
        ]);
        // 'photo'      => $user->photoUrl(['w' => 40, 'h' => 40, 'fit' => 'crop']),
    }

    public function restore(User $user)
    {
        $user->restore();
        log_activity('Restoring the user', ['user' => $user], $user);
        return back()->with('success', __('model_restored', ['model' => __choice('User', 1)]));
    }

    public function store(Request $request)
    {
        $v = $this->form($request);
        if ($request->file('photo')) {
            $v['photo_path'] = $request->file('photo')->store('users');
        }
        $passeord = $v['password'];
        $v['password'] = Hash::make($passeord);
        $user = User::create($v);
        log_activity('Added new user', ['user' => $user], $user);
        if (notDemo()) {
            $user->notify(new \App\Notifications\UserCreated($user, $passeord));
        }
        return redirect()->route('users')->with('success', __('model_created', ['model' => __choice('User', 1)]));
    }

    public function update(Request $request, User $user)
    {
        if (demo() && $user->isDemoUser()) {
            return back()->with('error', 'Updating the demo user is not allowed.');
        }

        $v = $this->form($request, $user);
        if ($request->file('photo')) {
            $v['photo_path'] = $request->file('photo')->store('users');
        }
        if ($v['password']) {
            $passeord = $v['password'];
            $v['password'] = Hash::make($passeord);
        } else {
            unset($v['password']);
        }
        $user->update($v);
        log_activity('Update the user', ['user' => $user], $user);
        if (notDemo() && isset($v['password']) && !empty($v['password'])) {
            $user->notify(new \App\Notifications\UserPasswordChanged($user, $passeord));
        }
        return back()->with('success', __('model_updated', ['model' => __choice('User', 1)]));
    }
}
