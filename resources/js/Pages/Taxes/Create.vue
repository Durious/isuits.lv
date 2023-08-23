<template>
  <div>
    <h1 class="mb-6 mt-2 font-bold text-lg md:text-2xl">
      <Link class="text-gray-600 hover:text-gray-800 inline-flex items-center" :href="route('taxes')">
        <Icons name="back" class="flex-shrink-0 w-3 h-3 md:w-5 md:h-5 fill-current ltr:mr-2 rtl:ml-2 rtl:rotate" /> {{ $tc('Tax', 2) }}
      </Link>
      <span class="text-gray-400 font-medium mx-2">/</span> {{ $t('Create') }}
    </h1>
    <div class="bg-white rounded shadow overflow-hidden max-w-3xl">
      <form @submit.prevent="submit" autocomplete="off">
        <div class="p-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap">
          <text-input
            v-model="form.code"
            :errors="$page.props.errors?.code"
            class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"
            :label="$t('Code')"
          />
          <text-input
            v-model="form.name"
            :errors="$page.props.errors?.name"
            class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"
            :label="$t('Name')"
          />
        </div>
        <div class="px-8 pb-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap">
          <text-input
            type="number"
            :label="$t('Rate')"
            v-model="form.rate"
            :errors="$page.props.errors?.rate"
            class="ltr:pr-6 rtl:pl-6 pb-8 w-full"
          />
          <text-input
            :label="$t('Description')"
            v-model="form.description"
            :errors="$page.props.errors?.description"
            class="ltr:pr-6 rtl:pl-6 pb-8 w-full"
          />
          <checkbox-input
            id="state"
            class="mb-8"
            v-model:checked="form.state"
            :checked="form.state"
            :label="$t('This is state related tax')"
          ></checkbox-input>
          <div class="w-full col-span-full"></div>
          <checkbox-input
            id="same"
            class="mb-8"
            v-model:checked="form.same"
            :checked="form.same"
            :label="$t('This tax applies to same states (business & customer)')"
          ></checkbox-input>
          <div class="w-full col-span-full"></div>
          <checkbox-input
            id="compound"
            class="mb-8"
            v-model:checked="form.compound"
            :checked="form.compound"
            :label="$t('This is compound tax (apply after other taxes)')"
          ></checkbox-input>
        </div>
        <div class="px-8 py-4 bg-gray-100 border-t border-gray-200 flex justify-end items-center">
          <loading-button :loading="sending" class="btn-gray" type="submit">{{ $t('create_x', { x: $tc('Tax') }) }}</loading-button>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import Layout from '@/Shared/Layout.vue';
import TextInput from '@/Shared/TextInput.vue';
import CheckboxInput from '@/Shared/CheckboxInput.vue';
import LoadingButton from '@/Shared/LoadingButton.vue';

export default {
  layout: Layout,
  remember: 'form',
  components: { LoadingButton, TextInput, CheckboxInput },
  metaInfo() {
    return { title: this.$t('create_x', { x: this.$tc('Tax') }) };
  },
  data() {
    return {
      sending: false,
      form: {
        code: null,
        name: null,
        rate: null,
        state: false,
        same: false,
        compound: false,
        description: null,
      },
    };
  },
  methods: {
    submit() {
      this.sending = true;
      this.$inertia.post(this.route('taxes.store'), this.form, {
        onFinish: () => (this.sending = false),
      });
    },
  },
};
</script>
