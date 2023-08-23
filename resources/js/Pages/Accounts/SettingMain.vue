<template>
  <div class="bg-white rounded shadow overflow-hidden max-w-3xl">
    <form @submit.prevent="submit" autocomplete="off">
      <div class="p-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap">
        <text-input v-model="form.name" :errors="$page.props.errors?.name" class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"
          :label="$t('Name')" />
        <text-input :label="$t('Phone')" v-model="form.phone" :errors="$page.props.errors?.phone"
          class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2" />
        <text-input :label="$t('email')" v-model="form.email" :errors="$page.props.errors?.email"
          class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2" />
        <text-input min="10" max="100" type="number" v-model="form.per_page" :label="$t('Record per page')"
          :errors="$page.props.errors?.per_page" class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2" />
        <div class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2">
          <label class="form-label" for="fraction">{{ $t('Decimals') }}</label>
          <v-select transition="" :clearable="false" input-id="fraction" v-model="form.fraction"
            :options="[0, 1, 2, 3, 4]" :dir="$page.props.user.account.direction"
            :placeholder="$t('select_x', { x: $t('Decimals') })">
          </v-select>
          <div v-if="$page.props.errors?.fraction" class="form-error">{{ errors.fraction[0] }}</div>
        </div>
        <file-input type="file" accept="image/*" :label="$t('Logo')" v-model="form.logo"
          :errors="$page.props.errors?.logo" class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2" />
        <div class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2">
          <label class="form-label" for="default_tax">{{ $t('Default Tax') }}</label>
          <v-select :value="tax" transition="" :options="taxes" @input="taxChanged" input-id="default_tax"
            @option:selected="taxChanged" :dir="$page.props.user.account.direction"
            :placeholder="$t('select_x', { x: $t('Default Tax') })"></v-select>
          <div v-if="$page.props.errors?.default_tax" class="form-error">{{ errors.default_tax[0] }}</div>
        </div>
        <div v-if="account.logo_path" class="mb-4 ltr:mr-6 rtl:ml-6 p-4 w-full border rounded text-center">
          <img :src="`/storage/account/${account.logo_path}`" :alt="account.name" />
        </div>
        <div class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2">
          <label class="form-label" for="language">{{ $t('Language') }}</label>
          <v-select transition="" v-model="language" :clearable="false" input-id="language" @input="langChanged"
            @option:selected="langChanged" :options="$page.props.locales" :dir="$page.props.user.account.direction"
            :placeholder="$t('select_x', { x: $t('Language') })">
          </v-select>
          <div v-if="$page.props.errors?.language" class="form-error">{{ errors.language[0] }}</div>
        </div>
        <text-input type="text" v-model="form.default_locale" :label="$t('Locale for date & number')"
          :errors="$page.props.errors?.default_locale" class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2" />
        <div class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2">
          <label class="form-label" for="direction">{{ $t('Direction') }}</label>
          <v-select transition="" :clearable="false" input-id="direction" v-model="form.direction"
            :options="['ltr', 'rtl']" :dir="$page.props.user.account.direction"
            :placeholder="$t('select_x', { x: $t('Direction') })">
            <template #option="{ label }">
              <span class="uppercase">{{ label }}</span>
            </template>
          </v-select>
          <div v-if="$page.props.errors?.direction" class="form-error">{{ errors.direction[0] }}</div>
        </div>
        <text-input :label="$t('Gateways')" v-model="form.gateways" :errors="$page.props.errors?.gateways"
          class="ltr:pr-6 rtl:pl-6 pb-8 w-full" />
        <text-input v-model="form.address" :errors="$page.props.errors?.address" class="ltr:pr-6 rtl:pl-6 pb-8 w-full"
          :label="$t('Address')" />
        <textarea-input v-model="form.header" :errors="$page.props.errors?.header" class="ltr:pr-6 rtl:pl-6 pb-8 w-full"
          :label="$t('Order Header')" />
        <textarea-input v-model="form.footer" :errors="$page.props.errors?.footer" class="ltr:pr-6 rtl:pl-6 pb-8 w-full"
          :label="$t('Order Footer')" />
        <div class="w-full"></div>
        <!-- <text-input v-model="form.MAIL_MAILER" :errors="$page.props.errors?.MAIL_MAILER" class="ltr:pr-6 rtl:pl-6 pb-8 w-full" label="Mail Driver" /> -->
        <div class="ltr:pr-6 rtl:pl-6 pb-8 w-full">
          <label class="form-label" for="timezone">{{ $t('Timezone') }}</label>
          <v-select :clearable="false" v-model="timezone" :options="timezones" :dir="$page.props.user.account.direction"
            :placeholder="$t('select_x', { x: $t('Timezone') })"
            :class="{ error: errors.APP_TIMEZONE && errors.APP_TIMEZONE.length }">
            <template #option="option">
              <span class="text-sm" :key="option.value">{{ option.label }}</span>
            </template>
          </v-select>
          <div v-if="$page.props.errors?.APP_TIMEZONE" class="form-error">{{ errors.APP_TIMEZONE[0] }}</div>
        </div>
        <text-input :label="$t('From Name')" v-model="form.MAIL_FROM_NAME" :errors="$page.props.errors?.MAIL_FROM_NAME"
          class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2" />
        <text-input :label="$t('From Email')" v-model="form.MAIL_FROM_ADDRESS"
          :errors="$page.props.errors?.MAIL_FROM_ADDRESS" class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2" />
        <div class="ltr:pr-6 rtl:pl-6 pb-8 w-full">
          <label class="form-label" for="mail_driver">{{ $t('Mail Driver') }}</label>
          <v-select :searchable="false" :clearable="false" :filterable="false" v-model="form.MAIL_MAILER"
            :dir="$page.props.user.account.direction" :options="['smtp', 'mailgun', 'postmark', 'ses']"
            :placeholder="$t('select_x', { x: $t('Mail Driver') })"
            :class="{ error: errors.MAIL_MAILER && errors.MAIL_MAILER.length }"></v-select>
          <div v-if="$page.props.errors?.MAIL_MAILER" class="form-error">{{ errors.MAIL_MAILER[0] }}</div>
        </div>
        <div class="w-full"></div>
        <transition-group tag="div" name="slide-fade" v-if="form.MAIL_MAILER"
          class="w-full bg-gray-200 rounded border px-4 pt-4 mb-6 ltr:mr-6 rtl:ml-6">
          <div class="ml-3 mt-2 w-full" key="postmark" v-if="form.MAIL_MAILER == 'postmark'">
            <text-input class="ltr:pr-6 rtl:pl-6 pb-8 w-full" :label="$t('Postmark Token')" v-model="form.POSTMARK_TOKEN"
              :errors="$page.props.errors?.POSTMARK_TOKEN" />
          </div>
          <div class="ml-3 mt-2 flex flex-wrap w-full" key="mailgun" v-else-if="form.MAIL_MAILER == 'mailgun'">
            <text-input v-model="form.MAILGUN_DOMAIN" :errors="$page.props.errors?.MAILGUN_DOMAIN"
              class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2" :label="$t('Mailgun Domain')" />
            <text-input v-model="form.MAILGUN_SECRET" :errors="$page.props.errors?.MAILGUN_SECRET"
              class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2" :label="$t('Mailgun Secret')" />
            <text-input v-model="form.MAILGUN_ENDPOINT" :errors="$page.props.errors?.MAILGUN_ENDPOINT"
              class="ltr:pr-6 rtl:pl-6 pb-8 w-full" :label="$t('Mailgun Endpoint')" />
          </div>
          <div class="ml-3 mt-2 flex flex-wrap w-full" key="ses" v-else-if="form.MAIL_MAILER == 'ses'">
            <text-input v-model="form.AWS_ACCESS_KEY_ID" :errors="$page.props.errors?.AWS_ACCESS_KEY_ID"
              class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2" :label="$t('SES Key')" />
            <text-input v-model="form.AWS_SECRET_ACCESS_KEY" :errors="$page.props.errors?.AWS_SECRET_ACCESS_KEY"
              class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2" :label="$t('SES Secret')" />
            <text-input v-model="form.AWS_DEFAULT_REGION" :errors="$page.props.errors?.AWS_DEFAULT_REGION"
              class="ltr:pr-6 rtl:pl-6 pb-8 w-full" :label="$t('SES Region')" />
          </div>
          <div class="ml-3 mt-2 flex flex-wrap w-full" key="smtp" v-else-if="form.MAIL_MAILER == 'smtp'">
            <text-input v-model="form.MAIL_HOST" :errors="$page.props.errors?.MAIL_HOST"
              class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-2/4" :label="$t('SMTP Host')" />
            <text-input v-model="form.MAIL_PORT" :errors="$page.props.errors?.MAIL_PORT"
              class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/4" :label="$t('SMTP Port')" />
            <text-input :label="$t('Encryption')" v-model="form.MAIL_ENCRYPTION"
              class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/4" :errors="$page.props.errors?.MAIL_ENCRYPTION" />
            <text-input :label="$t('SMTP Username')" v-model="form.MAIL_USERNAME"
              class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2" :errors="$page.props.errors?.MAIL_USERNAME" />
            <text-input :label="$t('SMTP Password')" v-model="form.MAIL_PASSWORD"
              class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2" :errors="$page.props.errors?.MAIL_PASSWORD" />
          </div>
        </transition-group>

        <text-input v-model="form.VONAGE_KEY" :label="$t('Vonage API Key')" class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"
          :errors="$page.props.errors?.VONAGE_KEY" />
        <text-input v-model="form.VONAGE_SECRET" :label="$t('Vonage API Secret')"
          class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2" :errors="$page.props.errors?.VONAGE_SECRET" />
        <text-input v-model="form.SMS_FROM" :label="$t('Vonage SMS From')" class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"
          :errors="$page.props.errors?.SMS_FROM" />
        <text-input :label="$t('Vonage Signature Secret')" v-model="form.VONAGE_SIGNATURE_SECRET"
          class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2" :errors="$page.props.errors?.VONAGE_SIGNATURE_SECRET" />
        <text-input v-model="form.MIRRORSIZE_MERCHANT_ID" :label="$t('Mirrorsize Merchant ID')"
          class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2" :errors="$page.props.errors?.MIRRORSIZE_MERCHANT_ID" />
        <text-input v-model="form.MIRRORSIZE_USERNAME" :label="$t('Mirrorsize Username')"
          class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2" :errors="$page.props.errors?.MIRRORSIZE_USERNAME" />
        <text-input v-model="form.MIRRORSIZE_API_KEY" :label="$t('Mirrorsize API Key')"
          class="ltr:pr-6 rtl:pl-6 pb-8 w-full" :errors="$page.props.errors?.MIRRORSIZE_API_KEY" />
        <text-input v-model="form.MONEZIUM_SITE_KEY" :label="$t('Monezium Site Key')"
          class="ltr:pr-6 rtl:pl-6 pb-8 w-full" :errors="$page.props.errors?.MONEZIUM_SITE_KEY" />
        <text-input v-model="form.MONEZIUM_SHOP_KEY" :label="$t('Monezium Shop Key')"
          class="ltr:pr-6 rtl:pl-6 pb-8 w-full" :errors="$page.props.errors?.MONEZIUM_SHOP_KEY" />
        <text-input v-model="form.SOCKET_SERVER_URL" :label="$t('Socket Server Url')"
          class="ltr:pr-6 rtl:pl-6 pb-8 w-full" :errors="$page.props.errors?.SOCKET_SERVER_URL" />
        <div class="flex items-center flex-wrap mb-6 gap-x-6">
          <p class="text-sm mb-2">{{ $t('Enable Auto Notifications') }}</p>
          <checkbox-input class="mb-2" id="email_enabled" :label="$t('By Email')" v-model:checked="form.email_enabled"
            :checked="form.email_enabled"></checkbox-input>
          <checkbox-input class="mb-2" id="sms_enabled" :label="$t('By SMS')" v-model:checked="form.sms_enabled"
            :checked="form.sms_enabled"></checkbox-input>
        </div>
        <p class="mb-8 -mt-2 text-xs font-bold text-orange-600">
          {{ $t('confirm_vonage_setting') }}
        </p>
      </div>
      <div class="px-8 -mt-8 mb-10 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 flex flex-wrap">
        <checkbox-input id="stripe" class="mb-2" v-model:checked="form.stripe" :checked="form.stripe"
          :label="$t('Enable Stripe Payments')"></checkbox-input>
        <transition name="slide-fade" class="w-full bg-gray-200 rounded border px-4 pt-4 mb-6 ltr:mr-6 rtl:ml-6">
          <div v-if="form.stripe" class="w-full mt-6">
            <text-input v-model="form.STRIPE_KEY" :errors="$page.props.errors?.STRIPE_KEY"
              class="ltr:pr-6 rtl:pl-6 pb-8 w-full" :label="$t('Stripe Publishable Key')" />
            <text-input v-model="form.STRIPE_SECRET" :errors="$page.props.errors?.STRIPE_SECRET"
              class="ltr:pr-6 rtl:pl-6 pb-8 w-full" :label="$t('Stripe Secret Key')" />
            <text-input v-model="form.STRIPE_CURRENCY" :errors="$page.props.errors?.STRIPE_CURRENCY"
              class="ltr:pr-6 rtl:pl-6 pb-8 w-full" :label="$t('Stripe Currency (ISO code, USD, EUR etc)')" />
          </div>
        </transition>
      </div>
      <div class="px-8 py-4 bg-gray-100 border-t border-gray-200 flex items-center">
        <loading-button :loading="sending" class="btn-gray ltr:ml-auto rtl:mr-auto" type="submit">
          {{ $t('update_x', { x: $tc('Setting', 2) }) }}
        </loading-button>
      </div>
    </form>
  </div>
