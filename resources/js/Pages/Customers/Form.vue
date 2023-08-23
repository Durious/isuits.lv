<template>
  <div class="w-full ltr:text-left rtl:text-right">
    <div :class="modal ? 'np flex flex-col justify-between items-center px-6 py-4 mb-4 bg-gray-100 border-b rounded-t-md' : ''">
      <div v-if="modal" class="w-full flex items-start justify-between border-b">
        <p class="font-bold flex-1 mb-4">{{ $t('add_x', { x: $tc('Customer') }) }}</p>
        <div class="flex items-center">
          <a class="modal-close cursor-pointer z-50" @click="$emit('close')">
            <svg class="fill-current text-black" xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 18 18">
              <path
                d="M14.53 4.53l-1.06-1.06L9 7.94 4.53 3.47 3.47 4.53 7.94 9l-4.47 4.47 1.06 1.06L9 10.06l4.47 4.47 1.06-1.06L10.06 9z"
              ></path>
            </svg>
          </a>
        </div>
      </div>

      <div :class="modal ? 'print bg-white -mx-6 -mb-8 rounded-md' : ''">
        <form @submit.prevent="submit" autocomplete="off">
          <div class="p-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap">
            <text-input
              :label="$t('Name')"
              v-model="form.name"
              :errors="$page.props.errors?.name || errors?.name"
              class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"
            />
            <text-input
              :label="$t('Phone')"
              v-model="form.phone"
              :errors="$page.props.errors?.phone || errors?.phone"
              class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"
            />
            <text-input
              :label="$t('Email')"
              v-model="form.email"
              :errors="$page.props.errors?.email || errors?.email"
              class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"
            />
            <text-input
              type="number"
              :label="$t('Opening Balance')"
              v-model="form.opening_balance"
              :errors="$page.props.errors?.opening_balance || errors?.opening_balance"
              class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"
            />
            <text-input
              v-model="form.address"
              :label="$t('Address')"
              :errors="$page.props.errors?.address || errors?.address"
              class="ltr:pr-6 rtl:pl-6 pb-8 w-full"
            />
          </div>
          <div class="px-8 pb-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap">
            <text-input
              :label="$t('Description')"
              v-model="form.description"
              :errors="$page.props.errors?.description || errors?.description"
              class="ltr:pr-6 rtl:pl-6 pb-8 w-full"
            />
          </div>
          <div :class="modal ? 'rounded-b-md' : ''" class="px-8 py-4 bg-gray-100 border-t border-gray-200 flex justify-end items-center">
            <loading-button :loading="sending" class="btn-gray" type="submit">{{ $t('create_x', { x: $tc('Customer') }) }}</loading-button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script>
import TextInput from '@/Shared/TextInput.vue';
import LoadingButton from '@/Shared/LoadingButton.vue';

export default {
  remember: 'form',
  props: ['modal', 'action'],
  components: { LoadingButton, TextInput },
  metaInfo() {
    return { title: this.$t('create_x', { x: this.$tc('Customer') }) };
  },
  data() {
    return {
      sending: false,
      form: {
        name: null,
        email: null,
        phone: null,
        address: null,
        description: null,
      },
      errors: {},
    };
  },
  methods: {
    submit() {
      this.sending = true;

      if (this.modal) {
        let data = { ...this.form };
        data.ajax = true;
        this.$axios
          .post(this.route('customers.store'), data)
          .then(res => {
            this.sending = false;
            this.action(res.data);
            this.errors = {};
            this.$emit('close');
          })
          .catch(err => {
            this.sending = false;
            if (err.response.data.errors) {
              this.errors = err.response.data.errors;
            }
          });
      } else {
        this.$inertia.post(this.route('customers.store'), this.form, {
          onFinish: () => (this.sending = false),
        });
      }
    },
  },
};
</script>
