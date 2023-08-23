<template>
  <Layout :title="$t('Create Order')">
    <div>
      <div>
        <h1 class="mb-6 mt-2 font-bold text-lg md:text-2xl">
          <Link class="text-gray-600 hover:text-gray-800 inline-flex items-center" :href="route('orders')">
            <Icons name="back" class="flex-shrink-0 w-3 h-3 md:w-5 md:h-5 fill-current ltr:mr-2 rtl:ml-2 rtl:rotate" />
            {{ $tc('Service Order', 2) }}
          </Link>
          <span class="text-gray-400 font-medium mx-1">/</span>{{ $t('Create') }}
        </h1>
        <div class="bg-white rounded shadow overflow-hidden max-w-3xl">
          <form @submit.prevent="submit" autocomplete="off">
            <div class="p-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap">
              <!-- <text-input
            type="date"
            :label="$t('Date')"
            v-model="form.date"
            pattern="\d{4}-\d{2}-\d{2}"
            :errors="$page.props.errors?.date"
            class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"
          /> -->
              <div class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2">
                <div class="flex items-center justify-between">
                  <label class="form-label" for="customer_id">{{ $tc('Customer') }}</label>
                  <button type="button" @click="addCustomer" class="text-blue-600 hover:text-blue-700">{{ $t('Create') }}</button>
                </div>
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
                  <!-- :class="{ error: $page.props.errors?.services && $page.props.errors?.services.length }" -->
                  <template slot="no-options">
                    <div class="text-left px-4 py-2 text-gray-700 hover:text-gray-200">
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
                        <div v-if="!getServiceMeasurements(service.service_id).length" class="text-center">
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
                        <!--<v-select :dir="$page.props.user.account.direction"
                      v-else
                      label="name"
                      transition=""
                      class="flex-1"
                      :clearable="false"
                      v-model="service.measurement"
                      :options="getServiceMeasurements(service.service_id)"
                      :placeholder="$t('select_x', { x: $tc('Measurement') })"
                    ></v-select> -->
                      </td>
                      <td class="border-b px-4 py-2 ltr:text-right rtl:text-left">
                        <text-input small class="w-20" type="number" v-model="service.price" />
                      </td>
                      <td class="border-b px-4 py-2 text-center">
                        <text-input small type="number" v-model="service.qty" class="w-16 text-center" />
                      </td>
                      <td class="border-b px-4 py-2 ltr:text-right rtl:text-left font-bold">
                        {{ $decimals(service.price * service.qty) }}
                      </td>
                    </tr>
                  </tbody>
                  <tfoot>
                    <tr>
                      <th class="border-b px-4 py-2 bg-gray-200 ltr:text-right rtl:text-left" colspan="4">{{ $t('Total') }}</th>
                      <th class="border-b px-4 py-2 bg-gray-200 text-center">
                        {{ $number(totalQuantity) }}
                      </th>
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
            <div class="px-8 py-4 bg-gray-100 border-t border-gray-200 flex justify-end items-center">
              <loading-button :loading="sending" class="btn-gray" type="submit">{{ $t('create_x', { x: $tc('Order') }) }}</loading-button>
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

      <Modal :show="addC" max-width="2xl" :closeable="true" @close="() => (addC = false)">
        <CustomerForm :modal="addC" :action="updateCustomer" @close="() => (addC = false)" />
      </Modal>
    </div>
  </Layout>
</template>

<script>
import debounce from 'lodash/debounce';
import Layout from '@/Shared/Layout.vue';
import Modal from '@/Jetstream/Modal.vue';
import FileInput from '@/Shared/FileInput.vue';
import TextInput from '@/Shared/TextInput.vue';
import SelectInput from '@/Shared/SelectInput.vue';
import CustomerForm from '@/Pages/Customers/Form.vue';
import TextareaInput from '@/Shared/TextareaInput.vue';
import LoadingButton from '@/Shared/LoadingButton.vue';
import TrashedMessage from '@/Shared/TrashedMessage.vue';
import MeasurementForm from '@/Pages/Measurements/Form.vue';

export default {
  // layout: Layout,
  // remember: 'form',
  // metaInfo() {
  //   return { title: this.$t('create_x', { x: this.$tc('Order') }) };
  // },
  components: {
    Modal,
    Layout,
    FileInput,
    TextInput,
    SelectInput,
    CustomerForm,
    TextareaInput,
    LoadingButton,
    TrashedMessage,
    MeasurementForm,
  },
  props: { members: Array, taxes: Array, icustomers: Array, iservices: Array },
  data() {
    return {
      addC: false,
      addMM: false,
      ddData: null,
      sending: false,
      form: {
        // date: null,
        reference: null,
        customer_id: null,
        assigned_to: null,
        delivery_date: null,
        priority: null,
        note: null,
        services: [],
        customer: null,
        taxes: [],
        discount: null,
        discount_amount: null,
        status: this.$t('Received'),
      },
      tax: null,
      allTaxes: [],
      services: [],
      service: null,
      customers: [],
      priority: null,
      staff_members: [],
      customer: null,
      staff: null,
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
    this.services = this.iservices;
    this.customers = this.icustomers;
    this.staff_members = this.members;
    if (this.$page.props.user.account.default_tax) {
      this.tax = this.taxes.find(t => t.value == this.$page.props.user.account.default_tax);
      this.form.taxes = [{ ...this.tax }];
    }
    if (!this.$page.props.user.owner) {
      this.form.assigned_to = this.$page.props.user.id;
    }
    // this.form.date = this.$options.filters.formatDate(new Date());
  },
  methods: {
    addCustomer(s) {
      this.addC = true;
    },
    updateCustomer(c) {
      let customer = { id: c.id, value: c.id, label: c.name, measurements: [] };
      this.customerChanged(customer);
      this.customers = [customer, ...this.customers];
    },
    addToOrder(s) {
      let measurements = this.getServiceMeasurements(s.id);
      this.form.services.push({
        ...s,
        service_id: s.id,
        qty: 1,
        measurement_id: measurements && measurements.length ? measurements[0]['id'] : null,
      });
    },
    calculateTax(tax, compound = false) {
      if (compound) {
        return (this.totalAmount - this.discountAmount + this.nonCompoundTaxesAmount) * (parseFloat(tax.rate) / 100);
      }
      return (this.totalAmount - this.discountAmount) * (parseFloat(tax.rate) / 100);
    },
    updateCustomerMeasurement(m) {
      this.form.customer = { ...this.form.customer, measurements: [...this.form.customer.measurements, m] };

      let services = this.form.services.map(s => {
        if (s.service_id == m.service_id) {
          s.measurement_id = m.id;
        }
        return s;
      });
      this.$nextTick(() => {
        this.form.services = [...services];
      });
    },
    addMeasurement(sid) {
      let service = this.services.find(os => os.id == sid);
      if (service && this.customer) {
        service = { label: service.name, value: service.id, measurement_fields: service.measurement_fields };
        let customer = this.customer;
        let name = customer.label + "'s " + service.label;
        this.ddData = { name, service, customer };
        this.addMM = true;
      } else {
        document.getElementById('page-contents').scrollTop = 0;
        // this.$page.props.flash.error = this.$t('Please select the customer first');
      }
    },
    getServiceMeasurements(sid) {
      if (this.form.customer) {
        let measurements = this.form.customer.measurements.filter(m => m.service_id == sid);
        return measurements.length ? measurements : [];
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
      // data.append('_method', 'put');
      if (this.form.taxes.length) {
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

      this.$inertia.post(this.route('orders.store'), data, {
        onFinish: () => (this.sending = false),
      });
    },
  },
};
</script>
