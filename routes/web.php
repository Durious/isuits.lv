<?php

use Illuminate\Support\Facades\{Auth, Route};

// Auth
// Auth::routes(['register' => false, 'verify' => false]);

/* Begin Customer Routes */
// Dashboard Page
Route::get('/', 'Customer\HomeController@index')->name('customer.home');

// Authentication Routes
Route::post('/login', 'Customer\AuthController@login')->name('customer.login');
Route::post('/signup', 'Customer\AuthController@signup')->name('customer.signup');
Route::get('/logout', 'Customer\AuthController@logout')->name('customer.logout');

// Customer Pages
Route::get('/about', 'Customer\HomeController@about')->name('customer.about');
Route::get('/terms', 'Customer\HomeController@terms')->name('customer.terms');
Route::get('/contactus', 'Customer\HomeController@contactus')->name('customer.contactus');
Route::post('/lang', 'Customer\HomeController@locale')->name('customer.lang');
Route::get('/services', 'Customer\ServiceController@index')->name('customer.services.index');
Route::get('/products/{type}', 'Customer\ProductController@index')->name('customer.products');
Route::get('/products/details/{product}', 'Customer\ProductController@details')->name('customer.products.details');

// subscribe function
Route::get('/subscriber/store', 'SubscriberController@store')->name('subscriber.store');
Route::get('/subscriber/cancel', 'SubscriberController@cancel')->name('subscriber.cancel');
Route::get('/subscriber/unsubscribe', 'SubscriberController@unsubscribe')->name('subscriber.unsubscribe');

Route::get('/notification', 'NotificationController@index');
Route::post('/notification/read', 'NotificationController@read');
Route::post('/notification/readByIndex', 'NotificationController@readByIndex');
Route::post('/notification/readAll', 'NotificationController@readAll');
Route::delete('/notification/delete/{id}', 'NotificationController@delete')->name('notification.delete');

// MT Payment Systems
Route::post('/mt_system_webhook', 'Customer\ProductOrderController@update_paid')->name('customer.orders.update_paid');

