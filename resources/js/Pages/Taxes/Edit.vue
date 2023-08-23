<template>
  <div>
    <h1 class="mb-6 mt-2 font-bold text-lg md:text-2xl">
      <Link class="text-gray-600 hover:text-gray-800 inline-flex items-center" :href="route('taxes')">
        <Icons name="back" class="flex-shrink-0 w-3 h-3 md:w-5 md:h-5 fill-current ltr:mr-2 rtl:ml-2 rtl:rotate" /> {{ $tc('Tax', 2) }}
      </Link>
      <span class="text-gray-400 font-medium mx-2">/</span>
      {{ form.name }}
    </h1>
    <trashed-message v-if="tax.deleted_at" class="mb-6" @restore="() => (restore = true)">
      <span>{{ $t('already_deleted_x', { x: $tc('Tax') }) }}</span>
    </trashed-message>
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
            v-model="form.rate"
            type="number"
            :errors="$page.props.errors?.rate"
            class="ltr:pr-6 rtl:pl-6 pb-8 w-full"
            :label="$t('Rate')"
          />
          <text-input
            v-model="form.description"
            :errors="$page.props.errors?.description"
            class="ltr:pr-6 rtl:pl-6 pb-8 w-full"
            :label="$t('Description')"
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
        <div class="px-8 py-4 bg-gray-100 border-t border-gray-200 flex items-center">
          <DeleteRestoreComponent :restore="restore" :data="tax" model="Tax" routeM="taxes" @close-restore="() => (restore = false)" />
          <loading-button :loading="sending" class="btn-gray ltr:ml-auto rtl:mr-auto" type="submit">
            {{ $t('update_x', { x: $tc('Tax') }) }}
          </loading-button>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import Layout from '@/Shared/Layout.vue';
import TextInput from '@/Shared/TextInput.vue';
import DeleteMixin from '@/Misc/DeleteMixin';
import LoadingButton from '@/Shared/LoadingButton.vue';
import CheckboxInput from '@/Shared/CheckboxInput.vue';
import TrashedMessage from '@/Shared/TrashedMessage.vue';
import DeleteRestoreComponent from '@/Shared/DeleteRestoreComponent.vue';

export default {
  layout: Layout,
  remember: 'form',
  mixins: [DeleteMixin('tax')],
  props: { tax: Object, customers: Array },
  components: { LoadingButton, TextInput, TrashedMessage, CheckboxInput, DeleteRestoreComponent },
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
        code: this.tax.code,
        name: this.tax.name,
        rate: this.tax.rate,
        description: this.tax.description,
        same: this.tax.same == 1 ? true : false,
        state: this.tax.state == 1 ? true : false,
        compound: this.tax.compound == 1 ? true : false,
      },
    };
  },
  methods: {
    submit() {
      this.sending = true;
      this.$inertia.put(this.route('taxes.update', this.tax.id), this.form, {
        onFinish: () => (this.sending = false),
      });
    },
  },
};
</script>
