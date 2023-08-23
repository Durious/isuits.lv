<template>
  <div>
    <div>
      <h1 class="mb-6 mt-2 font-bold text-lg md:text-2xl">{{ $tc('Service Order', 2) }}</h1>
      <div class="np mb-6 flex justify-between items-center">
        <search-filter v-model="form.search" class="w-full max-w-md ltr:mr-4 rtl:ml-4" @reset="reset">
          <label class="block text-gray-700">{{ $t('Status') }}</label>
          <v-select v-model="form.status" :options="[$t('Received'), $t('Preparing'), $t('Ready'), $t('Completed')]"></v-select>

          <label class="mt-4 block text-gray-700">{{ $t('Start Date') }}</label>
          <text-input type="date" v-model="form.start_date" pattern="\d{4}-\d{2}-\d{2}" class="mt-1 w-full" />

          <label class="mt-4 block text-gray-700">{{ $t('End Date') }}</label>
          <text-input type="date" v-model="form.end_date" pattern="\d{4}-\d{2}-\d{2}" class="mt-1 w-full" />

          <label class="mt-4 block text-gray-700">{{ $tc('Delivery', 2) }}</label>
          <v-select
            v-model="form.due_in"
            :options="[
              { value: '', label: $t('All') },
              { value: '2', label: $t('due_in_x', { x: 2 }) },
              { value: '7', label: $t('due_in_x', { x: 7 }) },
              { value: '14', label: $t('due_in_x', { x: 14 }) },
            ]"
            :reduce="selected => selected.value"
          ></v-select>

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
        <Link class="btn-gray" :href="route('orders.new')">
          <span class="inline md:hidden"><Icons name="add" class="w-4 h-4 text-white fill-white group-hover:text-white fill-white" /></span>
          <span class="hidden md:inline">{{ $t('create_x', { x: $tc('Order') }) }}</span>
        </Link>
      </div>
      <div class="bg-white rounded shadow overflow-x-auto scroll-on-light overflow-y-hidden">
        <table class="w-full whitespace-no-wrap">
          <thead>
            <tr class="text-left font-bold">
              <th class="px-6 pt-6 pb-4">{{ $tc('Order') }}</th>
              <th class="px-6 pt-6 pb-4">{{ $tc('Customer') }}</th>
              <th class="px-6 pt-6 pb-4">{{ $t('Assigned to & delivery') }}</th>
              <th class="px-6 pt-6 pb-4">{{ $t('Status') }}</th>
              <th class="px-6 pt-6 pb-4 text-right" colspan="2">{{ $t('Grand Total') }}</th>
            </tr>
          </thead>
          <tbody>
            <tr
              :key="order.id"
              v-for="order in orders.data"
              @click="rowClicked(order.id)"
              class="cursor-pointer hover:bg-teal-200 focus-within:bg-teal-200"
              :class="{
                'bg-red-300': order.status != 'Ready' && order.status != 'Completed' && order.due_passed,
              }"
            >
              <td class="border-t px-6 py-4 leading-normal">
                <div class="flex items-center">
                  {{ $datetime(order.created_at) }}
                  <Icons v-if="order.deleted_at" name="trash" class="flex-shrink-0 w-3 h-3 fill-gray-400 ml-2" />
                </div>
                <div>{{ $t('Ref') }}: {{ $reference(order.reference) }}</div>
                <div v-if="order.user">{{ $t('by') }} {{ order.user.name }}</div>
              </td>
              <td class="border-t px-6 py-4 leading-normal">
                <div v-if="order.customer">
                  {{ order.customer.name }}
                  <div>{{ order.customer.phone }}</div>
                </div>
              </td>
              <td class="border-t px-6 py-4 leading-normal">
                <div v-if="order.assigned_to">
                  {{ order.assigned_to.name }}
                </div>
                <div>{{ $date(order.delivery_date) }}</div>
              </td>
              <td class="border-t px-6 py-4 text-center">
                <div>{{ $t(order.status) }}</div>
                <div v-if="order.priority" class="pt-3" v-html="PriorityCol(order.priority)"></div>
                <div v-if="order.due" class="pt-3">{{ order.due }}</div>
              </td>
              <td class="border-t text-right font-bold pl-6 py-4">
                <div class="inline-flex items-center justify-end">
                  <Icons v-if="order.paid" name="check" class="flex-shrink-0 w-3 h-3 fill-green-600 ltr:mr-2 rtl:ml-2" />
                  <a v-else @click.stop="addPayment(order)" class="p-1 text-green-700">
                    <Icons name="add" class="flex-shrink-0 w-3 h-3 fill-current ml-2" />
                  </a>
                  {{ $number(order.grand_total) }}
                </div>
              </td>
              <td class="border-t px-4 w-6">
                <div class="flex items-center">
                  <Icons name="cheveron-right" class="block w-6 h-6 fill-gray-400 rtl:rotate" />
                </div>
              </td>
            </tr>
            <tr v-if="orders.data.length === 0">
              <td class="border-t px-6 py-4" colspan="6">{{ $t('no_x_found', { x: $tc('Order') }) }}</td>
            </tr>
          </tbody>
        </table>
      </div>
      <pagination :links="orders.links" :meta="orders.meta" />
    </div>
    <Modal :show="viewModal" max-width="2xl" :closeable="true" @close="() => (viewModal = false)">
      <Show :order="order" @close="() => (viewModal = false)" />
    </Modal>

    <Modal :show="add_payment" max-width="2xl" :closeable="true" @close="() => (add_payment = false)">
      <!-- { c, oId: o.id, modal: true, amount: parseFloat(o.grand_total) }, -->
      <PaymentForm
        :modal="true"
        v-if="payment_request"
        :c="payment_request.customer"
        :oId="payment_request.order.id"
        :amount="payment_request.order.grand_total"
        @close="() => (add_payment = false)"
      />
    </Modal>
  </div>