// Authorized Routes
Route::middleware(['auth:customer'])->group(function () {
    Route::get('/profile', 'Customer\ProfileController@index')->name('customer.profile');
    Route::post('/profile', 'Customer\ProfileController@update')->name('customer.profile.update');
    Route::post('/profile/password', 'Customer\ProfileController@change_password')->name('customer.password.update');
    Route::post('/profile/photo', 'Customer\ProfileController@change_photo')->name('customer.photo.update');

    Route::post('/measure', 'Customer\CustomerMeasureController@save_measure')->name('customer.measure.save');
    Route::get('/measure/modal', 'Customer\CustomerMeasureController@get_measure_modal')->name('customer.measure.modal');
    Route::get('/measure/container', 'Customer\CustomerMeasureController@get_measure_container')->name('customer.measure.container');

    Route::get('/mirrorsize/modal', 'Customer\MirrorsizeController@show_modal')->name('customer.mirrorsize.show_modal');
    Route::post('/mirrorsize/set_measure', 'Customer\MirrorsizeController@set_measure')->name('customer.mirrorsize.set_measure');
    Route::post('/mirrorsize/get_measure', 'Customer\MirrorsizeController@get_measure')->name('customer.mirrorsize.get_measure');

    Route::post('/chats/search_tailor', 'Customer\ChatController@search_tailor')->name('customer.chats.search.tailor');
    Route::post('/chats/contacts', 'Customer\ChatController@get_contacts')->name('customer.chats.contacts');
    Route::post('/chats/{user_id}/get_chats', 'Customer\ChatController@get_chats')->name('customer.chats.get');
    Route::post('/chats/{user_id}/send', 'Customer\ChatController@send')->name('customer.chats.send');
    Route::post('/chats/{user_id}/accept', 'Customer\ChatController@accept')->name('customer.chats.accept');

    Route::get('/carts', 'Customer\CartController@index')->name('customer.carts');
    Route::get('/carts/cart_list', 'Customer\CartController@cart_list')->name('customer.carts.cart_list');
    Route::get('/carts/popup_list', 'Customer\CartController@popup_list')->name('customer.carts.popup_list');
    Route::post('/carts/{cart}/quantity', 'Customer\CartController@update_quantity')->name('customer.carts.update_quantity');
    Route::delete('/carts/{cart}', 'Customer\CartController@delete')->name('customer.carts.delete');
    Route::post('/carts/addcart', 'Customer\CartController@addcart')->name('customer.carts.addcart');

    Route::get('/shipping_address', 'Customer\ShippingAddressController@index')->name('customer.shipping_address');
    Route::get('/shipping_address/{id}', 'Customer\ShippingAddressController@show')->name('customer.shipping_address.show');
    Route::post('/shipping_address', 'Customer\ShippingAddressController@save')->name('customer.shipping_address.save');
    Route::delete('/shipping_address/{id}', 'Customer\ShippingAddressController@delete')->name('customer.shipping_address.delete');
    Route::post('/shipping_address/{id}/default', 'Customer\ShippingAddressController@setDefault')->name('customer.shipping_address.default');

    Route::get('/billing_address', 'Customer\BillingAddressController@index')->name('customer.billing_address');
    Route::get('/billing_address/{id}', 'Customer\BillingAddressController@show')->name('customer.billing_address.show');
    Route::post('/billing_address', 'Customer\BillingAddressController@save')->name('customer.billing_address.save');
    Route::delete('/billing_address/{id}', 'Customer\BillingAddressController@delete')->name('customer.billing_address.delete');
    Route::post('/billing_address/{id}/default', 'Customer\BillingAddressController@setDefault')->name('customer.billing_address.default');

    Route::get('/checkout', 'Customer\CheckoutController@index')->name('customer.checkout');

    Route::get('/services/create/{id}', 'Customer\ServiceController@create')->name('customer.services.create');
    Route::post('/services/measurement', 'Customer\ServiceController@save_measurement')->name('customer.services.save_measurement');
    Route::post('/services/order', 'Customer\ServiceController@order')->name('customer.services.order');
    Route::post('/services/review', 'Customer\ServiceController@save_review')->name('customer.services.save_review');

    Route::post('/products/favorite', 'Customer\ProductController@mark_favorite')->name('customer.products.mark_favorite');
    Route::post('/products/review', 'Customer\ProductController@save_review')->name('customer.products.save_review');
    Route::post('/products/comment', 'Customer\ProductController@save_comment')->name('customer.products.save_comment');
    Route::delete('/products/favorite/{product_id}', 'Customer\ProductController@remove_favorites')->name('customer.products.remove_favorite');

    Route::post('/orders/verify', 'Customer\ProductOrderController@verify')->name('customer.orders.verify');
    Route::post('/orders', 'Customer\ProductOrderController@store')->name('customer.orders.store');
});

/* End Customer Routes */

