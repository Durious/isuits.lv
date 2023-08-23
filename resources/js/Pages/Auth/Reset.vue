<template>
  <div class="titlebar w-full p-6 bg-gray-800 min-h-screen flex justify-center items-center">
    <div class="w-full max-w-md no-drag">
      <!-- <logo class="block mx-auto w-full max-w-xs text-white fill-white" height="50" /> -->
      <div class="flex justify-center mx-auto text-white fill-white">
        <div class="h-8 italic text-white fill-white text-lg py-1 flex items-center">
          <Icons name="logo" class="w-6 h-6 ltr:mr-2 rtl:ml-2 fill-gray-300 group-hover:text-white fill-white" />
          <span class="font-extrabold">{{ $page.props.app_name }}</span>
        </div>
      </div>
      <form class="mt-6 bg-white rounded-lg shadow-xl overflow-hidden" @submit.prevent="submit">
        <div class="p-6">
          <flash-messages />
          <p>{{ $t('Please type details to reset password') }}</p>
          <!-- <div class="mt-6 w-full border-b-2" /> -->
          <text-input
            autofocus
            type="email"
            class="mt-6"
            :label="$t('Email')"
            v-model="form.email"
            autocapitalize="off"
            :errors="$page.props.errors?.email"
          />

          <text-input v-model="form.password" class="mt-6" :label="$t('Password')" type="password" :errors="$page.props.errors?.password" />
          <text-input
            v-model="form.password_confirmation"
            class="mt-6"
            type="password"
            :label="$t('Confirm Password')"
            :errors="$page.props.errors?.password_confirmation"
          />
        </div>
        <div class="px-6 py-3 bg-gray-100 border-t border-gray-200 flex justify-between items-center">
          <Link class="hover:underline" tabindex="-1" :href="route('login')">{{ $t('Back to Login') }}</Link>
          <loading-button :loading="sending" class="btn-gray" type="submit">{{ $t('Reset Password') }}</loading-button>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import TextInput from '@/Shared/TextInput.vue';
import LoadingButton from '@/Shared/LoadingButton.vue';
import FlashMessages from '@/Shared/FlashMessages.vue';

export default {
  props: { errors: Object, token: String, email: String },
  components: { LoadingButton, TextInput, FlashMessages },
  metaInfo() {
    return { title: this.$t('Reset Password') };
  },
  data() {
    return {
      sending: false,
      form: {
        email: '',
        password: '',
        token: this.token,
        password_confirmation: '',
      },
    };
  },
  mounted() {
    this.$i18n.locale = window.Locale;
  },
  methods: {
    submit() {
      this.sending = true;
      this.$inertia.post(this.route('password.update'), this.form, {
        onFinish: () => (this.sending = false),
      });
    },
  },
};
</script>
