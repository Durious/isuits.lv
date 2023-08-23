<template>
  <div>
    <div>
      <h1 class="mb-6 mt-2 font-bold text-lg md:text-2xl">{{ $tc('Payment', 2) }}</h1>
      <div class="np mb-6 flex justify-between items-center">
        <search-filter v-model="form.search" class="w-full max-w-md ltr:mr-4 rtl:ml-4" @reset="reset">
          <label class="block text-gray-700">{{ $t('Status') }}</label>
          <v-select
            v-model="form.received"
            :options="[
              { value: '', label: 'All' },
              { value: 'yes', label: $t('Received') },
              { value: 'no', label: $t('Not received yet') },
            ]"
            :reduce="selected => selected.value"
          ></v-select>

          <label class="mt-4 block text-gray-700">{{ $t('Start Date') }}</label>
          <text-input type="date" v-model="form.start_date" pattern="\d{4}-\d{2}-\d{2}" class="mt-1 w-full" />

          <label class="mt-4 block text-gray-700">{{ $t('End Date') }}</label>
          <text-input type="date" v-model="form.end_date" pattern="\d{4}-\d{2}-\d{2}" class="mt-1 w-full" />

          <label class="mt-4 block text-gray-700">{{ $t('Gateway') }}</label>
          <v-select :options="gateways" v-model="form.gateway" :reduce="selected => selected.value"></v-select>

          <label class="mt-4 block text-gray-700">{{ $t('Trashed') }}</label>
          <v-select
            v-model="form.trashed"
            :options="[
              { value: '', label: 'Not Trashed' },
              { value: 'with', label: $t('With Trashed') },
              { value: 'only', label: $t('Only Trashed') },
            ]"
            :reduce="selected => selected.value"
          ></v-select>
        </search-filter>
        <Link class="btn-gray" :href="route('payments.new')">
          <span class="inline md:hidden"><Icons name="add" class="w-4 h-4 text-white group-hover:text-white fill-white" /></span>
          <span class="hidden md:inline">{{ $t('create_x', { x: $tc('Payment') }) }}</span>
        </Link>
      </div>
      <div class="bg-white rounded shadow leading-normal overflow-x-auto scroll-on-light">
        <table class="w-full whitespace-no-wrap">
          <thead>
            <tr class="text-left font-bold">
              <th class="px-6 pt-6 pb-4">{{ $t('Created at') }}</th>
              <th class="px-6 pt-6 pb-4">{{ $t('Customer') }}</th>
              <th class="px-6 pt-6 pb-4 text-right">{{ $t('Amount') }}</th>
              <th class="px-6 pt-6 pb-4">{{ $t('Gateway') }}</th>
              <th class="px-6 pt-6 pb-4" colspan="2">{{ $t('Description') }}</th>
            </tr>
          </thead>
          <tbody>
            <tr
              :key="payment.id"
              @click="rowClicked(payment.id)"
              v-for="payment in payments.data"
              class="cursor-pointer hover:bg-teal-200 focus-within:bg-teal-200"
            >
              <td class="border-t px-6 py-4">
                <div class="flex items-center">
                  {{ $date(payment.date) }}
                  <Icons v-if="payment.deleted_at" name="trash" class="flex-shrink-0 w-3 h-3 fill-gray-400 ml-2" />
                </div>
                <div>{{ $reference(payment.reference) }}</div>
              </td>
              <td class="border-t px-6 py-4">
                <div v-if="payment.customer">
                  {{ payment.customer.name }}
                  <div>{{ payment.customer.phone }}</div>
                </div>
              </td>
              <td class="border-t px-6 py-4">
                  <div class="text-right font-bold flex items-center justify-end">
                    <Icons v-if="payment.received" name="check" class="flex-shrink-0 w-3 h-3 fill-green-600 ltr:mr-2 rtl:ml-2" />
                    {{ $number(payment.amount) }}
                  </div>
              </td>
              <td class="border-t px-6 py-4">
                {{ payment.gateway }}
              </td>
              <td class="border-t px-6 py-4 max-w-lg truncate">
                {{ payment.description }}
              </td>
              <td class="border-t px-6 py-4 w-8">
                <Icons name="cheveron-right" class="block w-6 h-6 fill-gray-400 rtl:rotate" />
              </td>
            </tr>
            <tr v-if="payments.data.length === 0">
              <td class="border-t px-6 py-4" colspan="5">{{ $t('no_x_found', { x: $tc('Payment') }) }}</td>
            </tr>
          </tbody>
        </table>
      </div>
      <pagination :links="payments.links" :meta="payments.meta" />
    </div>
    <Modal :show="viewModal" max-width="2xl" :closeable="true" @close="() => (viewModal = false)">
      <ShowPayment :payment="payment" @close="() => (viewModal = false)" />
    </Modal>
  </div>
</template>

<script>
import pickBy from 'lodash/pickBy';
import throttle from 'lodash/throttle';
import mapValues from 'lodash/mapValues';
import Layout from '@/Shared/Layout.vue';
import Modal from '@/Jetstream/Modal.vue';
import TextInput from '@/Shared/TextInput.vue';
import Pagination from '@/Shared/Pagination.vue';
import ShowPayment from '@/Pages/Payments/Show.vue';
import SearchFilter from '@/Shared/SearchFilter.vue';

export default {
  layout: Layout,
  components: { Pagination, SearchFilter, Modal, TextInput, ShowPayment },
  props: { payments: Object, filters: Object, message: String },
  metaInfo() {
    return { title: this.$tc('Payment', 2) };
  },
  data() {
    return {
      form: {
        search: this.filters.search,
        gateway: this.filters.gateway,
        trashed: this.filters.trashed,
        received: this.filters.received,
      },
      gateways: [],
      payment: null,
      viewModal: false,
    };
  },
  watch: {
    form: {
      handler: throttle(function () {
        let query = pickBy(this.form);
        this.$inertia.replace(this.route('payments', Object.keys(query).length ? query : { remember: 'forget' }));
      }, 250),
      deep: true,
    },
  },
  created() {
    // this.$page.props.flash.success = this.message;
    // this.gateways = this.$page.props.user.account.gateways.split(',');
    this.gateways = this.$page.props.user.account.gateways.split(',').map(g => ({ value: g, label: g }));
    this.gateways.unshift({ value: '', label: this.$t('All') });
  },
  methods: {
    rowClicked(n) {
      fetch(this.route('payments.ajax', n)).then(res => {
        res.json().then(data => {
          this.payment = data;
          this.viewModal = true;
        });
      });
    },
    reset() {
      this.form = mapValues(this.form, () => null);
    },
  },
};
</script>