/* Begin Admin Routes */
Route::prefix('admin')->group(function () {
    Route::get('login', 'Auth\LoginController@showLoginForm')->name('login');
    Route::post('login', 'Auth\LoginController@login')->name('login.attempt');
    Route::post('password/reset', 'Auth\ResetPasswordController@reset')->name('password.update');
    Route::post('password/email', 'Auth\ForgotPasswordController@sendResetLinkEmail')->name('password.email');
    Route::get('password/reset/{token}', 'Auth\ResetPasswordController@showResetForm')->name('password.reset');
    Route::get('password/reset', 'Auth\ForgotPasswordController@showLinkRequestForm')->name('password.request');

    Route::get('language/{locale}', 'AjaxController@locale')->name('language');
    Route::get('orders/{order}/view/{hash}', 'OrderController@show')->name('orders.show');
    Route::get('orders/{order}/photo/{hash}', 'OrderController@photo')->name('orders.photo');
    Route::get('payments/{payment}/view/{hash}', 'PaymentController@show')->name('payments.show');

    Route::middleware(['auth:web'])->group(function () {
        // Dashboard
        Route::get('/', 'DashboardController@index')->name('dashboard');
        Route::post('logout', 'Auth\LoginController@logout')->name('logout');
        Route::get('ajax/staff', 'AjaxController@staff')->name('ajax.staff');
        Route::get('ajax/services', 'AjaxController@services')->name('ajax.services');
        Route::get('ajax/categories', 'AjaxController@categories')->name('ajax.categories');
        Route::get('/chart/year', 'DashboardController@yearChart')->name('chart.year');
        Route::get('ajax/customers', 'AjaxController@customers')->name('ajax.customers');
        Route::get('/chart/month', 'DashboardController@monthChart')->name('chart.month');
        Route::get('/ajax/fields/{service}', 'AjaxController@fields')->name('ajax.fields');

        // Profile
        Route::get('/profile/{user}', 'ProfileController@edit')->name('profile.edit');
        Route::put('/profile/{user}', 'ProfileController@update')->name('profile.update');
        Route::get('/profile/{user}/password', 'ProfileController@password')->name('profile.password');
        Route::put('/profile/{user}/password', 'ProfileController@changePassword')->name('profile.change.password');

        // Images
        Route::get('/simg/{path}', 'ImageController@show')->where('path', '.+');

        // Expenses
        // can add middleware('remember') on index;
        Route::get('expenses', 'ExpenseController@index')->name('expenses');
        Route::post('expenses', 'ExpenseController@store')->name('expenses.store');
        Route::get('expenses/create', 'ExpenseController@create')->name('expenses.create');
        Route::put('expenses/{expense}', 'ExpenseController@update')->name('expenses.update');
        Route::get('expenses/{expense}/edit', 'ExpenseController@edit')->name('expenses.edit');

        // Manage Categories
        Route::get('/categories', 'CategoryController@index')->name('categories');
        Route::post('/categories', 'CategoryController@store')->name('categories.store');
        Route::get('/categories/create', 'CategoryController@create')->name('categories.create');
        Route::get('/categories/{category}/edit', 'CategoryController@edit')->name('categories.edit');
        Route::post('/categories/{category}/update', 'CategoryController@update')->name('categories.update');

        // Manage Products
        Route::get('/products', 'ProductController@index')->name('products');
        Route::post('/products', 'ProductController@store')->name('products.store');
        Route::get('/products/create', 'ProductController@create')->name('products.create');
        Route::get('/products/{product}/edit', 'ProductController@edit')->name('products.edit');
        Route::post('/products/{product}/update', 'ProductController@update')->name('products.update');
        Route::post('/products/review/{id}', 'ProductController@save_review')->name('products.save_review');
        Route::delete('/products/review/{id}', 'ProductController@delete_review')->name('products.delete_review');
        Route::post('/products/comment/{id}', 'ProductController@save_comment')->name('products.save_comment');
        Route::delete('/products/comment/{id}', 'ProductController@delete_comment')->name('products.delete_comment');
        Route::post('/products.import', 'ProductController@import')->name('products.import');
        Route::post('/products.export', 'ProductController@export')->name('products.export');

        // Custom Fields
        Route::get('/customfields', 'CustomFieldController@index')->name('customfields');
        Route::post('/customfields', 'CustomFieldController@store')->name('customfields.store');
        Route::get('/customfields/create', 'CustomFieldController@create')->name('customfields.create');
        Route::post('/customfields/level', 'CustomFieldController@level')->name('customfields.level');
        Route::get('/customfields/{field_id}/edit', 'CustomFieldController@edit')->name('customfields.edit');
        Route::post('/customfields/{field_id}/update', 'CustomFieldController@update')->name('customfields.update');
        Route::post('/customfields/savePreview', 'CustomFieldController@save_preview')->name('customfields.savePreview');

        // Services
        Route::get('services', 'ServiceController@index')->name('services');
        Route::post('services', 'ServiceController@store')->name('services.store');
        Route::get('services/create', 'ServiceController@create')->name('services.create');
        Route::post('services/{service}', 'ServiceController@update')->name('services.update');
        Route::get('services/{service}/edit', 'ServiceController@edit')->name('services.edit');
        Route::post('/services.import', 'ServiceController@import')->name('services.import');
        Route::post('/services.export', 'ServiceController@export')->name('services.export');
        Route::post('/services/review/{id}', 'ServiceController@save_review')->name('services.save_review');
        Route::delete('/services/review/{id}', 'ServiceController@delete_review')->name('services.delete_review');

        // Chats
        Route::get('chats', 'ChatController@index')->name('chats');
        Route::get('chats/{customer_id}', 'ChatController@show')->name('chats.show');
        Route::post('chats/{customer_id}/send', 'ChatController@send')->name('chats.send');
        Route::post('chats/{customer_id}/accept', 'ChatController@accept')->name('chats.accept');

        // Measurements
        Route::get('measurements', 'MeasurementController@index')->name('measurements');
        Route::post('measurements', 'MeasurementController@store')->name('measurements.store');
        Route::get('measurements/create', 'MeasurementController@create')->name('measurements.create');
        Route::put('measurements/{measurement}', 'MeasurementController@update')->name('measurements.update');
        Route::get('measurements/{measurement}/edit', 'MeasurementController@edit')->name('measurements.edit');
        Route::get('measurements/{measurement}/view/{hash}', 'MeasurementController@show')->name('measurements.show');

        // Customer Measurement
        Route::get('customer_info/measurements/{id}', 'CustomerInfoController@showMeasurement')->name('customer_info.measurement.show');
        Route::get('customer_info/address/{id}', 'CustomerInfoController@showAddress')->name('customer_info.address.show');
        Route::post('customer_info/shipping_default', 'CustomerInfoController@setShippingDefault')->name('customer_info.shipping.default');
        Route::put('customer_info/shipping/{id}', 'CustomerInfoController@saveShipping')->name('customer_info.shipping.save');
        Route::delete('customer_info/shipping/{id}', 'CustomerInfoController@deleteShipping')->name('customer_info.shipping.delete');
        Route::post('customer_info/billing_default', 'CustomerInfoController@setBillingDefault')->name('customer_info.billing.default');
        Route::put('customer_info/billing/{id}', 'CustomerInfoController@saveBilling')->name('customer_info.billing.save');
        Route::delete('customer_info/billing/{id}', 'CustomerInfoController@deleteBilling')->name('customer_info.billing.delete');

        // Customers
        Route::get('customers', 'CustomerController@index')->name('customers');
        Route::post('customers', 'CustomerController@store')->name('customers.store');
        Route::get('customers/create', 'CustomerController@create')->name('customers.create');
        Route::post('customers/{customer}/sms', 'CustomerController@sms')->name('customers.sms');
        Route::put('customers/{customer}', 'CustomerController@update')->name('customers.update');
        Route::get('customers/{customer}/edit', 'CustomerController@edit')->name('customers.edit');
        Route::put('customers/{customer}/measure', 'CustomerController@save_measure')->name('customers.measure');

        // Contacts
        Route::get('contacts', 'ContactController@index')->name('contacts');
        Route::post('contacts', 'ContactController@store')->name('contacts.store');
        Route::get('contacts/create', 'ContactController@create')->name('contacts.create');
        Route::put('contacts/{contact}', 'ContactController@update')->name('contacts.update');
        Route::get('contacts/{contact}/edit', 'ContactController@edit')->name('contacts.edit');

        // Payments
        Route::get('payments', 'PaymentController@index')->name('payments');
        Route::post('payments', 'PaymentController@store')->name('payments.store');
        Route::get('payments/new', 'PaymentController@create')->name('payments.new');
        Route::put('payments/{payment}', 'PaymentController@update')->name('payments.update');
        Route::get('payments/{payment}/ajax', 'PaymentController@ajax')->name('payments.ajax');
        Route::get('payments/{payment}/edit', 'PaymentController@edit')->name('payments.edit');
        Route::put('payments/{payment}/status', 'PaymentController@status')->name('payments.status');
        Route::post('payments/order/{order}', 'PaymentController@orderPayments')->name('payments.order');

        // Pages
        Route::get('pages', 'PageController')->name('pages');
        Route::get('payu/capture', 'PaymentController@payu_capture')->name('payu.capture');
        Route::get('payu/request/{payment}', 'PaymentController@payu_request')->name('payu.request');

        // Orders
        Route::get('orders', 'OrderController@index')->name('orders');
        Route::post('orders', 'OrderController@store')->name('orders.store');
        Route::get('orders/new', 'OrderController@create')->name('orders.new');
        Route::put('orders/{order}', 'OrderController@update')->name('orders.update');
        Route::get('orders/{order}/ajax', 'OrderController@ajax')->name('orders.ajax');
        Route::get('orders/{order}/edit', 'OrderController@edit')->name('orders.edit');
        Route::post('orders/{order}/email', 'OrderController@email')->name('orders.email');
        Route::put('orders/{order}/status', 'OrderController@status')->name('orders.status');

        // Product Orders
        Route::get('product_orders', 'ProductOrderController@index')->name('product_orders');
        Route::get('product_orders/{id}/edit', 'ProductOrderController@edit')->name('product_orders.edit');
        Route::put('product_orders/{order}', 'ProductOrderController@update')->name('product_orders.update');
        Route::put('product_orders/{order}/status', 'ProductOrderController@status')->name('product_orders.status');
        Route::put('product_orders/{order}/paid_status', 'ProductOrderController@paid_status')->name('product_orders.paid_status');

        Route::middleware(['owner'])->group(function () {
            Route::get('update/database', 'Update\UpdateController');
            Route::get('logs', 'AccountController@logs')->name('logs');
            Route::get('settings', 'AccountController@edit')->name('settings');
            Route::get('ajax/users', 'AjaxController@users')->name('ajax.users');
            Route::put('settings', 'AccountController@update')->name('settings.update');
            Route::get('customers/{customer}/transactions', 'CustomerController@transactions')->name('customers.transactions');
            Route::post('settings/frontend', 'AccountController@frontend_save')->name('settings.frontend.save');
            Route::post('settings/order_statuses', 'AccountController@order_statuses_save')->name('settings.order_statuses.save');
            Route::get('settings/setting_language/{lang}', 'AccountController@get_lang_json')->name('settings.get_lang_json');
            Route::get('settings/get_languages', 'AccountController@getLanguages')->name('settings.get_languages');
            Route::post('settings/save_language', 'AccountController@saveLanguage')->name('settings.save_language');

            // Reports
            Route::get('reports', 'ReportController@index')->name('reports');
            Route::post('reports', 'ReportController@index')->name('reports.get');

            // Users
            Route::get('users', 'UserController@index')->name('users');
            Route::post('users', 'UserController@store')->name('users.store');
            Route::get('users/create', 'UserController@create')->name('users.create');
            Route::put('users/{user}', 'UserController@update')->name('users.update');
            Route::get('users/{user}/edit', 'UserController@edit')->name('users.edit');

            // Salaries
            Route::get('salaries', 'SalaryController@index')->name('salaries');
            Route::post('salaries', 'SalaryController@store')->name('salaries.store');
            Route::get('salaries/create', 'SalaryController@create')->name('salaries.create');
            Route::put('salaries/{salary}', 'SalaryController@update')->name('salaries.update');
            Route::get('salaries/{salary}/edit', 'SalaryController@edit')->name('salaries.edit');
            Route::post('salaries/generate', 'SalaryController@generate')->name('salaries.generate');

            // Taxes
            Route::get('taxes', 'TaxController@index')->name('taxes');
            Route::post('taxes', 'TaxController@store')->name('taxes.store');
            Route::get('taxes/create', 'TaxController@create')->name('taxes.create');
            Route::put('taxes/{tax}', 'TaxController@update')->name('taxes.update');
            Route::get('taxes/{tax}/edit', 'TaxController@edit')->name('taxes.edit');

            // Measurement Fields
            Route::get('measurement_fields', 'MeasurementFieldController@index')->name('measurement_fields');
            Route::post('measurement_fields', 'MeasurementFieldController@store')->name('measurement_fields.store');
            Route::get('measurement_fields/create', 'MeasurementFieldController@create')->name('measurement_fields.create');
            Route::put('measurement_fields/{measurement_field}', 'MeasurementFieldController@update')->name('measurement_fields.update');
            Route::get('measurement_fields/{measurement_field}/edit', 'MeasurementFieldController@edit')->name('measurement_fields.edit');

            // Delete routes
            Route::delete('taxes/{tax}', 'TaxController@destroy')->name('taxes.destroy');
            Route::delete('users/{user}', 'UserController@destroy')->name('users.destroy');
            Route::delete('orders/{order}', 'OrderController@destroy')->name('orders.destroy');
            Route::delete('salaries/{salary}', 'SalaryController@destroy')->name('salaries.destroy');
            Route::delete('expenses/{expense}', 'ExpenseController@destroy')->name('expenses.destroy');
            Route::delete('services/{service}', 'ServiceController@destroy')->name('services.destroy');
            Route::delete('contacts/{contact}', 'ContactController@destroy')->name('contacts.destroy');
            Route::delete('payments/{payment}', 'PaymentController@destroy')->name('payments.destroy');
            Route::delete('products/{product}', 'ProductController@destroy')->name('products.destroy');
            Route::delete('customers/{customer}', 'CustomerController@destroy')->name('customers.destroy');
            Route::delete('customfields/{id}', 'CustomFieldController@destroy')->name('customfields.destroy');
            Route::delete('categories/{category}', 'CategoryController@destroy')->name('categories.destroy');
            Route::delete('measurements/{measurement}', 'MeasurementController@destroy')->name('measurements.destroy');
            Route::delete('measurement_fields/{measurement_field}', 'MeasurementFieldController@destroy')->name('measurement_fields.destroy');

            // Restore routes
            Route::put('taxes/{tax}/restore', 'TaxController@restore')->name('taxes.restore');
            Route::put('users/{user}/restore', 'UserController@restore')->name('users.restore');
            Route::put('orders/{order}/restore', 'OrderController@restore')->name('orders.restore');
            Route::put('salaries/{salary}/restore', 'SalaryController@restore')->name('salaries.restore');
            Route::put('contacts/{contact}/restore', 'ContactController@restore')->name('contacts.restore');
            Route::put('expenses/{expense}/restore', 'ExpenseController@restore')->name('expenses.restore');
            Route::put('payments/{payment}/restore', 'PaymentController@restore')->name('payments.restore');
            Route::put('services/{service}/restore', 'ServiceController@restore')->name('services.restore');
            Route::put('products/{product}/restore', 'ProductController@restore')->name('products.restore');
            Route::put('customers/{customer}/restore', 'CustomerController@restore')->name('customers.restore');
            Route::put('customfields/{id}/restore', 'CustomFieldController@restore')->name('customfields.restore');
            Route::put('categories/{category}/restore', 'CategoryController@restore')->name('categories.restore');
            Route::put('measurements/{measurement}/restore', 'MeasurementController@restore')->name('measurements.restore');
            Route::put('measurement_fields/{measurement_field}/restore', 'MeasurementFieldController@restore')->name('measurement_fields.restore');

            // Permanently Delete routes
            Route::delete('taxes/delete/{tax}', 'TaxController@delete')->name('taxes.delete');
            Route::delete('users/delete/{user}', 'UserController@delete')->name('users.delete');
            Route::delete('orders/delete/{order}', 'OrderController@delete')->name('orders.delete');
            Route::delete('salaries/delete/{salary}', 'SalaryController@delete')->name('salaries.delete');
            Route::delete('expenses/delete/{expense}', 'ExpenseController@delete')->name('expenses.delete');
            Route::delete('services/delete/{service}', 'ServiceController@delete')->name('services.delete');
            Route::delete('contacts/delete/{contact}', 'ContactController@delete')->name('contacts.delete');
            Route::delete('payments/delete/{payment}', 'PaymentController@delete')->name('payments.delete');
            Route::delete('products/delete/{product}', 'ProductController@delete')->name('products.delete');
            Route::delete('customers/delete/{customer}', 'CustomerController@delete')->name('customers.delete');
            Route::delete('categories/delete/{category}', 'CategoryController@delete')->name('categories.delete');
            Route::delete('customfields/delete/{id}', 'CustomFieldController@delete')->name('customfields.delete');
            Route::delete('measurements/delete/{measurement}', 'MeasurementController@delete')->name('measurements.delete');
            Route::delete('measurement_fields/delete/{measurement_field}', 'MeasurementFieldController@delete')->name('measurement_fields.delete');

            Route::prefix('commands')->middleware(['throttle:6,10', 'purchased'])->group(function () {
                Route::get('storage_link', function () {
                    Artisan::call('storage:link');
                    return redirect('notification')->with('message', Artisan::output());
                });
                Route::get('update_database', function () {
                    Artisan::call('migrate --force');
                    return redirect('notification')->with('message', Artisan::output());
                });
            });
        });
    });
});
/* End Admin Routes */

Route::view('offline', 'offline');
Route::fallback(fn () => redirect()->route('customer.home'));

// Notification preview
// Route::get('/notify', function () {
//     // $user = \App\Models\User::find(1);
//     // return (new App\Notifications\UserPasswordChanged($user))->toMail($user);
//     $payment = \App\Models\Payment::find(1);
//     return $payment->customer->notify(new App\Notifications\PaymentReceived($payment));
//     return (new App\Notifications\PaymentReceived($payment))->toMail($payment->customer);
//     // $order = \App\Models\Order::find(1);
//     // return (new App\Notifications\OrderStatusUpdated($order))->toMail($order->customer);
// });
