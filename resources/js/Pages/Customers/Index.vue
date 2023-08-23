<template>
  <div>
    <div>
      <h1 class="mb-6 mt-2 font-bold text-lg md:text-2xl">{{ $tc('Customer', 2) }}</h1>
      <div class="np mb-6 flex justify-between items-center">
        <search-filter v-model="form.search" class="w-full max-w-md ltr:mr-4 rtl:ml-4" @reset="reset">
          <label class="block text-gray-700">{{ $t('Trashed') }}</label>
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
        <Link class="btn-gray" :href="route('customers.create')">
          <span class="inline md:hidden"><Icons name="add" class="w-4 h-4 text-white fill-white group-hover:text-white fill-white" /></span>
          <span class="hidden md:inline">{{ $t('create_x', { x: $tc('Customer') }) }}</span>
        </Link>
      </div>
      <div class="bg-white rounded shadow overflow-x-auto scroll-on-light">
        <table class="w-full whitespace-no-wrap">
          <thead>
            <tr class="text-left font-bold">
              <th class="px-6 pt-6 pb-4">{{ $t('Name') }}</th>
              <th class="px-6 pt-6 pb-4">{{ $t('Phone') }}</th>
              <th class="px-6 pt-6 pb-4">{{ $t('Email') }}</th>
              <th class="px-6 pt-6 pb-4">{{ $t('Balance') }}</th>
              <th class="px-6 pt-6 pb-4">{{ $t('Address') }}</th>
              <th class="px-6 pt-6 pb-4" colspan="2">{{ $t('Measure') }}</th>
            </tr>
          </thead>
          <tbody>
            <tr
              :key="customer.id"
              @click="rowClicked(customer.id)"
              v-for="customer in customers.data"
              class="cursor-pointer hover:bg-teal-200 focus-within:bg-teal-200"
            >
              <td class="border-t px-6 py-4">
                <div class="flex items-center">
                  <a @click.stop="journalTransactions(customer.id)" class="text-gray-700 hover:text-gray-800">
                    <Icons name="journal" class="flex-shrink-0 w-4 h-4 fill-current ltr:mr-2 rtl:ml-2" />
                  </a>
                  {{ customer.name }}
                  <Icons v-if="customer.deleted_at" name="trash" class="flex-shrink-0 w-3 h-3 fill-gray-400 ml-2" />
                </div>
              </td>
              <td class="border-t px-6 py-4">
                <div class="flex items-center">
                  {{ customer.phone }}
                  <a
                    @click.stop="smsToCustomer(customer)"
                    class="modal-close ml-2 cursor-pointer text-gray-700 hover:text-gray-800"
                    v-if="$page.props.user.account.sms_enabled && ($page.props.user.can_sms || $page.props.user.owner)"
                  >
                    <Icons name="sms" class="h-4 w-4 fill-current" />
                  </a>
                </div>
              </td>
              <td class="border-t px-6 py-4">
                {{ customer.email }}
              </td>
              <td class="border-t px-6 py-4 font-bold">
                <div class="flex items-center justify-end">
                  {{ $number(customer?.journal?.balance?.amount) }}
                  <a @click.stop="addPayment(customer)" class="p-1 text-green-700">
                    <Icons name="add" class="flex-shrink-0 w-3 h-3 fill-current ml-2" />
                  </a>
                </div>
              </td>
              <td class="border-t px-6 py-4 max-w-lg truncate">
                {{ customer.address }}
              </td>
              <td class="border-t px-6 py-4 max-w-lg truncate">
                <Button 
                  type="button" 
                  size="xs"
                  color="red"
                  @click.stop="showMeasureModal(customer.id)"
                >
                  {{ $t('Edit') }}
                </Button>
              </td>
              <td class="border-t px-6 py-4 w-8">
                <Icons name="cheveron-right" class="block w-6 h-6 fill-gray-400 rtl:rotate" />
              </td>
            </tr>
            <tr v-if="customers.data.length === 0">
              <td class="border-t px-6 py-4" colspan="7">{{ $t('no_x_found', { x: $tc('Customer') }) }}</td>
            </tr>
          </tbody>
        </table>
      </div>
      <pagination :links="customers.links" :meta="customers.meta" />
    </div>
    <Modal v-if="viewsms" :show="viewsms" max-width="2xl" :closeable="true" @close="viewsms = false">
      <SmsDialog :order="order" @close="() => (viewsms = false)" />
    </Modal>
    <Modal v-if="view" :show="view" max-width="2xl" :closeable="true" @close="view = false">
      <PaymentForm :c="customer" :modal="true" @close="() => (view = false)" />
    </Modal>
    <Modal :show="viewMeasure" max-width="3xl" @close="() => viewMeasure = false">
      <MeasurementModal :customer_id="customer_id" :measurement="measurement" @close="() => (viewMeasure = false)" />
    </Modal>
  </div>
</template>

<script>
import pickBy from 'lodash/pickBy';
import throttle from 'lodash/throttle';
import mapValues from 'lodash/mapValues';
import Layout from '@/Shared/Layout.vue';
import Modal from '@/Jetstream/Modal.vue';
import Button from '@/Jetstream/Button.vue';
import SmsDialog from '@/Shared/SmsDialog.vue';
import Pagination from '@/Shared/Pagination.vue';
import PaymentForm from '@/Pages/Payments/Form.vue';
import SearchFilter from '@/Shared/SearchFilter.vue';
import MeasurementModal from '@/Pages/Customers/MeasurementModal.vue';

export default {
  layout: Layout,
  components: { Pagination, SearchFilter, SmsDialog, Modal, PaymentForm, Button, MeasurementModal },
  props: { customers: Object, filters: Object },
  metaInfo() {
    return { title: this.$tc('Customer', 2) };
  },
  data() {
    return {
      form: {
        search: this.filters.search,
        trashed: this.filters.trashed,
      },
      viewsms: false,
      view: false,
      viewMeasure: false,
      order: {},
      customer: {},
      measurement: null,
      customer_id: 0,
    };
  },
  watch: {
    form: {
      handler: throttle(function () {
        let query = pickBy(this.form);
        this.$inertia.replace(this.route('customers', Object.keys(query).length ? query : { remember: 'forget' }));
      }, 250),
      deep: true,
    },
  },
  methods: {
    smsToCustomer(customer) {
      this.order.customer = customer;
      this.viewsms = true;
    },
    journalTransactions(n) {
      this.$inertia.visit(this.route('customers.transactions', n));
    },
    rowClicked(n) {
      this.$inertia.visit(this.route('customers.edit', n));
    },
    reset() {
      this.form = mapValues(this.form, () => null);
    },
    addPayment(customer) {
      this.customer = { value: customer.id, label: customer.name };
      this.view = true;
    },
    showMeasureModal(id) {
      this.measurement = this.customers.data.find(item => item.id === id).customer_measure
      this.viewMeasure = true
      this.customer_id = id
    }
  },
};
</script>
