<template>
  <div>
    <div class="mb-6 mt-2 flex justify-start max-w-3xl">
      <h1 class="font-bold text-lg md:text-2xl">
        <Link class="text-gray-600 hover:text-gray-800 inline-flex items-center" :href="route('users')">
          <Icons name="back" class="flex-shrink-0 w-3 h-3 md:w-5 md:h-5 fill-current ltr:mr-2 rtl:ml-2 rtl:rotate" /> {{ $tc('User', 2) }}
        </Link>
        <span class="text-gray-400 font-medium mx-2">/</span>
        {{ form.name }}
      </h1>
      <img v-if="edit.photo" class="block w-8 h-8 rounded-full ml-4" :src="'/' + edit.photo" />
    </div>
    <trashed-message v-if="edit.deleted_at" class="mb-6" @restore="() => (restore = true)">
      <span>{{ $t('already_deleted_x', { x: $tc('User') }) }}</span>
    </trashed-message>
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
          <text-input
            type="password"
            :label="$t('Password')"
            v-model="form.password"
            autocomplete="new-password"
            :errors="$page.props.errors?.password"
            class="ltr:pr-6 rtl:pl-6 pb-8 w-full"
          />
          <text-input
            type="number"
            :label="$tc('Salary')"
            v-model="form.salary"
            :errors="$page.props.errors?.salary"
            class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"
          />
          <!-- <div class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2">
            <label class="form-label" for="owner">Owner</label>
           <v-select :dir="$page.props.user.account.direction"
              input-id="owner"
              :transition="false"
              :searchable="false"
              :options="[{ label: 'Yes', code: true }, { label: 'No', code: false }]"
            ></v-select>
            <div v-if="$page.props.errors?.owner" class="form-error">{{ $page.props.errors?.owner }}</div>
          </div> -->
          <file-input
            type="file"
            accept="image/*"
            :label="$t('Photo')"
            v-model="form.photo"
            :errors="$page.props.errors?.photo"
            class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"
          />
        </div>
        <div class="px-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 pb-4">
          <checkbox-input id="active" :label="$t('Active')" v-model:checked="form.active" :checked="form.active"></checkbox-input>
        </div>
        <div class="px-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0" :class="form.owner ? 'pb-8' : 'pb-4'">
          <checkbox-input id="owner" :label="$t('Owner')" v-model:checked="form.owner" :checked="form.owner"></checkbox-input>
        </div>
        <div v-if="!form.owner" class="pb-8">
          <div class="px-8 pb-4 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0">
            <checkbox-input
              id="can_sms"
              v-model:checked="form.can_sms"
              :checked="form.can_sms"
              :label="$t('Can send sms to customers')"
            ></checkbox-input>
          </div>
          <div class="px-8 pb-4 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0">
            <checkbox-input
              id="view_all"
              v-model:checked="form.view_all"
              :checked="form.view_all"
              :label="$t('Can view all (expenses, orders & payments)')"
            ></checkbox-input>
          </div>
          <div class="px-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0">
            <checkbox-input
              id="edit_all"
              v-model:checked="form.edit_all"
              :checked="form.edit_all"
              :label="$t('Can edit all (expenses, orders & payments)')"
            ></checkbox-input>
          </div>
        </div>
        <div class="px-8 py-4 bg-gray-100 border-t border-gray-200 flex items-center">
          <template v-if="edit.id != $page.props.user.id">
            <button tabindex="-1" type="button" @click="destroy" class="text-red-600 hover:underline" v-if="!edit.deleted_at">
              {{ $t('delete_x', { x: $tc('User') }) }}
            </button>
            <button v-else class="text-red-600 hover:underline" tabindex="-1" type="button" @click="destroyPermanently">
              {{ $t('Delete Permanently') }}
            </button>
          </template>
          <loading-button :loading="sending" class="btn-gray ltr:ml-auto rtl:mr-auto" type="submit">
            {{ $t('update_x', { x: $tc('User') }) }}
          </loading-button>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import Layout from '@/Shared/Layout.vue';
import FileInput from '@/Shared/FileInput.vue';
import TextInput from '@/Shared/TextInput.vue';
import DeleteMixin from '@/Misc/DeleteMixin';
import CheckboxInput from '@/Shared/CheckboxInput.vue';
import LoadingButton from '@/Shared/LoadingButton.vue';
import TrashedMessage from '@/Shared/TrashedMessage.vue';
import DeleteRestoreComponent from '@/Shared/DeleteRestoreComponent.vue';

export default {
  layout: Layout,
  remember: 'form',
  props: { edit: Object },
  mixins: [DeleteMixin('user')],
  components: { FileInput, TextInput, LoadingButton, CheckboxInput, TrashedMessage, DeleteRestoreComponent },
  metaInfo() {
    return {
      title: this.$t('edit_x', { x: this.form.name }),
    };
  },
  data() {
    return {
      restore: false,
      sending: false,
      form: {
        photo: null,
        name: this.edit.name,
        email: this.edit.email,
        phone: this.edit.phone,
        salary: this.edit.salary,
        password: this.edit.password,
        username: this.edit.username,
        owner: this.edit.owner == 1 ? true : false,
        active: this.edit.active == 1 ? true : false,
        can_sms: this.edit.can_sms == 1 ? true : false,
        edit_all: this.edit.edit_all == 1 ? true : false,
        view_all: this.edit.view_all == 1 ? true : false,
      },
    };
  },
  methods: {
    submit() {
      this.sending = true;

      var data = new FormData();
      data.append('_method', 'put');
      data.append('name', this.form.name || '');
      data.append('email', this.form.email || '');
      data.append('phone', this.form.phone || '');
      data.append('photo', this.form.photo || '');
      data.append('salary', this.form.salary || '');
      data.append('password', this.form.password || '');
      data.append('username', this.form.username || '');
      data.append('owner', this.form.owner ? '1' : '0');
      data.append('active', this.form.active ? '1' : '0');
      data.append('can_sms', this.form.can_sms ? '1' : '0');
      data.append('view_all', this.form.view_all ? '1' : '0');
      data.append('edit_all', this.form.edit_all ? '1' : '0');

      this.$inertia.post(this.route('users.update', this.edit.id), data, {
        onSuccess: () => {
          this.form.photo = null;
          this.form.password = null;
        },
        onFinish: () => (this.sending = false),
      });
    },
  },
};
</script>
