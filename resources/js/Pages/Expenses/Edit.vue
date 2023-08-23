<template>
  <div>
    <h1 class="mb-6 mt-2 font-bold text-lg md:text-2xl">
      <Link class="text-gray-600 hover:text-gray-800 inline-flex items-center" :href="route('expenses')">
        <Icons name="back" class="flex-shrink-0 w-3 h-3 md:w-5 md:h-5 fill-current ltr:mr-2 rtl:ml-2 rtl:rotate" /> {{ $tc('Expense', 2) }}
      </Link>
      <span class="text-gray-400 font-medium mx-2">/</span>
      {{ form.name }}
    </h1>
    <trashed-message v-if="expense.deleted_at" class="mb-6" @restore="() => (restore = true)">
      <span>{{ $t('already_deleted_x', { x: $tc('Expense') }) }}</span>
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
        <div class="px-8 py-4 bg-gray-100 border-t border-gray-200 flex items-center">
          <DeleteRestoreComponent
            :restore="restore"
            :data="expense"
            model="Expense"
            routeM="expenses"
            @close-restore="() => (restore = false)"
          />
          <loading-button :loading="sending" class="btn-gray ltr:ml-auto rtl:mr-auto" type="submit">
            {{ $t('update_x', { x: $tc('Expense') }) }}
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
import TrashedMessage from '@/Shared/TrashedMessage.vue';
import DeleteRestoreComponent from '@/Shared/DeleteRestoreComponent.vue';

export default {
  layout: Layout,
  remember: 'form',
  mixins: [DeleteMixin('expense')],
  props: { expense: Object, customers: Array },
  components: { LoadingButton, TextInput, TrashedMessage, DeleteRestoreComponent },
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
        name: this.expense.name,
        amount: this.expense.amount,
        description: this.expense.description,
      },
    };
  },
  methods: {
    submit() {
      this.sending = true;
      this.$inertia.put(this.route('expenses.update', this.expense.id), this.form, {
        onFinish: () => (this.sending = false),
      });
    },
  },
};
</script>
