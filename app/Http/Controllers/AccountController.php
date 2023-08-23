<?php

namespace App\Http\Controllers;

use Validator;
use App\Models\Tax;
use App\Helpers\Env;
use Inertia\Inertia;
use Illuminate\Http\Request;
use App\Models\FrontendSetting;
use Illuminate\Validation\Rule;
use App\Http\Resources\ActivityCollection;
use Illuminate\Support\Facades\File;

class AccountController extends Controller
{
    public function edit(Request $request)
    {
        $account = $request->user()->account;
        return Inertia::render('Accounts/Edit', [
            'account' => array_merge($account->toArray(), Env::changeable()->mapWithKeys(function ($item) {
                return [$item['key'] => $item['value']];
            })->toArray()),
            'frontend_setting' => FrontendSetting::first(),
            'taxes'     => Tax::selectRaw('id as value, name as label')->get(),
            'timezones' => config('timezones'),
        ]);
    }

    public function logs(Request $request)
    {
        $account = $request->user()->account;
        $filters = $request->all('search', 'user');
        return Inertia::render('Accounts/Logs', [
            'filters' => $filters,
            'logs'    => new ActivityCollection(
                $request->user()->account->logs()->with(['causer', 'subject'])->filter($filters)->latest()->paginate()->withQueryString()
            ),
        ]);
    }

