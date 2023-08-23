<template>
  <div>
    <div class="mt-4 mb-6 flex items-center justify-start max-w-3xl">
      <img v-if="profile.photo" class="block w-8 h-8 rounded-full ltr:mr-4 rtl:ml-4" :src="'/storage/' + profile.photo" />
      <h1 class="font-bold text-lg md:text-2xl">{{ form.name }}</h1>
    </div>
    <div class="bg-white rounded shadow overflow-hidden max-w-3xl">
      <form @submit.prevent="submit" autocomplete="off">
        <div class="p-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap">
          <text-input
            v-model="form.name"
            :errors="$page.props.errors?.name"
            class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"
            :label="$t('Name')"
          />
          <text-input
            :label="$t('Phone')"
            v-model="form.phone"
            :errors="$page.props.errors?.phone"
            class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"
          />
          <text-input
            :label="$t('Username')"
            v-model="form.username"
            :errors="$page.props.errors?.username"
            class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"
          />
          <text-input
            :label="$t('Email')"
            v-model="form.email"
            :errors="$page.props.errors?.email"
            class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"
          />
        </div>
        <div class="px-8 pb-6 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 flex flex-wrap">
          <file-input
            type="file"
            accept="image/*"
            :label="$t('Photo')"
            v-model="form.photo"
            :errors="$page.props.errors?.photo"
            class="ltr:pr-6 rtl:pl-6 w-full"
          />
        </div>
        <div class="px-8 py-4 bg-gray-100 border-t border-gray-200 flex items-center">
          <loading-button :loading="sending" class="btn-gray ltr:ml-auto rtl:mr-auto" type="submit">{{ $t('Update') }}</loading-button>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import Layout from '@/Shared/Layout.vue';
import TextInput from '@/Shared/TextInput.vue';
import FileInput from '@/Shared/FileInput.vue';
import LoadingButton from '@/Shared/LoadingButton.vue';

export default {
  layout: Layout,
  remember: 'form',
  props: { profile: Object },
  components: { LoadingButton, TextInput, FileInput },
  metaInfo() {
    return {
      title: this.$t('my_profile_x', { x: this.form.name }),
    };
  },
  data() {
    return {
      sending: false,
      form: {
        name: this.profile.name,
        phone: this.profile.phone,
        email: this.profile.email,
        username: this.profile.username,
        photo: null,
      },
    };
  },
  methods: {
    submit() {
      this.sending = true;

      var data = new FormData();
      data.append('name', this.form.name || '');
      data.append('phone', this.form.phone || '');
      data.append('username', this.form.username || '');
      data.append('email', this.form.email || '');
      data.append('photo', this.form.photo || '');
      data.append('_method', 'put');

      this.$inertia.post(this.route('profile.update', this.profile.id), data, {
        onSuccess: () => {
          this.sending = false;
          if (Object.keys(this.$page.props.errors).length === 0) {
            this.form.photo = null;
          }
        },
        onFinish: () => (this.sending = false),
      });
    },
  },
};
</script>