</template>
  
<script>
import FileInput from '@/Shared/FileInput.vue';
import TextInput from '@/Shared/TextInput.vue';
import CheckboxInput from '@/Shared/CheckboxInput.vue';
import TextareaInput from '@/Shared/TextareaInput.vue';
import LoadingButton from '@/Shared/LoadingButton.vue';

export default {
  remember: 'form',
  props: { taxes: Array, account: Object, timezones: Array },
  components: { FileInput, LoadingButton, CheckboxInput, TextInput, TextareaInput },
  data() {
    return {
      errors: {},
      error: null,
      message: null,
      sending: false,
      timezone: { label: '', value: '' },
      form: {
        logo: null,
        name: this.account.name,
        email: this.account.email,
        phone: this.account.phone,
        address: this.account.address,
        gateways: this.account.gateways,
        header: this.account.header,
        footer: this.account.footer,
        fraction: this.account.fraction,
        per_page: this.account.per_page,
        language: this.account.language,
        direction: this.account.direction,
        default_tax: this.account.default_tax,
        default_locale: this.account.default_locale,
        APP_TIMEZONE: this.account.APP_TIMEZONE,
        MAIL_FROM_NAME: this.account.MAIL_FROM_NAME,
        MAIL_FROM_ADDRESS: this.account.MAIL_FROM_ADDRESS,
        MAIL_MAILER: this.account.MAIL_MAILER,
        MAIL_HOST: this.account.MAIL_HOST,
        MAIL_PORT: this.account.MAIL_PORT,
        MAIL_ENCRYPTION: this.account.MAIL_ENCRYPTION,
        MAIL_USERNAME: this.account.MAIL_USERNAME,
        MAIL_PASSWORD: this.account.MAIL_PASSWORD,
        STRIPE_KEY: this.account.STRIPE_KEY,
        STRIPE_SECRET: this.account.STRIPE_SECRET,
        STRIPE_CURRENCY: this.account.STRIPE_CURRENCY,
        PAYU_DEFAULT_GATEWAY: this.account.PAYU_DEFAULT_GATEWAY,
        PAYU_BIZ_KEY: this.account.PAYU_BIZ_KEY,
        PAYU_BIZ_SALT: this.account.PAYU_BIZ_SALT,
        PAYU_BIZ_MODE: this.account.PAYU_BIZ_MODE,
        PAYU_MONEY_KEY: this.account.PAYU_MONEY_KEY,
        PAYU_MONEY_SALT: this.account.PAYU_MONEY_SALT,
        PAYU_MONEY_AUTH: this.account.PAYU_MONEY_AUTH,
        PAYU_MONEY_MODE: this.account.PAYU_MONEY_MODE,
        SMS_FROM: this.account.SMS_FROM,
        VONAGE_KEY: this.account.VONAGE_KEY,
        VONAGE_SECRET: this.account.VONAGE_SECRET,
        VONAGE_SIGNATURE_SECRET: this.account.VONAGE_SIGNATURE_SECRET,
        VONAGE_APP_NAME: this.account.VONAGE_APP_NAME,
        VONAGE_APP_VERSION: this.account.VONAGE_APP_VERSION,
        MIRRORSIZE_API_KEY: this.account.MIRRORSIZE_API_KEY,
        MIRRORSIZE_MERCHANT_ID: this.account.MIRRORSIZE_MERCHANT_ID,
        MIRRORSIZE_USERNAME: this.account.MIRRORSIZE_USERNAME,
        MONEZIUM_SITE_KEY: this.account.MONEZIUM_SITE_KEY,
        MONEZIUM_SHOP_KEY: this.account.MONEZIUM_SHOP_KEY,
        SOCKET_SERVER_URL: this.account.SOCKET_SERVER_URL,
        MAILGUN_DOMAIN: this.account.MAILGUN_DOMAIN,
        MAILGUN_SECRET: this.account.MAILGUN_SECRET,
        MAILGUN_ENDPOINT: this.account.MAILGUN_ENDPOINT,
        POSTMARK_TOKEN: this.account.POSTMARK_TOKEN,
        AWS_ACCESS_KEY_ID: this.account.AWS_ACCESS_KEY_ID,
        AWS_SECRET_ACCESS_KEY: this.account.AWS_SECRET_ACCESS_KEY,
        AWS_DEFAULT_REGION: this.account.AWS_DEFAULT_REGION,
        stripe: this.account.stripe == 1 ? true : false,
        payu: this.account.payu == 1 ? true : false,
        sms_enabled: this.account.sms_enabled == 1 ? true : false,
        email_enabled: this.account.email_enabled == 1 ? true : false,
        notifications: this.account.notifications == 1 ? true : false,
      },
      tax: null,
      language: null,
    };
  },
  watch: {
    timezone: function (v) {
      if (v && v.value) {
        this.form.APP_TIMEZONE = v.value;
      }
    },
  },
  mounted() {
    if (this.account.default_tax) {
      this.tax = this.taxes.find(t => t.value == this.account.default_tax);
    }

    if (this.account.language) {
      this.language = this.$page.props.locales.find(l => l.value == this.account.language);
    }

    if (this.form.APP_TIMEZONE) {
      this.timezone = this.timezones.find(tz => tz.value == this.form.APP_TIMEZONE);
    }
  },
  methods: {
    taxChanged(t) {
      this.tax = t ? t : null;
      this.form.default_tax = t ? t.value : null;
    },
    langChanged(lang) {
      this.language = lang ? lang : null;
      this.form.language = lang ? lang.value : null;
    },
    submit() {
      this.sending = true;
      var data = new FormData();
      data.append('logo', this.form.logo || '');
      data.append('name', this.form.name || '');
      data.append('email', this.form.email || '');
      data.append('phone', this.form.phone || '');
      data.append('address', this.form.address || '');
      data.append('gateways', this.form.gateways || '');
      data.append('header', this.form.header || '');
      data.append('footer', this.form.footer || '');
      data.append('per_page', this.form.per_page || '');
      data.append('language', this.form.language || '');
      data.append('direction', this.form.direction || '');
      data.append('fraction', this.form.fraction || 2);
      data.append('default_tax', this.form.default_tax || '');
      data.append('default_locale', this.form.default_locale || '');
      data.append('APP_TIMEZONE', this.form.APP_TIMEZONE || '');
      data.append('MAIL_MAILER', this.form.MAIL_MAILER || '');
      data.append('MAIL_HOST', this.form.MAIL_HOST || '');
      data.append('MAIL_PORT', this.form.MAIL_PORT || '');
      data.append('MAIL_ENCRYPTION', this.form.MAIL_ENCRYPTION || '');
      data.append('MAIL_USERNAME', this.form.MAIL_USERNAME || '');
      data.append('MAIL_PASSWORD', this.form.MAIL_PASSWORD || '');
      data.append('MAIL_FROM_NAME', this.form.MAIL_FROM_NAME || '');
      data.append('MAIL_FROM_ADDRESS', this.form.MAIL_FROM_ADDRESS || '');
      data.append('STRIPE_KEY', this.form.STRIPE_KEY || '');
      data.append('STRIPE_SECRET', this.form.STRIPE_SECRET || '');
      data.append('STRIPE_CURRENCY', this.form.STRIPE_CURRENCY || '');
      data.append('PAYU_DEFAULT_GATEWAY', this.form.PAYU_DEFAULT_GATEWAY || '');
      data.append('PAYU_BIZ_KEY', this.form.PAYU_BIZ_KEY || '');
      data.append('PAYU_BIZ_SALT', this.form.PAYU_BIZ_SALT || '');
      data.append('PAYU_BIZ_MODE', this.form.PAYU_BIZ_MODE || '');
      data.append('PAYU_MONEY_KEY', this.form.PAYU_MONEY_KEY || '');
      data.append('PAYU_MONEY_SALT', this.form.PAYU_MONEY_SALT || '');
      data.append('PAYU_MONEY_AUTH', this.form.PAYU_MONEY_AUTH || '');
      data.append('PAYU_MONEY_MODE', this.form.PAYU_MONEY_MODE || '');
      data.append('SMS_FROM', this.form.SMS_FROM || '');
      data.append('VONAGE_KEY', this.form.VONAGE_KEY || '');
      data.append('VONAGE_SECRET', this.form.VONAGE_SECRET || '');
      data.append('VONAGE_SIGNATURE_SECRET', this.form.VONAGE_SIGNATURE_SECRET || '');
      data.append('MAILGUN_DOMAIN', this.form.MAILGUN_DOMAIN || '');
      data.append('MAILGUN_SECRET', this.form.MAILGUN_SECRET || '');
      data.append('MAILGUN_ENDPOINT', this.form.MAILGUN_ENDPOINT || '');
      data.append('service_postmark_postmark', this.form.service_postmark_postmark || '');
      data.append('AWS_ACCESS_KEY_ID', this.form.AWS_ACCESS_KEY_ID || '');
      data.append('AWS_SECRET_ACCESS_KEY', this.form.AWS_SECRET_ACCESS_KEY || '');
      data.append('AWS_DEFAULT_REGION', this.form.AWS_DEFAULT_REGION || '');
      data.append('MIRRORSIZE_API_KEY', this.form.MIRRORSIZE_API_KEY || '');
      data.append('MIRRORSIZE_MERCHANT_ID', this.form.MIRRORSIZE_MERCHANT_ID || '');
      data.append('MIRRORSIZE_USERNAME', this.form.MIRRORSIZE_USERNAME || '');
      data.append('MONEZIUM_SITE_KEY', this.form.MONEZIUM_SITE_KEY || '');
      data.append('MONEZIUM_SHOP_KEY', this.form.MONEZIUM_SHOP_KEY || '');
      data.append('SOCKET_SERVER_URL', this.form.SOCKET_SERVER_URL || '');
      data.append('payu', this.form.payu ? true : false);
      data.append('stripe', this.form.stripe ? true : false);
      data.append('sms_enabled', this.form.sms_enabled ? true : false);
      data.append('email_enabled', this.form.email_enabled ? true : false);
      data.append('_method', 'put');

      this.$axios
        .post(route('settings.update'), data)
        .then(res => {
          this.sending = false;
          if (res.data.success) {
            this.$page.props.flash.success = res.data.message;
            this.form.logo = null;
            this.$nextTick(() => {
              document.body.dir = this.form.direction;
              document.getElementById('page-contents').scrollTop = 0;
              this.$page.props.user.account.direction = this.form.direction;
              this.$i18n.global.locale = this.form.language;
            });
          }
        })
        .catch(err => {
          this.sending = false;
          this.$page.props.flash.error = err.response.data.message;
          if (err.response.data.errors) {
            this.errors = err.response.data.errors;
          }
          this.$nextTick(() => {
            document.getElementById('page-contents').scrollTop = 0;
          });
        });
    },
  },
};
</script>
  