    public function update(Request $request)
    {
        $v = $this->validate(
            $request,
            [
                'notifications'           => 'nullable',
                'email_enabled'           => 'nullable',
                'sms_enabled'             => 'nullable',
                'stripe'                  => 'nullable',
                'payu'                    => 'nullable',
                'direction'               => 'required|in:ltr,rtl',
                'language'                => 'required',
                'fraction'                => 'nullable',
                'default_locale'          => 'nullable',
                'name'                    => 'required|max:50',
                'gateways'                => 'required|max:191',
                'phone'                   => 'required|max:50',
                'address'                 => 'nullable|max:191',
                'description'             => 'nullable|max:191',
                'header'                  => 'nullable|max:191',
                'footer'                  => 'nullable|max:191',
                'APP_TIMEZONE'            => 'required|max:50',
                'VONAGE_SIGNATURE_SECRET' => 'nullable|max:191',
                'VONAGE_APP_NAME'         => 'nullable|max:191',
                'VONAGE_APP_VERSION'      => 'nullable|max:191',
                'email'                   => 'nullable|max:50|email',
                'default_tax'             => 'nullable|exists:taxes,id',
                'per_page'                => 'required|integer|min:10|max:100',
                'MAIL_ENCRYPTION'         => 'nullable|max:50',
                'STRIPE_CURRENCY'         => 'max:191|required_if:stripe,true',
                'STRIPE_KEY'              => 'max:191|required_if:stripe,true',
                'STRIPE_SECRET'           => 'max:191|required_if:stripe,true',
                'PAYU_DEFAULT_GATEWAY'    => 'nullable|max:191|in:biz,money|required_if:payu,true',
                'PAYU_MONEY_MODE'         => [
                    'nullable', 'in:live,test',
                    Rule::requiredIf('true' == $request->payu && 'money' == $request->PAYU_DEFAULT_GATEWAY)
                ],
                'PAYU_MONEY_KEY' => [
                    'nullable', 'max:191',
                    Rule::requiredIf('true' == $request->payu && 'money' == $request->PAYU_DEFAULT_GATEWAY)
                ],
                'PAYU_MONEY_SALT' => [
                    'nullable', 'max:191',
                    Rule::requiredIf('true' == $request->payu && 'money' == $request->PAYU_DEFAULT_GATEWAY)
                ],
                'PAYU_MONEY_AUTH' => 'nullable',
                'PAYU_BIZ_MODE'   => [
                    'nullable', 'in:live,test',
                    Rule::requiredIf('true' == $request->payu && 'biz' == $request->PAYU_DEFAULT_GATEWAY)
                ],
                'PAYU_BIZ_KEY' => [
                    'nullable', 'max:191',
                    Rule::requiredIf('true' == $request->payu && 'biz' == $request->PAYU_DEFAULT_GATEWAY)
                ],
                'PAYU_BIZ_SALT' => [
                    'nullable', 'max:191',
                    Rule::requiredIf('true' == $request->payu && 'biz' == $request->PAYU_DEFAULT_GATEWAY)
                ],
                'SMS_FROM'              => 'max:191|required_if:sms_enabled,true',
                'VONAGE_KEY'            => 'max:191|required_if:sms_enabled,true',
                'VONAGE_SECRET'         => 'max:191|required_if:sms_enabled,true',
                'MAIL_FROM_NAME'        => 'max:191|required_if:email_enabled,true',
                'MAIL_FROM_ADDRESS'     => 'max:191|required_if:email_enabled,true|nullable|email',
                'MAIL_MAILER'           => 'max:191|required_if:email_enabled,true|nullable|in:ses,smtp,mailgun,postmark',
                'AWS_ACCESS_KEY_ID'     => 'max:191|required_if:MAIL_MAILER,ses',
                'AWS_SECRET_ACCESS_KEY' => 'max:191|required_if:MAIL_MAILER,ses',
                'AWS_DEFAULT_REGION'    => 'max:191|required_if:MAIL_MAILER,ses',
                'MAIL_HOST'             => 'max:191|required_if:MAIL_MAILER,smtp',
                'MAIL_PORT'             => 'max:191|required_if:MAIL_MAILER,smtp',
                'MAIL_USERNAME'         => 'max:191',
                'MAIL_PASSWORD'         => 'max:191',
                'MIRRORSIZE_API_KEY'    => 'max:191',
                'MIRRORSIZE_MERCHANT_ID' => 'max:191',
                'MIRRORSIZE_USERNAME'   => 'max:191',
                'MONEZIUM_SITE_KEY'     => 'max:191',
                'MONEZIUM_SHOP_KEY'     => 'max:191',
                'MAILGUN_DOMAIN'        => 'max:191|required_if:MAIL_MAILER,mailgun',
                'MAILGUN_SECRET'        => 'max:191|required_if:MAIL_MAILER,mailgun',
                'MAILGUN_ENDPOINT'      => 'max:191|required_if:MAIL_MAILER,mailgun',
                'POSTMARK_TOKEN'        => 'max:191|required_if:MAIL_MAILER,postmark',
                'logo'                  => 'nullable|image|dimensions:min_width=100,max_width=500,min_height=40,max_height=150',
                'SOCKET_SERVER_URL'     => 'max:191',
            ],
            ['logo.dimensions' => 'Image should be between 100px to 500px in width & 40px to 150px in height.']
        );

        $user = $request->user();
        $request->merge(['payu' => 'true' == $request->get('payu') ? 1 : 0]);
        $request->merge(['stripe' => 'true' == $request->get('stripe') ? 1 : 0]);
        $request->merge(['sms_enabled' => 'true' == $request->get('sms_enabled') ? 1 : 0]);
        $request->merge(['email_enabled' => 'true' == $request->get('email_enabled') ? 1 : 0]);
        $data = $request->only([
            'name',
            'phone',
            'email',
            'gateways',
            'default_tax',
            'per_page',
            'address',
            'description',
            'header',
            'footer',
            'notifications',
            'email_enabled',
            'sms_enabled',
            'payu',
            'stripe',
            'direction',
            'language',
            'fraction',
            'default_locale',
        ]);

        $request->merge(['APP_NAME' => $request->get('name')]);
        $env = $request->only([
            'APP_NAME',
            'APP_URL',
            'MAIL_FROM_NAME',
            'MAIL_FROM_ADDRESS',
            'APP_TIMEZONE',
            'MAIL_MAILER',
            'MAIL_HOST',
            'MAIL_PORT',
            'MAIL_ENCRYPTION',
            'MAIL_USERNAME',
            'MAIL_PASSWORD',
            'STRIPE_KEY',
            'STRIPE_SECRET',
            'STRIPE_CURRENCY',
            'PAYU_DEFAULT_GATEWAY',
            'PAYU_MONEY_MODE',
            'PAYU_MONEY_KEY',
            'PAYU_MONEY_SALT',
            'PAYU_MONEY_AUTH',
            'PAYU_BIZ_MODE',
            'PAYU_BIZ_KEY',
            'PAYU_BIZ_SALT',
            'SMS_FROM',
            'VONAGE_KEY',
            'VONAGE_SECRET',
            'VONAGE_SIGNATURE_SECRET',
            'VONAGE_APP_NAME',
            'VONAGE_APP_VERSION',
            'MAILGUN_DOMAIN',
            'MAILGUN_SECRET',
            'MAILGUN_ENDPOINT',
            'POSTMARK_TOKEN',
            'AWS_ACCESS_KEY_ID',
            'AWS_SECRET_ACCESS_KEY',
            'AWS_DEFAULT_REGION',
            'MIRRORSIZE_API_KEY',
            'MIRRORSIZE_MERCHANT_ID',
            'MIRRORSIZE_USERNAME',
            'MONEZIUM_SITE_KEY',
            'MONEZIUM_SHOP_KEY',
            'SOCKET_SERVER_URL',
        ]);

        if (demo()) {
            $data['name'] = 'Default Tailor Shop';
            $account_updated = $user->account->update($data);
            return response()->json(['success' => false, 'message' => __('Demo only save few settings, others are disabled.')], 422);
        } elseif ($request->file('logo')) {
            $imageName = time() . '.' . $request->logo->extension();
            $request->logo->storeAs('public/account', $imageName);
            $data['logo_path'] = $imageName;
        }

        $env_updated = Env::update(array_map('addslashes', $env));
        $account_updated = $user->account->update($data);
        log_activity(__('model_updated', ['model' => __choice('Setting', 2)]), ['account' => $data, 'config' => $env], $user->account);
        return response()->json(['success' => true, 'message' => __('model_updated', ['model' => __choice('Setting', 2)])]);
    }

