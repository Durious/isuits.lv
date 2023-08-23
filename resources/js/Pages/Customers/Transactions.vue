<template>
  <div>
    <h1 class="mb-6 mt-2 font-bold text-lg md:text-2xl">
      <Link class="text-gray-600 hover:text-gray-800 inline-flex items-center" :href="route('customers')">
        <Icons name="back" class="flex-shrink-0 w-3 h-3 md:w-5 md:h-5 fill-current ltr:mr-2 rtl:ml-2 rtl:rotate" /> {{ $tc('Customer', 2) }}
      </Link>
      <span class="text-gray-400 font-medium mx-2">/</span>
      {{ $tc('Transaction', 2) }}
    </h1>
    <div class="np mb-6 flex justify-between items-center">
      <search-filter noSlot v-model="form.search" class="w-full max-w-md ltr:mr-4 rtl:ml-4" @reset="reset"></search-filter>
    </div>
    <div class="bg-white rounded shadow overflow-x-auto scroll-on-light">
      <table class="w-full whitespace-no-wrap">
        <thead>
          <tr class="text-left font-bold">
            <th class="px-6 pt-6 pb-4">{{ $t('Created at') }}</th>
            <th class="px-6 pt-6 pb-4">{{ $t('Type') }}</th>
            <th class="px-6 pt-6 pb-4 text-center">{{ $t('Debit') }}</th>
            <th class="px-6 pt-6 pb-4 text-center">{{ $t('Credit') }}</th>
          </tr>
        </thead>
        <tbody>
          <tr :key="transaction.id" v-for="transaction in transactions.data" class="hover:bg-teal-200 focus-within:bg-teal-200">
            <td class="border-t px-6 py-4">
              {{ $datetime(transaction.created_at) }}
            </td>
            <td class="border-t px-6 py-4">
              {{ TypeCol(transaction.type) }}
            </td>
            <td class="border-t px-6 py-4 font-bold text-right">
              {{ $number(transaction.debit) }}
            </td>
            <td class="border-t px-6 py-4 font-bold text-right">
              {{ $number(transaction.credit) }}
            </td>
          </tr>
          <tr v-if="transactions.data?.length === 0">
            <td class="border-t px-6 py-4" colspan="4">{{ $t('no_x_found', { x: $tc('Transaction') }) }}</td>
          </tr>
        </tbody>
      </table>
    </div>
    <pagination :links="transactions.links" :meta="transactions.meta" />
  </div>
</template>

<script>
import Layout from '@/Shared/Layout.vue';
import throttle from 'lodash/throttle';
import mapValues from 'lodash/mapValues';
import Pagination from '@/Shared/Pagination.vue';
import PaymentForm from '@/Pages/Payments/Form.vue';
import SearchFilter from '@/Shared/SearchFilter.vue';

export default {
  layout: Layout,
  components: { Pagination, SearchFilter },
  props: { transactions: Object, filters: Object },
  metaInfo() {
    return { title: this.$tc('Transaction', 2) };
  },
  data() {
    return {
      customer_id: null,
      form: {
        search: this.filters.search,
      },
    };
  },
  mounted() {
    this.customer_id = this.transactions.data[0].customer_id;
  },
  watch: {
    form: {
      handler: throttle(function () {
        this.$inertia.replace(
          this.route('customers.transactions', this.customer_id) + (this.form.search ? '?search=' + this.form.search : '')
        );
      }, 250),
      deep: true,
    },
  },
  methods: {
    TypeCol(type) {
      let t = type.split('_');
      return this.$capitalize(t[0]) + ' ' + this.$capitalize(t[1]);
    },
    reset() {
      this.form = mapValues(this.form, () => null);
    },
  },
};
</script>
