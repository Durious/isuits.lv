/*!
 *  Lang.js for Laravel localization in JavaScript.
 *
 *  @version 1.1.10
 *  @license MIT https://github.com/rmariuzzo/Lang.js/blob/master/LICENSE
 *  @site    https://github.com/rmariuzzo/Lang.js
 *  @author  Rubens Mariuzzo <rubens@mariuzzo.com>
 */
(function(root,factory){"use strict";if(typeof define==="function"&&define.amd){define([],factory)}else if(typeof exports==="object"){module.exports=factory()}else{root.Lang=factory()}})(this,function(){"use strict";function inferLocale(){if(typeof document!=="undefined"&&document.documentElement){return document.documentElement.lang}}function convertNumber(str){if(str==="-Inf"){return-Infinity}else if(str==="+Inf"||str==="Inf"||str==="*"){return Infinity}return parseInt(str,10)}var intervalRegexp=/^({\s*(\-?\d+(\.\d+)?[\s*,\s*\-?\d+(\.\d+)?]*)\s*})|([\[\]])\s*(-Inf|\*|\-?\d+(\.\d+)?)\s*,\s*(\+?Inf|\*|\-?\d+(\.\d+)?)\s*([\[\]])$/;var anyIntervalRegexp=/({\s*(\-?\d+(\.\d+)?[\s*,\s*\-?\d+(\.\d+)?]*)\s*})|([\[\]])\s*(-Inf|\*|\-?\d+(\.\d+)?)\s*,\s*(\+?Inf|\*|\-?\d+(\.\d+)?)\s*([\[\]])/;var defaults={locale:"en"};var Lang=function(options){options=options||{};this.locale=options.locale||inferLocale()||defaults.locale;this.fallback=options.fallback;this.messages=options.messages};Lang.prototype.setMessages=function(messages){this.messages=messages};Lang.prototype.getLocale=function(){return this.locale||this.fallback};Lang.prototype.setLocale=function(locale){this.locale=locale};Lang.prototype.getFallback=function(){return this.fallback};Lang.prototype.setFallback=function(fallback){this.fallback=fallback};Lang.prototype.has=function(key,locale){if(typeof key!=="string"||!this.messages){return false}return this._getMessage(key,locale)!==null};Lang.prototype.get=function(key,replacements,locale){if(!this.has(key,locale)){return key}var message=this._getMessage(key,locale);if(message===null){return key}if(replacements){message=this._applyReplacements(message,replacements)}return message};Lang.prototype.trans=function(key,replacements){return this.get(key,replacements)};Lang.prototype.choice=function(key,number,replacements,locale){replacements=typeof replacements!=="undefined"?replacements:{};replacements.count=number;var message=this.get(key,replacements,locale);if(message===null||message===undefined){return message}var messageParts=message.split("|");var explicitRules=[];for(var i=0;i<messageParts.length;i++){messageParts[i]=messageParts[i].trim();if(anyIntervalRegexp.test(messageParts[i])){var messageSpaceSplit=messageParts[i].split(/\s/);explicitRules.push(messageSpaceSplit.shift());messageParts[i]=messageSpaceSplit.join(" ")}}if(messageParts.length===1){return message}for(var j=0;j<explicitRules.length;j++){if(this._testInterval(number,explicitRules[j])){return messageParts[j]}}var pluralForm=this._getPluralForm(number);return messageParts[pluralForm]};Lang.prototype.transChoice=function(key,count,replacements){return this.choice(key,count,replacements)};Lang.prototype._parseKey=function(key,locale){if(typeof key!=="string"||typeof locale!=="string"){return null}var segments=key.split(".");var source=segments[0].replace(/\//g,".");return{source:locale+"."+source,sourceFallback:this.getFallback()+"."+source,entries:segments.slice(1)}};Lang.prototype._getMessage=function(key,locale){locale=locale||this.getLocale();key=this._parseKey(key,locale);if(this.messages[key.source]===undefined&&this.messages[key.sourceFallback]===undefined){return null}var message=this.messages[key.source];var entries=key.entries.slice();var subKey="";while(entries.length&&message!==undefined){var subKey=!subKey?entries.shift():subKey.concat(".",entries.shift());if(message[subKey]!==undefined){message=message[subKey];subKey=""}}if(typeof message!=="string"&&this.messages[key.sourceFallback]){message=this.messages[key.sourceFallback];entries=key.entries.slice();subKey="";while(entries.length&&message!==undefined){var subKey=!subKey?entries.shift():subKey.concat(".",entries.shift());if(message[subKey]){message=message[subKey];subKey=""}}}if(typeof message!=="string"){return null}return message};Lang.prototype._findMessageInTree=function(pathSegments,tree){while(pathSegments.length&&tree!==undefined){var dottedKey=pathSegments.join(".");if(tree[dottedKey]){tree=tree[dottedKey];break}tree=tree[pathSegments.shift()]}return tree};Lang.prototype._applyReplacements=function(message,replacements){for(var replace in replacements){message=message.replace(new RegExp(":"+replace,"gi"),function(match){var value=replacements[replace];var allCaps=match===match.toUpperCase();if(allCaps){return value.toUpperCase()}var firstCap=match===match.replace(/\w/i,function(letter){return letter.toUpperCase()});if(firstCap){return value.charAt(0).toUpperCase()+value.slice(1)}return value})}return message};Lang.prototype._testInterval=function(count,interval){if(typeof interval!=="string"){throw"Invalid interval: should be a string."}interval=interval.trim();var matches=interval.match(intervalRegexp);if(!matches){throw"Invalid interval: "+interval}if(matches[2]){var items=matches[2].split(",");for(var i=0;i<items.length;i++){if(parseInt(items[i],10)===count){return true}}}else{matches=matches.filter(function(match){return!!match});var leftDelimiter=matches[1];var leftNumber=convertNumber(matches[2]);if(leftNumber===Infinity){leftNumber=-Infinity}var rightNumber=convertNumber(matches[3]);var rightDelimiter=matches[4];return(leftDelimiter==="["?count>=leftNumber:count>leftNumber)&&(rightDelimiter==="]"?count<=rightNumber:count<rightNumber)}return false};Lang.prototype._getPluralForm=function(count){switch(this.locale){case"az":case"bo":case"dz":case"id":case"ja":case"jv":case"ka":case"km":case"kn":case"ko":case"ms":case"th":case"tr":case"vi":case"zh":return 0;case"af":case"bn":case"bg":case"ca":case"da":case"de":case"el":case"en":case"eo":case"es":case"et":case"eu":case"fa":case"fi":case"fo":case"fur":case"fy":case"gl":case"gu":case"ha":case"he":case"hu":case"is":case"it":case"ku":case"lb":case"ml":case"mn":case"mr":case"nah":case"nb":case"ne":case"nl":case"nn":case"no":case"om":case"or":case"pa":case"pap":case"ps":case"pt":case"so":case"sq":case"sv":case"sw":case"ta":case"te":case"tk":case"ur":case"zu":return count==1?0:1;case"am":case"bh":case"fil":case"fr":case"gun":case"hi":case"hy":case"ln":case"mg":case"nso":case"xbr":case"ti":case"wa":return count===0||count===1?0:1;case"be":case"bs":case"hr":case"ru":case"sr":case"uk":return count%10==1&&count%100!=11?0:count%10>=2&&count%10<=4&&(count%100<10||count%100>=20)?1:2;case"cs":case"sk":return count==1?0:count>=2&&count<=4?1:2;case"ga":return count==1?0:count==2?1:2;case"lt":return count%10==1&&count%100!=11?0:count%10>=2&&(count%100<10||count%100>=20)?1:2;case"sl":return count%100==1?0:count%100==2?1:count%100==3||count%100==4?2:3;case"mk":return count%10==1?0:1;case"mt":return count==1?0:count===0||count%100>1&&count%100<11?1:count%100>10&&count%100<20?2:3;case"lv":return count===0?0:count%10==1&&count%100!=11?1:2;case"pl":return count==1?0:count%10>=2&&count%10<=4&&(count%100<12||count%100>14)?1:2;case"cy":return count==1?0:count==2?1:count==8||count==11?2:3;case"ro":return count==1?0:count===0||count%100>0&&count%100<20?1:2;case"ar":return count===0?0:count==1?1:count==2?2:count%100>=3&&count%100<=10?3:count%100>=11&&count%100<=99?4:5;default:return 0}};return Lang});

(function () {
    Lang = new Lang();
    Lang.setMessages({"en.auth":{"failed":"These credentials do not match our records.","password":"The provided password is incorrect.","throttle":"Too many login attempts. Please try again in :seconds seconds."},"en.message":{"cancel_customize":"Cancel Customize","complete_customize":"Complete Customize","next":"Next","prev":"Prev"},"en.pagination":{"next":"Next &raquo;","previous":"&laquo; Previous"},"en.passwords":{"reset":"Your password has been reset!","sent":"We have emailed your password reset link!","throttled":"Please wait before retrying.","token":"This password reset token is invalid.","user":"We can't find a user with that email address."},"en.strings":{"403: Forbidden":"403: Forbidden","404: Page Not Found":"404: Page Not Found","419: Page Expired":"419: Page Expired","500: Server Error":"500: Server Error","503: Service Unavailable":"503: Service Unavailable","Active":"Active","Activity Log":"Activity Log","Add":"Add","Added Expenses":"Added Expenses","Address":"Address","Address Information":"Address Information","All":"All","Already Completed":"Already Completed","Amount":"Amount","Arms":"Arms","Assign to":"Assign to","Assigned to & delivery":"Assigned to & delivery","Back Length":"Back Length","Back Type":"Back Type","Back to Login":"Back to Login","Balance":"Balance","Biceps":"Biceps","Billing Address":"Billing Address","Browse":"Browse","By":"By","By Email":"By Email","By SMS":"By SMS","Can edit all (expenses, orders & payments)":"Can edit all (expenses, orders & payments)","Can send sms to customers":"Can send sms to customers","Can view all (expenses, orders & payments)":"Can view all (expenses, orders & payments)","Cancel":"Cancel","Category":"Category|Categories","Certified Email":"Certified Email","Change Password":"Change Password","Chest":"Chest","Chest Type":"Chest Type","City":"City","Close":"Close","Code":"Code","Comment \/ Note":"Comment \/ Note","Company Details":"Company Details","Completed":"Completed","Compound":"Compound","Confirm Password":"Confirm Password","Contact":"Contact|Contacts","Create":"Create","Created By":"Created By","Created at":"Created at","Credit":"Credit","Credit or debit card":"Credit or debit card","Customer":"Customer|Customers","Customer Details":"Customer Details","Customer Measure":"Customer Measure","Customization":"Customization","Dashboard":"Dashboard","Database Status":"Database Status","Date":"Date","Date of Birth":"Date of Birth","Debit":"Debit","Decimals":"Decimals","Default Tax":"Default Tax","Delete Permanently":"Delete Permanently","Delivery":"Delivery|Deliveries","Delivery Date":"Delivery Date","Description":"Description","Deselect all above":"Deselect all above","Direction":"Direction","Discount":"Discount","Discount (number or % only)":"Discount (number or % only)","Discount Section":"Discount Section","Due Payment Requests":"Due Payment Requests","Edit":"Edit","Email":"Email","Email Sent":"Email Sent","Embrace Section":"Embrace Section","Enable Auto Notifications":"Enable Auto Notifications","Enable PayU India Payments (\u20b9)":"Enable PayU India Payments (\u20b9)","Enable Stripe Payments":"Enable Stripe Payments","Encryption":"Encryption","End Date":"End Date","Error Occurred":"Error Occurred","Expense":"Expense|Expenses","FAQ":"FAQ","FAQ Section":"FAQ Section","Facebook Link":"Facebook Link","Field":"Field|Fields","Filter":"Filter","Fit":"Fit","Footer Section":"Footer Section","Footer Text":"Footer Text","Forget password?":"Forget password?","Forgot Password":"Forgot Password","From Email":"From Email","From Name":"From Name","Full Name":"Full Name","Gallery":"Gallery|Galleries","Gallery Section":"Gallery Section","Gateway":"Gateway","Gateway Transaction Id":"Gateway Transaction Id","Gateways":"Gateways","General":"General","Get Report":"Get Report","Go Back":"Go Back","Go back to Home":"Go back to Home","Grand Total":"Grand Total","Height":"Height","Hello":"Hello","Hero Section":"Hero Section","High":"High","Hips":"Hips","I am receiving this amount":"I am receiving this amount","Icon":"Icon","Image":"Image","Inside Leg":"Inside Leg","Instagram Link":"Instagram Link","Instagram Section":"Instagram Section","Item \/ Details":"Item \/ Details","Journal already exists.":"Journal already exists.","Language":"Language","Limited Section":"Limited Section","Locale for date & number":"Locale for date & number","Log":"Log|Logs","Login":"Login","Login as":"Login as","Logo":"Logo","Logout":"Logout","Mail Driver":"Mail Driver","Mailgun Domain":"Mailgun Domain","Mailgun Endpoint":"Mailgun Endpoint","Mailgun Secret":"Mailgun Secret","Main Image":"Main Image","Main Photo":"Main Photo","Main Title":"Main Title","Measure":"Measure","Measurement":"Measurement|Measurements","Measurement Field":"Measurement Field|Measurement Fields","Measurement No":"Measurement No {x}","Measurement Number":"Measurement Number","Mirrorsize API Key":"Mirrorsize API Key","Mirrorsize Merchant ID":"Mirrorsize Merchant ID","Mirrorsize Username":"Mirrorsize Username","Monezium Shop Key":"Monezium Shop Key","Monezium Site Key":"Monezium Site Key","Month Overview Chart":"Month Overview Chart","My Profile":"My Profile","Name":"Name","Neck":"Neck","Nexmo API Key":"Nexmo API Key","Nexmo API Secret":"Nexmo API Secret","Nexmo SMS From":"Nexmo SMS From","Nexmo Signature Secret":"Nexmo Signature Secret","Next":"Next","No":"No","No new order today":"No new order today","No order delivery today":"No order delivery today","Normal":"Normal","Not received yet":"Not received yet","Notify":"Notify","Okay":"Okay","Only Trashed":"Only Trashed","Opening Balance":"Opening Balance","Option":"Option","Options":"Options","Order":"Order|Orders","Order Amount":"Order Amount","Order Date":"Order Date","Order Footer":"Order Footer","Order Header":"Order Header","Order No":"Order No","Order Number":"Order Number {x}","Order has been sent to the customer email address":"Order has been sent to the customer email address","Order is already marked as completed.":"Order is already marked as completed.","Other":"Other","Outcome":"Outcome","Owner":"Owner","Owner Links":"Owner Links","Page":"Page|Pages","Page Links":"Page Links","Paid":"Paid","Paid by":"Paid by","Password":"Password","PayU Account":"PayU Account","PayU Authorization Token":"PayU Authorization Token","PayU Biz Key":"PayU Biz Key","PayU Biz Salt":"PayU Biz Salt","PayU Gateway":"PayU Gateway","PayU Mode":"PayU Mode","PayU Money Auth":"PayU Money Auth","PayU Money Key":"PayU Money Key","PayU Money Salt":"PayU Money Salt","PayU payment failed! gateway reponse has been logged to latest log file in storage\/logs\/ folder.":"PayU payment failed! gateway reponse has been logged to latest log file in storage\/logs\/ folder.","Payment":"Payment|Payments","Payment No":"Payment No","Payment Note":"Payment Note","Payment Number":"Payment Number {x}","Payment has been already received.":"Payment has been already received.","Pending":"Pending","Person name with services name i.e, John's Son Blazer, Mike Kurta or Shalini Blouse etc":"Person name with services name i.e, John's Son Blazer, Mike Kurta or Shalini Blouse etc","Phone":"Phone","Photo":"Photo","Please add at least one service to order by selecting from above dropdown.":"Please add at least one service to order by selecting from above dropdown.","Please login to access your account":"Please login to access your account","Please make sure that you have filled all Mail & Nexmo settings correctly before enabling the notifications.":"Please make sure that you have filled all Mail & Nexmo settings correctly before enabling the notifications.","Please select the customer first":"Please select the customer first","Please type details to reset password":"Please type details to reset password","Please type email to get reset instructions":"Please type email to get reset instructions","Postmark Token":"Postmark Token","Preparing":"Preparing","Preview":"Preview","Previous":"Previous","Price":"Price","Priority":"Priority","Product":"Product|Products","Product Order":"Product Order|Product Orders","Properties":"Properties","Qty":"Qty","Rate":"Rate","Ready":"Ready","Rear Type":"Rear Type","Received":"Received","Record per page":"Record per page","Ref":"Ref","Reference":"Reference","Remember Me":"Remember Me","Remove":"Remove","Report":"Report|Reports","Request Reset":"Request Reset","Request expired! please try again.":"Request expired! please try again.","Request has been failed, please check the logs in storage folder and contact developer.":"Request has been failed, please check the logs in storage folder and contact developer.","Required":"Required","Reset":"Reset","Restore":"Restore","Role":"Role","SES Key":"SES Key","SES Region":"SES Region","SES Secret":"SES Secret","SMS":"SMS","SMS Sent":"SMS Sent","SMS has been successfully sent to customer.":"SMS has been successfully sent to customer.","SMTP Host":"SMTP Host","SMTP Password":"SMTP Password","SMTP Port":"SMTP Port","SMTP Username":"SMTP Username","Salary":"Salary|Salaries","Same":"Same","Search":"Search","Search product to add to order":"Search product to add to order","Search service to add to order":"Search service to add to order","Select File":"Select File","Select all above":"Select all above","Send":"Send","Send SMS to Customer":"Send SMS to Customer","Service":"Service|Services","Service Content Section":"Service Content Section","Service Order":"Service Order|Service Orders","Service Section":"Service Section","Setting":"Setting|Settings","Shipping":"Shipping","Shipping Address":"Shipping Address","Shoulder Type":"Shoulder Type","Shoulders":"Shoulders","Show Form":"Show Form","Slide":"Slide|Slides","Sorry, the page you are looking for could not be found.":"Sorry, the page you are looking for could not be found.","Sorry, we are doing some maintenance. Please check back soon.":"Sorry, we are doing some maintenance. Please check back soon.","Sorry, you are forbidden from accessing this page.":"Sorry, you are forbidden from accessing this page.","Staff":"Staff","Start Date":"Start Date","State":"State","Status":"Status","Stomach":"Stomach","Stomach Type":"Stomach Type","Story Section":"Story Section","Stripe Currency (ISO code, USD, EUR etc)":"Stripe Currency (ISO code, USD, EUR etc)","Stripe Publishable Key":"Stripe Publishable Key","Stripe Secret Key":"Stripe Secret Key","Stripe payment failed":"Stripe payment failed","Sub Image":"Sub Image","Sub Photo":"Sub Photo","Sub Title":"Sub Title","Subject":"Subject","Subscribe Section":"Subscribe Section","Success!":"Success!","System is unable to send sms, please check logs in storage directory.":"System is unable to send sms, please check logs in storage directory.","System is unable to sent email, either customer do not have email or system settings are not correct.":"System is unable to sent email, either customer do not have email or system settings are not correct.","Tag":"Tag","Tailor":"Tailor","Tax":"Tax|Taxes","Tax Amount":"Tax Amount","Testimonial Section":"Testimonial Section","Thigh":"Thigh","This actions is not allowed on the demo.":"This actions is not allowed on the demo.","This field is required":"This field is required","This is a computer-generated document. No signature is required.":"This is a computer-generated document. No signature is required.","This is compound tax (apply after other taxes)":"This is compound tax (apply after other taxes)","This is state related tax":"This is state related tax","This tax applies to same states (business & customer)":"This tax applies to same states (business & customer)","Timezone":"Timezone","Title":"Title","Today Deliveries":"Today's Deliveries","Today Orders":"Today's Orders","Total":"Total","Total Assigned Order Amount":"Total Assigned Order Amount","Total Order Amount":"Total Order Amount","Total Orders":"Total Orders","Total Orders Assigned":"Total Orders Assigned","Total Tax Amount":"Total Tax Amount","Transaction":"Transaction|Transactions","Trashed":"Trashed","Twitter Link":"Twitter Link","Type":"Type | Types","Type Name":"Type Name","Type to search services":"Type to search services","Update":"Update","Updated Date":"Updated Date","Urgent":"Urgent","User":"User|Users","User has been logged in":"User has been logged in","User has sent sms.":"User has sent sms.","User is not active, please check with admin.":"User is not active, please check with admin.","User is trying to send sms.":"User is trying to send sms.","Username":"Username","Username\/Email":"Username\/Email","Username_Email":"Username\/Email","View":"View","View Order Photo":"View Order Photo","Vonage API Key":"Vonage API Key","Vonage API Secret":"Vonage API Secret","Vonage SMS From":"Vonage SMS From","Vonage Signature Secret":"Vonage Signature Secret","Waistline":"Waistline","Weight":"Weight","Whoops, please refresh the page then try again.":"Whoops, please refresh the page then try again.","Whoops, something went wrong on our servers.":"Whoops, something went wrong on our servers.","With Trashed":"With Trashed","Wrist":"Wrist","Year Overview Chart":"Year Overview Chart","Yes":"Yes","You are not allowed to access the resource.":"You are not allowed to access the resource.","You can not delete your own account.":"You can not delete your own account.","Zipcode":"Zipcode","about_us":"About Us","action":"Action","add_to_cart":"Add To Cart","add_x":"Add {x}","address":"Address","all":"All","already_deleted_x":"This {x} is marked as deleted.","anatomic_measures":"Anatomic Measures","arm":"Arm|Arms","arm_length":"Arm Length","ask_delete_x":"Are you sure you want to delete this {x}?","ask_final_delete_x":"Are you sure you want to permanently delete this {x}?","ask_retore_x":"Are you sure you want to restore this {x}?","ask_update_status_x":"Are you sure to update status to {x}?","automatically":"Automatically","back":"Back","back_length":"Back Length","back_to_top":"Back to top","back_type":"Back Type","biceps":"Bicep|Biceps","billing_address":"Billing Address","bonus":"Bonus","by":"by","cancel":"Cancel","cart":"Cart","carts":"Carts","category":"Category|Categories","certified_email":"Certified Email","change":"Change|Changes","change_x":"Change :x","checkout":"Checkout","chest":"Chest","chest_type":"Chest Type","chiselled":"Chiselled","circumference":"Circumference","city":"City","clothes":"Clothes","comfort":"Comfort","comment":"Comment","confirm":"Confirm","confirm_pass":"Confirm Password","confirm_vonage_setting":"Please make sure that you have filled all Mail & Vonage settings correctly before enabling the notifications.","contact_us":"Contact Us","country":"Country","create_x":"Create {x}","created_at":"Created At","current_pass":"Current Password","curved":"Curved","custom_field":"Customization Field|Customization Fields","customfield":"customfield|customfields","customization_preview_x":"Preview Image for {x} customization","customize_product":"Customize Product","customized_success":"Product is customized successfully.","default":"Default","delete_confirm":"Are you sure you want to delete the record?","delete_x":"Delete {x}","delivery_date":"Delivery Date","description":"Description","details_x":":x Details","discout":"Discout","dob":"Date Of Birth","due_in_x":"Due in {x} days","edit":"Edit","edit_x":"Edit {x}","enter_x":"Enter :x","error_message":"There is one form error.|There are {x} form errors.","estimation":"Estimation","faq":"FAQ","fiscalcode":"FiscalCode","fit":"Fit","flat":"Flat","free_charge":"Free of charge","front_image":"Front Image","frontend":"Frontend","fullname":"FullName","gateway":"Gateway","grand_total":"Grand Total","height":"Height","high":"High","hip":"Hip|Hips","home":"Home","inside_leg":"Inside Leg","inside_length":"Inside Length","item":"{0} Items|{1} Item|[2,*] Items","length":"Length","level_changed":"Level has been successfully changed.","loose":"Loose","low":"Low","manually":"Manually","mark_as_x":"Mark as {x}","measure":"Measure|Measures","measure_updated_at_x":"Measures updated at :x","measurement":"Measurement|Measurements","men":"Men","minutes_ago":"{1} :value minute ago|[2,*] :value minutes ago","mobile_model":"Mobile Model","model_can_not_deleted":":model can not be deleted because it is assigned or used with other data such as :data.","model_created":":model has been successfully created.","model_deleted":":model has been successfully deleted.","model_marked":":model has been successfully marked as :status.","model_restored":":model has been successfully restored.","model_updated":":model has been successfully updated.","more_info":"More Info","my_account":"My Account","my_carts":"My Carts","my_favorites":"My Favorites","my_measures":"My Measures","my_profile_x":"My Profile {x}","name":"Name","neck":"Neck","new_pass":"New Password","new_x":"New {x}","new_y":"New :y","next":"Next","no_favorites":"Sorry, no favorites exist at this time.","no_measurement":"There is no measurement info, please set your measurement.","no_x_found":"No {x} Found.","normal":"Normal","ok":"OK","order":"Order|Orders","order_date":"Order Date","order_no":"Order No","order_now":"Order Now","order_service":"Order Service","pagination_info_text":"Showing from {from} to {to} of total {total}","password":"Password","payment":"Payment","payment_no_x":"Payment No {x}","permanent_delete_confirm":"Are you sure you want to delete the record permanently?","permanent_delete_warning":"Once deleted, all of its resources and data will be permanently deleted.","phone":"Phone","phone_number":"Phone Number","photo":"Photo","please_select_x":"Please select your :x information.","prev":"Prev","preview_image":"Preview Image","price":"Price","priority":"Priority","product":"Product","product_details":"Product Details","product_orders":"Product Orders","profile":"Profile","protruding":"Protruding","qty":"Qty","quantity":"Quantity","rear_type":"Rear Type","recipientcode":"RecipientCode","reference":"Reference","regular":"Regular","related":"Related","reset":"Reset","restore_confirm":"Are you sure you want to restore the record?","retore_x":"Restore {x}","robust":"Robust","save":"Save","save_x":"Save {x}","save_y":"Save :y","saved_products":"Saved Products","search_x":"Search {x}","select":"Select","select_x":"Select {x}","sending_to_html":"Sending to <strong>{name}<\/strong> on <strong>{phone}<\/strong>","service":"Service|Services","service_orders":"Service Orders","set":"Set","shipping":"Shipping","shipping_address":"Shipping Address","shop_by_category":"Shop by our category","shop_men":"Shop Men","shop_women":"Shop Women","shoulder":"Shoulder|Shoulders","shoulder_type":"Shoulder Type","show_x":"Show {x}","showing_x":"Showing {from} to {to} of {total} records","side_image":"Side Image","slim":"Slim","sort_by":"Sort by","state":"State","status":"Status","stomach":"Stomach","stomach_type":"Stomach Type","straight":"Straight","submit":"Submit","surname":"Surname","tax":"Tax|Taxes","taxcode":"TaxCode","thigh":"Thigh","tight":"Tight","title":"Title","total":"Total","total_price":"Total Price","type":"Type","update_status_x":"Update status to {x}?","update_x":"Update {x}","urgent":"Urgent","vatcode":"VatCode","waistline":"Waistline","warning":"Warning","weight":"Weight","width":"Width","women":"Women","wrist":"Wrist","your_measurement_info":"Your Measurement Info","your_order":"Your Order","zipcode":"ZipCode"},"en.validation":{"accepted":"The :attribute must be accepted.","accepted_if":"The :attribute must be accepted when :other is :value.","active_url":"The :attribute is not a valid URL.","after":"The :attribute must be a date after :date.","after_or_equal":"The :attribute must be a date after or equal to :date.","alpha":"The :attribute must only contain letters.","alpha_dash":"The :attribute must only contain letters, numbers, dashes and underscores.","alpha_num":"The :attribute must only contain letters and numbers.","array":"The :attribute must be an array.","attributes":[],"before":"The :attribute must be a date before :date.","before_or_equal":"The :attribute must be a date before or equal to :date.","between":{"array":"The :attribute must have between :min and :max items.","file":"The :attribute must be between :min and :max kilobytes.","numeric":"The :attribute must be between :min and :max.","string":"The :attribute must be between :min and :max characters."},"boolean":"The :attribute field must be true or false.","confirmed":"The :attribute confirmation does not match.","current_password":"The password is incorrect.","custom":{"attribute-name":{"rule-name":"custom-message"}},"date":"The :attribute is not a valid date.","date_equals":"The :attribute must be a date equal to :date.","date_format":"The :attribute does not match the format :format.","declined":"The :attribute must be declined.","declined_if":"The :attribute must be declined when :other is :value.","different":"The :attribute and :other must be different.","digits":"The :attribute must be :digits digits.","digits_between":"The :attribute must be between :min and :max digits.","dimensions":"The :attribute has invalid image dimensions.","distinct":"The :attribute field has a duplicate value.","doesnt_start_with":"The :attribute may not start with one of the following: :values.","email":"The :attribute must be a valid email address.","ends_with":"The :attribute must end with one of the following: :values.","enum":"The selected :attribute is invalid.","exists":"The selected :attribute is invalid.","file":"The :attribute must be a file.","filled":"The :attribute field must have a value.","gt":{"array":"The :attribute must have more than :value items.","file":"The :attribute must be greater than :value kilobytes.","numeric":"The :attribute must be greater than :value.","string":"The :attribute must be greater than :value characters."},"gte":{"array":"The :attribute must have :value items or more.","file":"The :attribute must be greater than or equal to :value kilobytes.","numeric":"The :attribute must be greater than or equal to :value.","string":"The :attribute must be greater than or equal to :value characters."},"image":"The :attribute must be an image.","in":"The selected :attribute is invalid.","in_array":"The :attribute field does not exist in :other.","integer":"The :attribute must be an integer.","ip":"The :attribute must be a valid IP address.","ipv4":"The :attribute must be a valid IPv4 address.","ipv6":"The :attribute must be a valid IPv6 address.","json":"The :attribute must be a valid JSON string.","lt":{"array":"The :attribute must have less than :value items.","file":"The :attribute must be less than :value kilobytes.","numeric":"The :attribute must be less than :value.","string":"The :attribute must be less than :value characters."},"lte":{"array":"The :attribute must not have more than :value items.","file":"The :attribute must be less than or equal to :value kilobytes.","numeric":"The :attribute must be less than or equal to :value.","string":"The :attribute must be less than or equal to :value characters."},"mac_address":"The :attribute must be a valid MAC address.","max":{"array":"The :attribute must not have more than :max items.","file":"The :attribute must not be greater than :max kilobytes.","numeric":"The :attribute must not be greater than :max.","string":"The :attribute must not be greater than :max characters."},"mimes":"The :attribute must be a file of type: :values.","mimetypes":"The :attribute must be a file of type: :values.","min":{"array":"The :attribute must have at least :min items.","file":"The :attribute must be at least :min kilobytes.","numeric":"The :attribute must be at least :min.","string":"The :attribute must be at least :min characters."},"multiple_of":"The :attribute must be a multiple of :value.","not_in":"The selected :attribute is invalid.","not_regex":"The :attribute format is invalid.","numeric":"The :attribute must be a number.","password":{"letters":"The :attribute must contain at least one letter.","mixed":"The :attribute must contain at least one uppercase and one lowercase letter.","numbers":"The :attribute must contain at least one number.","symbols":"The :attribute must contain at least one symbol.","uncompromised":"The given :attribute has appeared in a data leak. Please choose a different :attribute."},"present":"The :attribute field must be present.","prohibited":"The :attribute field is prohibited.","prohibited_if":"The :attribute field is prohibited when :other is :value.","prohibited_unless":"The :attribute field is prohibited unless :other is in :values.","prohibits":"The :attribute field prohibits :other from being present.","regex":"The :attribute format is invalid.","required":"The :attribute field is required.","required_array_keys":"The :attribute field must contain entries for: :values.","required_if":"The :attribute field is required when :other is :value.","required_unless":"The :attribute field is required unless :other is in :values.","required_with":"The :attribute field is required when :values is present.","required_with_all":"The :attribute field is required when :values are present.","required_without":"The :attribute field is required when :values is not present.","required_without_all":"The :attribute field is required when none of :values are present.","same":"The :attribute and :other must match.","size":{"array":"The :attribute must contain :size items.","file":"The :attribute must be :size kilobytes.","numeric":"The :attribute must be :size.","string":"The :attribute must be :size characters."},"starts_with":"The :attribute must start with one of the following: :values.","string":"The :attribute must be a string.","timezone":"The :attribute must be a valid timezone.","unique":"The :attribute has already been taken.","uploaded":"The :attribute failed to upload.","url":"The :attribute must be a valid URL.","uuid":"The :attribute must be a valid UUID."},"languages.strings":{"available":[{"flag":"US","label":"English","value":"en"},{"flag":"LV","label":"Latvian","value":"lv"}],"instruction":"App dropdown uses the below available array."},"lv.auth":[],"lv.message":[],"lv.pagination":[],"lv.passwords":[],"lv.strings":[],"lv.validation":[]});
})();
