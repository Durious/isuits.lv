<template>
  <div class="titlebar w-full p-6 bg-gray-800 min-h-screen flex justify-center items-center">
    <div class="w-full max-w-md no-drag">
      <!-- <logo class="block mx-auto w-full max-w-xs text-white fill-white" height="50" /> -->
      <div class="flex justify-center mx-auto text-white fill-white">
        <div class="h-8 italic text-white fill-white text-lg py-1 flex items-center">
          <Icons name="logo" className="w-8 h-8 ltr:mr-2 rtl:ml-2 fill-gray-300 group-hover:text-white fill-white" />
          <span class="font-extrabold">{{ $page.props.app_name }}</span>
        </div>
      </div>
      <div v-if="$page.props.demo" class="bg-gradient-to-tr from-blue-600 to-blue-700 flex justify-around p-4 rounded bg-gray-700 my-6">
        <div class="inline-block mx-auto text-white fill-white">
          {{ $t('Login as') }}
          <button
            :disabled="sending"
            @click="loginAs()"
            class="mx-2 bg-gray-200 text-gray-700 hover:bg-gray-800 hover:text-gray-300 border-0 transform transition duration-300 hover:scale-110 rounded text-sm font-bold px-3 py-2"
          >
            {{ $t('Owner') }}
          </button>
          <button
            :disabled="sending"
            @click="loginAs(true)"
            class="bg-gray-200 text-gray-700 hover:bg-gray-800 hover:text-gray-300 border-0 transform transition duration-300 hover:scale-110 rounded text-sm font-bold px-3 py-2"
          >
            {{ $t('Tailor') }}
          </button>
        </div>
      </div>
      <form class="mt-6 bg-white rounded-lg shadow-xl overflow-hidden" @submit.prevent="submit" autocapitalize="off">
        <div class="p-6">
          <p>{{ $t('Please login to access your account') }}</p>
          <flash-messages class="np mt-4" />
          <tec-validation-errors class="mb-4" />
          <!-- <div class="mt-6 w-full border-b-2" /> -->
          <text-input
            autofocus
            type="text"
            class="mt-6"
            autocapitalize="off"
            v-model="form.username"
            :label="$t('Username/Email')"
            :errors="$page.props.errors?.username"
          />
          <text-input v-model="form.password" class="mt-6" :label="$t('Password')" type="password" />
          <div class="mt-6">
            <checkbox-input
              id="remember"
              :label="$t('Remember Me')"
              v-model:checked="form.remember"
              :checked="form.remember"
            ></checkbox-input>
          </div>
        </div>
        <div class="px-6 py-3 bg-gray-100 border-t border-gray-200 flex justify-between items-center">
          <Link :href="route('password.request')" class="hover:underline" tabindex="-1">{{ $t('Forget password?') }}</Link>
          <loading-button :loading="sending" class="btn-gray" type="submit">{{ $t('Login') }}</loading-button>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import TextInput from '@/Shared/TextInput.vue';
import CheckboxInput from '@/Shared/CheckboxInput.vue';
import LoadingButton from '@/Shared/LoadingButton.vue';
import FlashMessages from '@/Shared/FlashMessages.vue';
import TecValidationErrors from '@/Jetstream/ValidationErrors.vue';

export default {
  props: { errors: Object },
  components: { LoadingButton, TextInput, CheckboxInput, FlashMessages, TecValidationErrors },
  metaInfo() {
    return { title: this.$t('Login') };
  },
  data() {
    return {
      sending: false,
      form: this.$inertia.form({
        username: null,
        password: null,
        remember: false,
      }),
    };
  },
  mounted() {
    this.$i18n.locale = window.Locale;
  },
  methods: {
    submit() {
      this.sending = true;

      this.$inertia.post(
        this.route('login.attempt'),
        {
          username: this.form.username,
          password: this.form.password,
          remember: this.form.remember,
        },
        { onFinish: () => (this.sending = false) }
      );
    },
    loginAs(tailor) {
      this.form.username = tailor ? 'tailor@tecdiary.com' : 'owner@tecdiary.com';
      this.form.password = '12345678';
      this.submit();
    },
  },
};
</script>
