<template>
  <Layout :title="$t('edit_x', { x: this.$t('Order Number', { x: this.order.id }) })">
    <div>
      <div>
        <h1 class="mb-6 mt-2 font-bold text-lg md:text-2xl">
          <Link class="text-gray-600 hover:text-gray-800 inline-flex items-center" :href="route('orders')">
            <Icons name="back" class="flex-shrink-0 w-3 h-3 md:w-5 md:h-5 fill-current ltr:mr-2 rtl:ml-2 rtl:rotate" />
            {{ $tc('Service Order', 2) }}
          </Link>
          <span class="text-gray-400 font-medium mx-2">/</span>
          {{ $t('Order Number', { x: order.id }) }}
        </h1>
        <trashed-message v-if="order.deleted_at" class="mb-6 max-w-4xl" @restore="restore">
          <span>{{ $t('already_deleted_x', { x: $tc('Order') }) }}</span>
        </trashed-message>
        <div class="bg-white rounded shadow overflow-hidden max-w-4xl">
          <form @submit.prevent="submit" autocomplete="off">
            <div class="p-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap">
              <div class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2">
                <label class="form-label" for="customer_id">{{ $tc('Customer') }}</label>
                <v-select
                  transition=""
                  v-model="customer"
                  :clearable="false"
                  :options="customers"
                  input-id="customer_id"
                  @input="customerChanged"
                  @search="searchCustomers"
                  @option:selected="customerChanged"
                  :dir="$page.props.user.account.direction"
                  :placeholder="$t('search_x', { x: $tc('Customer') })"
                  :class="{ error: $page.props.errors?.customer_id && $page.props.errors?.customer_id.length }"
                ></v-select>
                <div v-if="$page.props.errors?.customer_id" class="form-error">{{ $page.props.errors?.customer_id }}</div>
              </div>
              <text-input
                type="date"
                pattern="\d{4}-\d{2}-\d{2}"
                :label="$t('Delivery Date')"
                v-model="form.delivery_date"
                :errors="$page.props.errors?.delivery_date"
                class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"
              />
              <div class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2">
                <label class="form-label" for="status">{{ $t('Status') }}</label>
                <v-select
                  transition=""
                  input-id="status"
                  :clearable="false"
                  v-model="form.status"
                  :dir="$page.props.user.account.direction"
                  :placeholder="$t('select_x', { x: $t('Status') })"
                  :class="{ error: $page.props.errors?.status && $page.props.errors?.status.length }"
                  :options="[$t('Pending'), $t('Received'), $t('Preparing'), $t('Ready'), $t('Completed')]"
                ></v-select>
                <div v-if="$page.props.errors?.status" class="form-error">{{ $page.props.errors?.status }}</div>
              </div>
              <text-input
                :label="$t('Reference')"
                v-model="form.reference"
                :errors="$page.props.errors?.reference"
                class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"
              />
              <div v-if="$page.props.user.owner" class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2">
                <label class="form-label" for="assigned_to">{{ $t('Assign to') }}</label>
                <v-select
                  transition=""
                  :value="staff"
                  :clearable="false"
                  @input="staffChanged"
                  @search="searchStaff"
                  input-id="assigned_to"
                  :options="staff_members"
                  @option:selected="staffChanged"
                  :dir="$page.props.user.account.direction"
                  :placeholder="$t('search_x', { x: $t('Staff') })"
                  :class="{ error: $page.props.errors?.assigned_to && $page.props.errors?.assigned_to.length }"
                ></v-select>
                <div v-if="$page.props.errors?.assigned_to" class="form-error">{{ $page.props.errors?.assigned_to }}</div>
              </div>
              <div class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2">
                <label class="form-label" for="priority">{{ $t('Priority') }}</label>
                <v-select
                  transition=""
                  :clearable="false"
                  :filterable="false"
                  input-id="priority"
                  :options="priorities"
                  v-model="form.priority"
                  :dir="$page.props.user.account.direction"
                  :placeholder="$t('select_x', { x: $t('Priority') })"
                ></v-select>
                <div v-if="$page.props.errors?.priority" class="form-error">{{ $page.props.errors?.priority }}</div>
              </div>
              <div class="ltr:pr-6 rtl:pl-6 pb-8 w-full no-drop">
                <v-select
                  label="name"
                  transition=""
                  :value="service"
                  input-id="service"
                  :options="services"
                  @input="addToOrder"
                  @search="searchServices"
                  @option:selected="addToOrder"
                  :dir="$page.props.user.account.direction"
                  :placeholder="$t('Search service to add to order')"
                >
                  <template slot="no-options">
                    <div class="px-4 py-2 text-gray-700 hover:text-gray-200">
                      {{ $t('Type to search services') }}
                    </div>
                  </template>
                </v-select>
                <template v-for="(s, i) in form.services" :key="'se_' + i">
                  <div>
                    <div
                      v-if="$page.props.errors['services.' + i + '.measurement_id']"
                      class="px-4 py-2 rounded mt-4 text-white fill-white bg-red-500"
                    >
                      {{ $page.props.errors['services.' + i + '.measurement_id'] }}
                    </div>
                    <div
                      v-if="$page.props.errors['services.' + i + '.price']"
                      class="px-4 py-2 rounded mt-4 text-white fill-white bg-red-500"
                    >
                      {{ $page.props.errors['services.' + i + '.price'] }}
                    </div>
                    <div
                      v-if="$page.props.errors['services.' + i + '.qty']"
                      class="px-4 py-2 rounded mt-4 text-white fill-white bg-red-500"
                    >
                      {{ $page.props.errors['services.' + i + '.qty'] }}
                    </div>
                  </div>
                </template>
              </div>
              <div class="ltr:mr-6 rtl:ml-6 mb-8 w-full border rounded overflow-x-auto lg:overflow-x-hidden pb-4 lg:pb-0">
                <div v-if="!form.customer_id" class="px-4 py-3 bg-orange-200 text-orange-500">
                  {{ $t('Please select the customer first') }}
                </div>
                <div
                  v-if="!form.services.length"
                  class="px-4 py-3 bg-gray-200 text-gray-500"
                  :class="{ 'bg-red-200 text-red-500': $page.props.errors?.services && $page.props.errors?.services.length }"
                >
                  <div v-if="$page.props.errors?.services">{{ $page.props.errors?.services }}</div>
                  <div v-else>{{ $t('Please add at least one service to order by selecting from above dropdown.') }}</div>
                </div>
                <table v-else class="w-full">
                  <thead>
                    <tr>
                      <th class="border-b pl-4 pr-2 py-2 bg-gray-200 text-center">#</th>
                      <th class="border-b pl-2 pr-4 py-2 bg-gray-200 ltr:text-left rtl:text-right">{{ $tc('Service') }}</th>
                      <th class="border-b px-4 py-2 bg-gray-200 w-40">{{ $tc('Measurement') }}</th>
                      <th class="border-b px-4 py-2 bg-gray-200 w-16">{{ $t('Price') }}</th>
                      <th class="border-b px-4 py-2 bg-gray-200 w-12">{{ $t('Qty') }}</th>
                      <th class="border-b px-4 py-2 bg-gray-200">{{ $t('Amount') }}</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr v-for="(service, si) in form.services" :key="'servicse_' + service.id">
                      <td class="border-b pl-4 pr-2 py-2">
                        <div class="flex flex-col content-center items-center justify-around w-6">
                          <div class="pt-1">{{ si + 1 }}</div>
                          <button type="button" @click="deleteService(si)" class="mt-1 p-1 text-gray-500 hover:text-red-600">
                            <Icons name="trash" class="flex-shrink-0 w-3 h-3 fill-current" />
                          </button>
                        </div>
                      </td>
                      <td class="border-b pl-2 pr-4 py-2 leading-normal">
                        <div style="min-width: 180px">
                          {{ service.name }}
                          <div class="text-sm font-bold">{{ service.code }}</div>
                        </div>
                      </td>
                      <td class="border-b px-4 py-2 no-drop">
                        <div v-if="!getServiceMeasurements(service.service_id)" class="text-center">
                          <button
                            type="button"
                            @click="addMeasurement(service.service_id)"
                            class="bg-gray-200 hover:bg-gray-400 border rounded px-4 py-2"
                          >
                            {{ $t('Add') }}
                          </button>
                        </div>
                        <select-input
                          v-else
                          small
                          v-model="service.measurement_id"
                          :placeholder="$t('select_x', { x: $tc('Measurement') })"
                        >
                          <option v-for="(o, i) in getServiceMeasurements(service.service_id)" :key="'mo_' + si + i" :value="o.id">
                            {{ o.name }}
                          </option>
                        </select-input>
                      </td>
                      <td class="border-b px-4 py-2 ltr:text-right rtl:text-left">
                        <text-input small class="w-20" type="number" v-model="service.price" />
                      </td>
                      <td class="border-b px-4 py-2 text-center">
                        <text-input small type="number" class="w-16 text-center" v-model="service.qty" />
                      </td>
                      <td class="border-b px-4 py-2 ltr:text-right rtl:text-left font-bold">
                        {{ $number(service.price * service.qty) }}
                      </td>
                    </tr>
                  </tbody>
                  <tfoot>
                    <tr>
                      <th class="border-b px-4 py-2 bg-gray-200 ltr:text-right rtl:text-left" colspan="4">{{ $t('Total') }}</th>
                      <th class="border-b px-4 py-2 bg-gray-200 text-center">{{ totalQuantity }}</th>
                      <th class="border-b px-4 py-2 bg-gray-200 ltr:text-right rtl:text-left">
                        {{ $number(totalAmount) }}
                      </th>
                    </tr>
                    <tr v-if="form.discount">
                      <th class="border-b px-4 py-2 bg-gray-200 ltr:text-right rtl:text-left" colspan="5">{{ $t('Discount') }}</th>
                      <th class="border-b px-4 py-2 bg-gray-200 ltr:text-right rtl:text-left">
                        {{ $number(discountAmount) }}
                      </th>
                    </tr>
                    <template v-if="form.taxes.length">
                      <tr v-for="(tax, ti) in nonCompoundTaxes" :key="'tr_' + ti">
                        <th class="border-b px-4 py-2 bg-gray-200 ltr:text-right rtl:text-left" colspan="5">{{ tax.label }}</th>
                        <th class="border-b px-4 py-2 bg-gray-200 ltr:text-right rtl:text-left">
                          {{ $number(calculateTax(tax, false)) }}
                        </th>
                      </tr>
                      <tr v-for="(tax, ti) in compoundTaxes" :key="'ctr_' + ti">
                        <th class="border-b px-4 py-2 bg-gray-200 ltr:text-right rtl:text-left" colspan="5">{{ tax.label }}</th>
                        <th class="border-b px-4 py-2 bg-gray-200 ltr:text-right rtl:text-left">
                          {{ $number(calculateTax(tax, true)) }}
                        </th>
                      </tr>
                    </template>
                    <tr v-if="form.taxes.length || form.discount">
                      <th class="border-b px-4 py-2 bg-gray-200 ltr:text-right rtl:text-left" colspan="5">{{ $t('Grand Total') }}</th>
                      <th class="border-b px-4 py-2 bg-gray-200 ltr:text-right rtl:text-left">
                        {{ $number(totalAmount - discountAmount + taxAmount) }}
                      </th>
                    </tr>
                  </tfoot>
                </table>
              </div>
              <div class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2">
                <label class="form-label" for="taxes">{{ $tc('Tax', 2) }}</label>
                <v-select
                  multiple
                  transition=""
                  input-id="taxes"
                  :options="taxes"
                  v-model="form.taxes"
                  :dir="$page.props.user.account.direction"
                  :placeholder="$t('add_x', { x: $tc('Tax', 2) })"
                ></v-select>
                <div v-if="$page.props.errors?.taxes" class="form-error">{{ $page.props.errors?.taxes }}</div>
              </div>
              <text-input
                v-model="form.discount"
                :errors="$page.props.errors?.discount"
                pattern="[0-9]+(\.[0-9]{1,2})?%?"
                :label="$t('Discount (number or % only)')"
                class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"
              />
              <file-input
                type="file"
                accept="image/*"
                :label="$t('Photo')"
                v-model="form.photo"
                class="ltr:pr-6 rtl:pl-6 pb-8 w-full"
                :errors="$page.props.errors?.photo"
              />
              <textarea-input
                v-model="form.note"
                :errors="$page.props.errors?.note"
                :label="$t('Comment / Note')"
                class="ltr:pr-6 rtl:pl-6 pb-8 w-full"
              />
            </div>
            <div class="px-8 py-4 bg-gray-100 border-t border-gray-200 flex items-center">
              <DeleteRestoreComponent
                :restore="restore"
                :data="order"
                model="Order"
                routeM="orders"
                @close-restore="() => (restore = false)"
              />
              <loading-button :loading="sending" class="btn-gray ltr:ml-auto rtl:mr-auto" type="submit">
                {{ $t('update_x', { x: $tc('Order') }) }}
              </loading-button>
            </div>
          </form>
        </div>
      </div>
      <Modal :show="addMM" max-width="2xl" :closeable="true" @close="() => (addMM = false)">
        <MeasurementForm
          :modal="addMM"
          :ddData="ddData"
          :iservices="this.services"
          @close="() => (addMM = false)"
          :action="updateCustomerMeasurement"
        />
      </Modal>
    </div>
  </Layout>