</template>

<script>
import pickBy from 'lodash/pickBy';
import throttle from 'lodash/throttle';
import mapValues from 'lodash/mapValues';
import Layout from '@/Shared/Layout.vue';
import Modal from '@/Jetstream/Modal.vue';
import Show from '@/Pages/Orders/Show.vue';
import TextInput from '@/Shared/TextInput.vue';
import Pagination from '@/Shared/Pagination.vue';
import PaymentForm from '@/Pages/Payments/Form.vue';
import SearchFilter from '@/Shared/SearchFilter.vue';

export default {
  layout: Layout,
  props: { orders: Object, filters: Object },
  components: { Show, Modal, Pagination, SearchFilter, TextInput, PaymentForm },
  // metaInfo() {
  //   return { title: this.$tc('Order', 2) };
  // },
  data() {
    return {
      order: null,
      viewModal: false,
      add_payment: false,
      payment_request: null,
      form: {
        search: this.filters.search,
        trashed: this.filters.trashed,
      },
    };
  },
  watch: {
    form: {
      handler: throttle(function () {
        let query = pickBy(this.form);
        this.$inertia.replace(this.route('orders', Object.keys(query).length ? query : { remember: 'forget' }));
      }, 250),
      deep: true,
    },
  },
  methods: {
    rowClicked(n) {
      // this.order = { id: n, test: true };
      // this.$event.fire('loading', true);
      fetch(this.route('orders.ajax', n)).then(res => {
        res.json().then(data => {
          // this.$event.fire('loading', false);
          this.order = data;
          this.viewModal = true;
        });
      });
      // document.querySelector('body').classList.add('modal-open');
      // this.$inertia.visit(this.route('orders.edit', n));
    },
    reset() {
      this.form = mapValues(this.form, () => null);
    },
    PriorityCol(p) {
      if (p == 1) {
        return '<span class="bg-gray-200 rounded text-sm py-1 px-2">' + this.$t('Normal') + '</span>';
      } else if (p == 2) {
        return '<span class="bg-orange-200 rounded text-sm py-1 px-2">' + this.$t('High') + '</span>';
      } else if (p == 3) {
        return '<span class="bg-red-200 rounded text-sm py-1 px-2">' + this.$t('Urgent') + '</span>';
      }
    },
    addPayment(o) {
      if (!this.payment_request) {
        this.payment_request = {};
      }
      this.payment_request.customer = { value: o.customer.id, label: o.customer.name };
      this.payment_request.order = o;
      this.add_payment = true;
    },
  },
};
</script>
