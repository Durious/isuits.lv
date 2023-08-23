<template>
  <div>
    <div class="mt-4 mb-6 flex justify-start max-w-3xl">
      <img v-if="profile.photo" class="block w-8 h-8 rounded-full ltr:mr-4 rtl:ml-4" :src="'/' + profile.photo" />
      <h1 class="font-bold text-lg md:text-2xl">{{ $t('Change Password') }} ({{ profile.name }})</h1>
    </div>
    <div class="bg-white rounded shadow overflow-hidden max-w-3xl">
      <form @submit.prevent="submit" autocomplete="off">
        <div class="px-8 pt-8">
          <text-input
            type="password"
            v-model="form.current"
            :errors="$page.props.errors?.current"
            :label="$t('Current Password')"
            class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"
          />
          <text-input
            type="password"
            v-model="form.password"
            :label="$t('New Password')"
            :errors="$page.props.errors?.password"
            class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"
          />
          <text-input
            type="password"
            :label="$t('Confirm New Password')"
            v-model="form.password_confirmation"
            :errors="$page.props.errors?.password_confirmation"
            class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"
          />
        </div>
        <div class="px-8 py-4 bg-gray-100 border-t border-gray-200 flex items-center">
          <loading-button :loading="sending" class="btn-gray ltr:ml-auto rtl:mr-auto" type="submit">
            {{ $t('Change Password') }}
          </loading-button>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import Layout from '@/Shared/Layout.vue';
import LoadingButton from '@/Shared/LoadingButton.vue';
import TextInput from '@/Shared/TextInput.vue';

export default {
  layout: Layout,
  remember: 'form',
  props: { profile: Object },
  components: { LoadingButton, TextInput },
  metaInfo() {
    return {
      title: this.$t('Change Password') + ' ' + this.profile.name,
    };
  },
  data() {
    return {
      sending: false,
      form: {
        current: this.profile.current,
        password: this.profile.password,
        password_confirmation: this.profile.password_confirmation,
      },
    };
  },
  methods: {
    submit() {
      this.sending = true;
      this.$inertia.put(this.route('profile.change.password', this.profile.id), this.form, {
        onSuccess: () => {
          this.form.current = null;
          this.form.password = null;
          this.form.password_confirmation = null;
        },
        onFinish: () => (this.sending = false),
      });
    },
  },
};
</script>
