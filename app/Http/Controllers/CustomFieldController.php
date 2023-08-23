<?php

namespace App\Http\Controllers;

use Inertia\Inertia;
use App\Models\CustomField;
use Illuminate\Http\Request;
use App\Models\TagBackground;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Validator;

class CustomFieldController extends Controller
{
    public function index()
    {
        return Inertia::render('CustomField/Index', [
            'custom_fields' => CustomField::orderBy('order')->get()
        ]);
    }

    public function create()
    {
        return Inertia::render('CustomField/Create');
    }

    public function store(Request $request)
    {
        $validator = $this->form($request);
        if ($validator->fails()) {
            return redirect()->back()->withErrors($validator);
        }

        $options = $request->options;
        
        if($request->type === 'ImageRadio') {
            foreach ($options as $i => &$option) {
                if (isset($option['file']) && $option['file'] && is_uploaded_file($option['file'])) {
                    $filename = time().$i.'1.'.$option['file']->extension();
                    $option['file']->storeAs('public/customfield', $filename);                
                    $option['file'] = $filename;
                }
                if (isset($option['preview']) && $option['preview'] && is_uploaded_file($option['preview'])) {
                    $filename = time().$i.'2.'.$option['preview']->extension();
                    $option['preview']->storeAs('public/customfield', $filename);                
                    $option['preview'] = $filename;
                }
            }
        }

        $customField = new CustomField();
        $customField->name          = $request->name;
        $customField->type          = $request->type;
        $customField->description   = $request->description;
        $customField->tag           = $request->tag;
        $customField->options       = json_encode($options);
        $customField->order         = CustomField::max('order') + 1;

        $customField->save();

        return redirect()->route('customfields')->with('success', __('model_created', ['model' => __choice('custom_field', 1)]));
    }

    public function edit($field_id)
    {
        $customField = CustomField::withTrashed()->find($field_id);
        $tagBackground = TagBackground::where('name', $customField->tag)->first();

        return Inertia::render('CustomField/Edit', [
            'customField' => [
                'id'            => $customField->id,
                'name'          => $customField->name,
                'type'          => $customField->type,
                'description'   => $customField->description,
                'tag'           => $customField->tag,
                'options'       => $customField->options,
                'deleted_at'    => $customField->deleted_at
            ],
            'iTagBackground' => $tagBackground
        ]);
    }

    public function level(Request $request)
    {
        $item1 = CustomField::find($request->id1);
        $item2 = CustomField::find($request->id2);
        $order1 = $item1->order;
        $item1->order = $item2->order;
        $item2->order = $order1;
        $item1->save();
        $item2->save();
        return back()->with('success', __('level_changed'));
    }

    public function update($field_id, Request $request)
    {
        $validator = $this->form($request);
        if ($validator->fails()) {
            return redirect()->back()->withErrors($validator);
        }

        $options = $request->options;
        
        if($request->type === 'ImageRadio') {
            foreach ($options as $i => &$option) {
                if (isset($option['file']) && $option['file'] && is_uploaded_file($option['file'])) {
                    $filename = time().$i.'1.'.$option['file']->extension();
                    $option['file']->storeAs('public/customfield', $filename);                
                    $option['file'] = $filename;
                }
                if (isset($option['preview']) && $option['preview'] && is_uploaded_file($option['preview'])) {
                    $filename = time().$i.'2.'.$option['preview']->extension();
                    $option['preview']->storeAs('public/customfield', $filename);                
                    $option['preview'] = $filename;
                }
            }
        }

        $customField = CustomField::find($field_id);
        $customField->name          = $request->name;
        $customField->type          = $request->type;
        $customField->description   = $request->description;
        $customField->tag           = $request->tag;
        $customField->options       = json_encode($options);

        $customField->save();

        return back()->with('success', __('model_updated', ['model' => __choice('custom_field', 1)]));
    }

    public function restore($id)
    {
        CustomField::withTrashed()->find($id)->restore();
        return back()->with('success', __('model_restored', ['model' => __choice('custom_field', 1)]));
    }

    public function delete($id)
    {
        CustomField::withTrashed()->find($id)->forceDelete();
        return redirect()->to('/customfields')->with('success', __('model_deleted', ['model' => __choice('custom_field', 1)]));
    }

    public function destroy($id)
    {
        CustomField::withTrashed()->find($id)->delete();
        return back()->with('success', __('model_deleted', ['model' => __choice('custom_field', 1)]));
    }

    public function save_preview(Request $request)
    {
        $rule = [
            'name' => 'required|string',
            'background' => [
                'required',
                function($attribute, $value, $fail) {
                    if(is_string($value)) {
                        return;
                    }
                    if(!is_uploaded_file($value)) {
                        return $fail('The preview image must be an file');
                    }
                    if(!in_array(strtolower($value->getClientOriginalExtension()), ['jpg', 'jpeg', 'png', 'gif'])) {
                        return $fail('The preview image must be a JPG, JPEG, PNG, or GIF file');
                    }
                }
            ]
        ];

        $validator = Validator::make($request->all(), $rule);
        if ($validator->fails()) {
            return redirect()->back()->withErrors($validator);
        }

        $preview = TagBackground::where('name', $request->name)->first() ?? new TagBackground();
        $preview->name = $request->name;
        if ($request->background && is_uploaded_file($request->background)) {
            $filename = time().'.'.$request->background->extension();
            $request->background->storeAs('public/tagpreview', $filename);                
            $request->background = $filename;
        }
        $preview->background = $request->background;
        $preview->save();
        return back()->with('success', __('model_updated', ['model' => __choice('preview_image', 1)]));
    }

    public function form(Request $request)
    {
        $rule = [
            'name'=> 'required',
            'type'=> 'required',
            'tag'=> 'required',
            'description'=> 'required'
        ];
        if($request->type === 'ImageRadio' || $request->type === "Radio") {
            $rule['options'] = ['required', 'array', 'min:1'];
            $rule['options.*.name'] = 'required';
            $rule['options.*.description'] = 'required';
            if($request->type === 'ImageRadio') {
                $rule['options.*.file'] = [
                    'required',
                    function($attribute, $value, $fail) {
                        if(is_string($value)) {
                            return;
                        }
                        if(!is_uploaded_file($value)) {
                            return $fail('The option photo must be an image file');
                        }
                        if(!in_array(strtolower($value->getClientOriginalExtension()), ['jpg', 'jpeg', 'png', 'gif'])) {
                            return $fail('The option photo must be a JPG, JPEG, PNG, or GIF file');
                        }
                    }
                ];
                $rule['options.*.preview'] = [
                    'nullable',
                    function($attribute, $value, $fail) {
                        if(is_string($value)) {
                            return;
                        }
                        if(!is_uploaded_file($value)) {
                            return $fail('The option preview must be an image file');
                        }
                        if(!in_array(strtolower($value->getClientOriginalExtension()), ['jpg', 'jpeg', 'png', 'gif'])) {
                            return $fail('The option preview must be a JPG, JPEG, PNG, or GIF file');
                        }
                    }
                ];
            }
        }

        $validator = Validator::make($request->all(), $rule);

        $validator->setCustomMessages([
            'options.*.name.required' => __('The option name field is required.'),
            'options.*.file.required' => __('The option photo field is required.'),
            'options.*.description.required' => __('The option description field is required.'),
        ]);

        return $validator;
    }
}