</template>

<script>
import Layout from '@/Shared/Layout.vue';
import debounce from 'lodash/debounce';
import FileInput from '@/Shared/FileInput.vue';
import TextInput from '@/Shared/TextInput.vue';
import DeleteMixin from '@/Misc/DeleteMixin';
import Modal from '@/Jetstream/Modal.vue';
import SelectInput from '@/Shared/SelectInput.vue';
import TextareaInput from '@/Shared/TextareaInput.vue';
import LoadingButton from '@/Shared/LoadingButton.vue';
import TrashedMessage from '@/Shared/TrashedMessage.vue';
import MeasurementForm from '@/Pages/Measurements/Form.vue';
import DeleteRestoreComponent from '@/Shared/DeleteRestoreComponent.vue';

export default {
  // layout: Layout,
  mixins: [DeleteMixin('order')],
  props: { order: Object, members: Array, taxes: Array, iservices: Array, icustomers: Array },
  components: {
    Modal,
    Layout,
    FileInput,
    TextInput,
    SelectInput,
    TextareaInput,
    LoadingButton,
    TrashedMessage,
    MeasurementForm,
    DeleteRestoreComponent,
  },
  data() {
    return {
      restore: false,
      sending: false,
      addMM: false,
      ddData: null,
      form: {
        date: this.order.date,
        reference: this.order.reference,
        customer_id: this.order.customer.id,
        assigned_to: this.order.assigned_to ? this.order.assigned_to.id : '',
        delivery_date: this.order.delivery_date,
        status: this.order.status,
        priority: this.order.priority,
        amount: this.order.amount,
        note: this.order.note,
        services: this.order.services,
        customer: this.order.customer,
        taxes: this.order.taxes.map(t => {
          t.value = t.id;
          t.label = t.name;
          return t;
        }),
        discount: this.order.discount,
        discount_amount: this.order.discount_amount,
      },
      staff: {},
      tax: null,
      allTaxes: [],
      services: [],
      service: null,
      customers: [],
      priority: null,
      staff_members: [],
      customer: { label: this.order.customer.name, value: this.order.customer.id },
      priorities: [
        { label: this.$t('Normal'), value: 1 },
        { label: this.$t('High'), value: 2 },
        { label: this.$t('Urgent'), value: 3 },
      ],
    };
  },
  computed: {
    discountAmount() {
      if (!this.form.discount) {
        return 0;
      }
      if (this.form.discount.indexOf('%') !== -1) {
        var discount = this.form.discount.split('%');
        return parseFloat(this.totalAmount * (parseFloat(discount) / 100), 4);
      }
      return parseFloat(this.form.discount);
    },
    compoundTaxes() {
      return this.form.taxes.filter(t => t.compound);
    },
    nonCompoundTaxes() {
      return this.form.taxes.filter(t => !t.compound);
    },
    nonCompoundTaxesAmount() {
      return this.nonCompoundTaxes.reduce((a, t) => a + this.calculateTax(t, false), 0);
    },
    taxAmount() {
      return this.nonCompoundTaxesAmount + this.compoundTaxes.reduce((a, t) => a + this.calculateTax(t, true), 0);
    },
    totalAmount() {
      return this.form.services.reduce((a, s) => parseFloat(s.price) * parseFloat(s.qty) + a, 0);
    },
    totalQuantity() {
      return this.form.services.reduce((a, s) => parseFloat(s.qty) + a, 0);
    },
  },
  mounted() {
    if (this.order.assigned_to) {
      this.staff = { label: this.order.assigned_to.name, value: this.order.assigned_to.id };
      this.members.push(this.staff);
    }
    this.allTaxes = this.taxes;
    this.services = this.iservices;
    this.customers = this.icustomers;
    this.customers.push(this.customer);
    this.staff_members = this.members;
    this.form.priority = this.priorities.find(p => p.value == this.order.priority);
    this.form.services = this.order.services.map(s => {
      s.id = s.service_id;
      s.qty = Number(s.qty);
      s.price = Number(s.price);
      return s;
    });
  },
  methods: {
    addToOrder(s) {
      let measurements = this.getServiceMeasurements(s.id);
      this.form.services.push({ ...s, service_id: s.id, qty: 1, measurement_id: measurements ? measurements[0]['id'] : null });
    },
    calculateTax(tax, compound = false) {
      if (compound) {
        return (this.totalAmount - this.discountAmount + this.nonCompoundTaxesAmount) * (parseFloat(tax.rate) / 100);
      }
      return (this.totalAmount - this.discountAmount) * (parseFloat(tax.rate) / 100);
    },
    updateCustomerMeasurement(m) {
      this.form.customer.measurements.push(m);
      this.form.services = this.form.services.map(s => {
        if (s.service_id == m.service_id) {
          s.measurement_id = m.id;
        }
        return s;
      });
    },
    addMeasurement(sid) {
      let service = this.services.find(os => os.id == sid);
      service = { label: service.name, value: service.id, measurement_fields: service.measurement_fields };
      let customer = this.customer;
      let name = customer.label + "'s " + service.label;
      this.ddData = { name, service, customer };
      this.addMM = true;
    },
    getServiceMeasurements(sid) {
      if (this.form.customer) {
        let measurements = this.form.customer.measurements.filter(m => m.service_id == sid);
        return measurements && measurements.length ? measurements : false;
      }
    },
    deleteService(si) {
      this.form.services.splice(si, 1);
    },
    staffChanged(s) {
      this.staff = s ? s : null;
      this.form.assigned_to = s ? s.value : null;
    },
    priorityChanged(p) {
      this.priority = p ? p : null;
      this.form.priority = p ? p.value : null;
    },
    customerChanged(c) {
      this.customer = c ? c : null;
      this.form.customer = c ? c : null;
      this.form.customer_id = c ? c.value : null;
      this.form.services = this.form.services.map(s => {
        s.measurement = null;
        s.measurement_id = null;
        return s;
      });
    },
    searchCustomers(search, loading) {
      if (search) {
        loading(true);
        this.searchingCustomers(loading, search, this);
      }
    },
    searchingCustomers: debounce((loading, search, vm) => {
      fetch(vm.route('ajax.customers') + '?measurements=1&search=' + escape(search)).then(res => {
        res.json().then(data => (vm.customers = data));
        loading(false);
      });
    }, 350),
    searchServices(search, loading) {
      if (search) {
        loading(true);
        this.searchingServices(loading, search, this);
      }
    },
    searchingServices: debounce((loading, search, vm) => {
      fetch(vm.route('ajax.services') + '?full=1&search=' + escape(search)).then(res => {
        res.json().then(data => (vm.services = data));
        loading(false);
      });
    }, 350),
    searchStaff(search, loading) {
      if (search) {
        loading(true);
        this.searchingStaff(loading, search, this);
      }
    },
    searchingStaff: debounce((loading, search, vm) => {
      fetch(vm.route('ajax.staff') + '?search=' + escape(search)).then(res => {
        res.json().then(data => (vm.staff_members = data));
        loading(false);
      });
    }, 350),
    submit() {
      this.sending = true;
      var data = new FormData();
      data.append('reference', this.form.reference || '');
      data.append('customer_id', this.form.customer_id || '');
      data.append('assigned_to', this.form.assigned_to || '');
      data.append('delivery_date', this.form.delivery_date || '');
      data.append('status', this.form.status || '');
      data.append('priority', this.form.priority ? this.form.priority.value : '' || '');
      data.append('note', this.form.note || '');
      data.append('discount', this.form.discount || '');
      data.append('photo', this.form.photo || '');
      data.append('_method', 'put');
      if (this.form.taxes && this.form.taxes.length) {
        this.form.taxes.map((t, i) => {
          data.append('taxes[' + i + '][id]', t.id);
          data.append('taxes[' + i + '][code]', t.code);
          data.append('taxes[' + i + '][name]', t.name);
          data.append('taxes[' + i + '][rate]', t.rate);
          data.append('taxes[' + i + '][compound]', t.compound);
        });
      } else {
        data.append('taxes', []);
      }
      this.form.services.map((s, i) => {
        data.append('services[' + i + '][id]', s.id);
        data.append('services[' + i + '][qty]', s.qty);
        data.append('services[' + i + '][code]', s.code);
        data.append('services[' + i + '][name]', s.name);
        data.append('services[' + i + '][price]', s.price);
        data.append('services[' + i + '][service_id]', s.service_id);
        data.append('services[' + i + '][measurement_id]', s.measurement_id);
      });

      this.$inertia.post(this.route('orders.update', this.order.id), data, {
        onFinish: () => (this.sending = false),
      });
    },
  },
};
</script>
