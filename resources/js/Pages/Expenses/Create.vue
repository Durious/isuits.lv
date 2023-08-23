<template>
  <div>
    <h1 class="mb-6 mt-2 font-bold text-lg md:text-2xl">
      <Link class="text-gray-600 hover:text-gray-800 inline-flex items-center" :href="route('expenses')">
        <Icons name="back" class="flex-shrink-0 w-3 h-3 md:w-5 md:h-5 fill-current ltr:mr-2 rtl:ml-2 rtl:rotate" /> {{ $tc('Expense', 2) }}
      </Link>
      <span class="text-gray-400 font-medium mx-2">/</span> {{ $t('Create') }}
    </h1>
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
            :label="$t('Amount')"
            v-model="form.amount"
            :errors="$page.props.errors?.amount"
            class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"
          />
        </div>
        <div class="px-8 pb-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap">
          <text-input
            :label="$t('Description')"
            v-model="form.description"
            :errors="$page.props.errors?.description"
            class="ltr:pr-6 rtl:pl-6 pb-8 w-full"
          />
        </div>
        <div class="px-8 py-4 bg-gray-100 border-t border-gray-200 flex justify-end items-center">
          <loading-button :loading="sending" class="btn-gray" type="submit">
            {{ $t('create_x', { x: $tc('Expense') }) }}
          </loading-button>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import Layout from '@/Shared/Layout.vue';
import TextInput from '@/Shared/TextInput.vue';
import LoadingButton from '@/Shared/LoadingButton.vue';

export default {
  layout: Layout,
  remember: 'form',
  components: { LoadingButton, TextInput },
  metaInfo() {
    return { title: this.$t('create_x', { x: this.$tc('Expense') }) };
  },
  data() {
    return {
      sending: false,
      form: {
        name: null,
        amount: null,
        description: null,
      },
    };
  },
  methods: {
    submit() {
      this.sending = true;
      this.$inertia.post(this.route('expenses.store'), this.form, {
        onFinish: () => (this.sending = false),
      });
    },
  },
};
</script>
