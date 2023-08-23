<?php

namespace App\Http\Controllers;

use Inertia\Inertia;
use App\Models\Contact;
use Illuminate\Http\Request;
use App\Http\Resources\ContactCollection;

class ContactController extends Controller
{
    public function create()
    {
        return Inertia::render('Contacts/Create');
    }

    public function delete(Contact $contact)
    {
        $contact->forceDelete();
        return redirect()->to('/contacts')->with('success', __('model_deleted', ['model' => __choice('Contact', 1)]));
    }

    public function destroy(Contact $contact)
    {
        $contact->delete();
        return back()->with('success', __('model_deleted', ['model' => __choice('Contact', 1)]));
    }

    public function edit(Contact $contact)
    {
        return Inertia::render('Contacts/Edit', [
            'contact' => [
                'id'          => $contact->id,
                'name'        => $contact->name,
                'email'       => $contact->email,
                'phone'       => $contact->phone,
                'address'     => $contact->address,
                'description' => $contact->description,
                'deleted_at'  => $contact->deleted_at,
            ],
        ]);
    }

    public function form(Request $request)
    {
        return $request->validate([
            'name'        => ['required', 'max:250'],
            'phone'       => ['required', 'max:50'],
            'address'     => ['nullable', 'max:250'],
            'description' => ['nullable', 'max:250'],
            'email'       => ['nullable', 'max:50', 'email'],
        ]);
    }

    public function index(Request $request)
    {
        $filters = $request->all('search', 'trashed');

        return Inertia::render('Contacts/Index', [
            'filters'    => $filters,
            'contacts'   => new ContactCollection(
                Contact::filter($filters)->latest()->paginate()->withQueryString()
            ),
        ]);
    }

    public function restore(Contact $contact)
    {
        $contact->restore();
        return back()->with('success', __('model_restored', ['model' => __choice('Contact', 1)]));
    }

    public function store(Request $request)
    {
        $v = $this->form($request);
        Contact::create($v);
        // $request->user()->account->contacts()->create($v);
        return redirect()->route('contacts')->with('success', __('model_created', ['model' => __choice('Contact', 1)]));
    }

    public function update(Request $request, Contact $contact)
    {
        $v = $this->form($request);
        $contact->update($v);
        return back()->with('success', __('model_updated', ['model' => __choice('Contact', 1)]));
    }
}