    public function frontend_save(Request $request)
    {

        $rule['slides'] = ['required', 'array', 'min:1'];
        $rule['slides.*.main_title'] = 'required';
        $rule['slides.*.sub_title'] = 'required';
        $rule['slides.*.description'] = 'required';
        $rule['slides.*.main_image'] = validateImage('slide image');
        $rule['slides.*.sub_image'] = validateImage('slide sub image');
        $rule['galleries.*.main_title'] = 'required';
        $rule['galleries.*.sub_title'] = 'required';
        // $rule['galleries.*.images.*'] = validateImage('gallery image');
        $rule['limiteds.*.description'] = 'required';
        $rule['limiteds.*.image'] = validateImage('limited image');
        $rule['discount.title'] = 'required';
        $rule['discount.description'] = 'required';
        $rule['discount.image1'] = validateImage('discount image1');
        $rule['discount.image2'] = validateImage('discount image2');
        $rule['discount.image3'] = validateImage('discount image3');
        $rule['embrace.description'] = 'required';
        $rule['embrace.image'] = validateImage('embrace image');
        $rule['testimonial.*.name'] = 'required';
        $rule['testimonial.*.position'] = 'required';
        $rule['testimonial.*.description'] = 'required';
        $rule['testimonial.*.photo'] = validateImage('testimonial photo');
        $rule['service.*.title'] = 'required';
        $rule['service.*.description'] = 'required';
        $rule['service.*.icon'] = validateImage('service icon');
        $rule['subscribe.description'] = 'required';
        $rule['subscribe.image'] = validateImage('subscribe image');
        $rule['instagram.*.image'] = validateImage('instagram image');
        $rule['faq.*.title'] = 'required';
        $rule['faq.*.description'] = 'required';
        $rule['story.image'] = validateImage('story image');
        $rule['story.description'] = 'required';
        $rule['about_service.description'] = 'required';
        $rule['about_service.list.*.title'] = 'required';
        $rule['about_service.list.*.description'] = 'required';
        $rule['about_service.list.*.icon'] = validateImage('about_service icon');
        $rule['terms'] = 'required';

        $validator = Validator::make($request->all(), $rule);

        $validator->setCustomMessages([
            'slides.*.main_title.required' => __('The slide main title is required.'),
            'slides.*.sub_title.required' => __('The slide sub title is required.'),
            'slides.*.description.required' => __('The slide description is required.'),
            'slides.*.sub_image.required' => __('The slide sub image is required.'),
            'slides.*.main_image.required' => __('The slide main image is required.'),
            'galleries.*.main_title.required' => __('The gallery main title is required.'),
            'galleries.*.sub_title.required' => __('The gallery sub title is required.'),
            // 'galleries.*.images.*.required' => __('The gallery image is required.'),
            'limiteds.*.image.required' => __('The limited image is required.'),
            'limiteds.*.description.required' => __('The limited description is required.'),
            'discount.title.required' => __('The discount title is required.'),
            'discount.description.required' => __('The discount description is required.'),
            'discount.image1.required' => __('The discount image1 is required.'),
            'discount.image2.required' => __('The discount image2 is required.'),
            'discount.image3.required' => __('The discount image3 is required.'),
            'embrace.image.required' => __('The embrace image is required.'),
            'embrace.description.required' => __('The embrace description is required.'),
            'testimonial.*.name.required' => __('The testimonial name is required.'),
            'testimonial.*.position.required' => __('The testimonial position is required.'),
            'testimonial.*.description.required' => __('The testimonial description is required.'),
            'testimonial.*.photo.required' => __('The testimonial photo is required.'),
            'service.*.title.required' => __('The service title is required.'),
            'service.*.description.required' => __('The service description is required.'),
            'service.*.icon.required' => __('The service icon is required.'),
            'subscribe.image.required' => __('The subscribe image is required.'),
            'subscribe.description.required' => __('The subscribe description is required.'),
            'instagram.*.image.required' => __('The instagram image is required.'),
            'faq.*.title.required' => __('The faq title is required.'),
            'faq.*.description.required' => __('The faq description is required.'),
            'story.description.required' => __('The story description is required.'),
            'story.image.required' => __('The story image is required.'),
            'about_service.description.required' => __('The service description is required.'),
            'about_service.list.*.title.required' => __('The about_service title is required.'),
            'about_service.list.*.description.required' => __('The about_service description is required.'),
            'about_service.list.*.icon.required' => __('The about_service icon is required.'),
            'footer.text.required' => __('The footer text is required.'),
            'footer.facebook.required' => __('The footer facebook link is required.'),
            'footer.instagram.required' => __('The footer instagram link is required.'),
            'footer.twitter.required' => __('The footer twitter link is required.'),
        ]);

        if ($validator->fails()) {
            return redirect()->back()->withErrors($validator);
        }
        $slides         = $request->slides;
        $temp_galleries      = $request->galleries;
        $limiteds        = $request->limiteds;
        $discount       = $request->discount;
        $embrace        = $request->embrace;
        $testimonial    = $request->testimonial;
        $service        = $request->service;
        $subscribe      = $request->subscribe;
        $instagram      = $request->instagram;
        $faq            = $request->faq;
        $story          = $request->story;
        $about_service  = $request->about_service;
        $footer         = $request->footer;
        $terms         = $request->terms;

        $gallery_images = $request->gallery_images;

        foreach ($slides as $i => &$slide) {
            uploadImage($slide, 'main_image', '1' . $i, 'frontend');
            uploadImage($slide, 'sub_image', '2' . $i, 'frontend');
        }

        $galleries = array();
        foreach ($gallery_images as $i => $gallery) {
            $temp_gallery = array();
            $temp_gallery['main_title'] = $temp_galleries[$i]['main_title'];
            $temp_gallery['sub_title'] = $temp_galleries[$i]['sub_title'];
            if ($gallery && count($gallery) > 0) {
                $uploaded_file_names = array();
                foreach ($gallery as $i => $image) {
                    if (is_uploaded_file($image)) {
                        $filename = time() . $i . '.' . strtolower($image->getClientOriginalExtension());
                        $image->storeAs('public/frontend', $filename);
                        $uploaded_file_names[] = $filename;
                    }
                    if (is_string($image)) {
                        $uploaded_file_names[] = $image;
                    }
                }
                $temp_gallery['images'] = $uploaded_file_names;
            }
            array_push($galleries, $temp_gallery);
        }
        foreach ($testimonial as $i => &$item) {
            uploadImage($item, 'photo', '4' . $i, 'frontend');
        }
        foreach ($service as $i => &$item) {
            uploadImage($item, 'icon', '5' . $i, 'frontend');
        }
        foreach ($instagram as $i => &$item) {
            uploadImage($item, 'image', '6' . $i, 'frontend');
        }
        foreach ($about_service['list'] as $i => &$item) {
            uploadImage($item, 'icon', 'b' . $i, 'frontend');
        }
        foreach ($limiteds as $i => &$limited) {
            // uploadImage($limited, 'image', '70', 'frontend');
            uploadImage($limited, 'image', '7' . $i, 'frontend');
        }

        uploadImage($discount, 'image1', '80', 'frontend');
        uploadImage($discount, 'image2', '81', 'frontend');
        uploadImage($discount, 'image3', '82', 'frontend');
        uploadImage($embrace, 'image', '90', 'frontend');
        uploadImage($subscribe, 'image', '00', 'frontend');
        uploadImage($story, 'image', 'a0', 'frontend');

        $frontend_setting = FrontendSetting::first();
        if (!$frontend_setting) {
            $frontend_setting = new FrontendSetting();
        }
        $frontend_setting->slides        = json_encode($slides);
        $frontend_setting->galleries     = json_encode($galleries);
        $frontend_setting->limited       = json_encode($limiteds);
        $frontend_setting->discount      = json_encode($discount);
        $frontend_setting->embrace       = json_encode($embrace);
        $frontend_setting->testimonial   = json_encode($testimonial);
        $frontend_setting->service       = json_encode($service);
        $frontend_setting->subscribe     = json_encode($subscribe);
        $frontend_setting->instagram     = json_encode($instagram);
        $frontend_setting->faq           = json_encode($faq);
        $frontend_setting->story         = json_encode($story);
        $frontend_setting->about_service = json_encode($about_service);
        $frontend_setting->footer        = json_encode($footer);
        $frontend_setting->terms         = $terms;

        $frontend_setting->save();

        return back()->with('success', __('model_updated', ['model' => __('frontend')]));
    }

    public function order_statuses_save(Request $request)
    {
        $rule['order_statuses'] = ['required', 'array', 'min:1'];
        $rule['order_statuses.*'] = 'required';
        $validator = Validator::make($request->all(), $rule);
        $validator->setCustomMessages([
            'order_statuses.*.required' => __('The status text is required.'),
        ]);

        if ($validator->fails()) {
            return redirect()->back()->withErrors($validator);
        }
        $order_statuses = $request->order_statuses;
        $request->user()->account->update([
            'order_statuses' => implode(',', $order_statuses)
        ]);

        return back()->with('success', __('model_updated', ['model' => __choice('Slide', 1)]));
    }

    public function get_lang_json($lang)
    {
        $lang_file_name = $lang . ".json";
        $lang_content = collect(json_decode(File::get(lang_path($lang_file_name))));
        return $lang_content;
    }

    public function getLanguages()
    {
        $langFiles = collect(json_decode(File::get(lang_path('languages.json')))->available)->pluck('value')->all();
        return $langFiles;
    }

    public function saveLanguage(Request $request)
    {
        $lang = $request->lang;
        $json_file_name = $lang . ".json";
        $json_file = lang_path($json_file_name);
        $json_data = json_encode($request->data);
        $result = File::put($json_file, $json_data, true);
        if ($result) {
            return back()->with('success', __('Language Json data has been successfully saved.'));
        } else {
            return back()->with('error', __('Language Json data saving failed.'));
        }
    }
}
