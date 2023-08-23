<template>
  <div>
    <div class="np" v-if="show">
      <h1 class="mb-6 mt-2 font-bold text-lg md:text-2xl">
        {{ $tc('Report', 2) }}
        <button type="button" v-if="reportData" @click="show = false" class="text-sm px-3 py-2 rounded bg-gray-200 hover:bg-gray-400 ml-3">
          {{ $t('show_x', { x: $tc('Report') }) }}
        </button>
      </h1>
      <div class="bg-white rounded shadow overflow-hidden max-w-3xl">
        <form @submit.prevent="submit" autocomplete="off">
          <div class="px-8 py-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap">
            <div class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2">
              <label class="form-label" for="report">{{ $tc('Report') }}</label>
              <v-select
                transition=""
                input-id="report"
                :clearable="false"
                :filterable="false"
                v-model="form.report"
                :dir="$page.props.user.account.direction"
                :placeholder="$t('select_x', { x: $tc('Report') })"
                :options="[$t('General'), $tc('Customer'), $tc('Tax'), $tc('User')]"
                :class="{
                  error: ($page.props.errors?.report && $page.props.errors?.report.length) || (errors && errors.report),
                }"
              ></v-select>
              <div v-if="errors && errors.report" class="form-error">{{ errors.report[0] }}</div>
              <div v-if="$page.props.errors?.report" class="form-error">{{ $page.props.errors?.report[0] }}</div>
            </div>
            <div v-if="form.report == 'Customer'" class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2">
              <label class="form-label" for="customer_id">{{ $tc('Customer') }}</label>
              <v-select
                transition=""
                :value="customer"
                :options="customers"
                input-id="customer_id"
                @search="searchCustomers"
                v-model="form.customer_id"
                :reduce="selected => selected.value"
                :dir="$page.props.user.account.direction"
                :placeholder="$t('search_x', { x: $tc('Customer', 2) })"
                :class="{
                  error: ($page.props.errors?.customer_id && $page.props.errors?.customer_id.length) || (errors && errors.customer_id),
                }"
              ></v-select>
              <div v-if="errors && errors.customer_id" class="form-error">{{ errors.customer_id[0] }}</div>
              <div v-if="$page.props.errors?.customer_id" class="form-error">{{ $page.props.errors?.customer_id[0] }}</div>
            </div>
            <div v-else-if="form.report == 'User'" class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2">
              <label class="form-label" for="user_id">{{ $tc('User') }}</label>
              <v-select
                :dir="$page.props.user.account.direction"
                transition=""
                :value="user"
                :options="users"
                input-id="user_id"
                @input="userChanged"
                @search="searchUsers"
                @option:selected="userChanged"
                :placeholder="$t('search_x', { x: $tc('User', 2) })"
                :class="{
                  error: ($page.props.errors?.user_id && $page.props.errors?.user_id.length) || (errors && errors.user_id),
                }"
              ></v-select>
              <div v-if="errors && errors.user_id" class="form-error">{{ errors.user_id[0] }}</div>
              <div v-if="$page.props.errors?.user_id" class="form-error">{{ $page.props.errors?.user_id[0] }}</div>
            </div>
            <div v-else class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"></div>

            <div class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2">
              <label class="form-label" for="start_date">{{ $t('Start Date') }}</label>
              <input
                type="date"
                id="start_date"
                class="form-input"
                v-model="form.start_date"
                pattern="\d{4}-\d{2}-\d{2}"
                :placeholder="$t('Start Date')"
                :class="{
                  error: ($page.props.errors?.start_date && $page.props.errors?.start_date.length) || (errors && errors.start_date),
                }"
              />
              <div>
                <div v-if="errors && errors.start_date" class="form-error">{{ errors.start_date[0] }}</div>
                <div v-if="$page.props.errors?.start_date && $page.props.errors?.start_date.length" class="form-error">
                  {{ $page.props.errors?.start_date[0] }}
                </div>
              </div>
            </div>
            <div class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2">
              <label class="form-label" for="end_date">{{ $t('End Date') }}</label>
              <input
                type="date"
                id="end_date"
                class="form-input"
                v-model="form.end_date"
                pattern="\d{4}-\d{2}-\d{2}"
                :placeholder="$t('End Date')"
                :class="{
                  error: ($page.props.errors?.end_date && $page.props.errors?.end_date.length) || (errors && errors.end_date),
                }"
              />
              <div>
                <div v-if="errors && errors.end_date" class="form-error">{{ errors.end_date[0] }}</div>
                <div v-if="$page.props.errors?.end_date && $page.props.errors?.end_date.length" class="form-error">
                  {{ $page.props.errors?.end_date[0] }}
                </div>
              </div>
            </div>
          </div>
          <div class="px-8 py-4 bg-gray-100 border-t border-gray-200 flex justify-end items-center">
            <loading-button :loading="sending" class="btn-gray" type="submit">{{ $t('Get Report') }}</loading-button>
          </div>
        </form>
      </div>
    </div>
    <div class="bg-white rounded shadow overflow-hidden max-w-4xl p-4" v-else>
      <div class="flex items-start justify-between">
        <div>
          <h1 class="mb-2 font-bold text-lg md:text-2xl">{{ reportData.title }}</h1>
          <h1 class="mb-6 mt-2 font-bold">{{ reportData.heading }}</h1>
        </div>
        <button v-if="reportData" type="button" @click="show = true" class="np btn-gray">{{ $t('Show Form') }}</button>
      </div>
      <div class="mb-4 flex items-center justify-between p-4 bg-gray-200 rounded">
        <div>{{ $t('Start Date') }}: {{ $datetime(reportData.start_date) }}</div>
        <div>{{ $t('End Date') }}: {{ $datetime(reportData.end_date) }}</div>
      </div>
      <div v-if="form.report == 'General'">
        <div class="mb-4 flex items-center justify-between p-4 bg-green-100 rounded text-lg border border-green-300">
          {{ $t('Order Amount') }}: <strong>{{ $number(reportData.report.orders.total_amount) }}</strong>
        </div>
        <div class="mb-4 flex items-center justify-between p-4 bg-orange-100 rounded text-lg border border-orange-300">
          {{ $t('Tax Amount') }}: <strong>{{ $number(reportData.report.orders.total_tax) }}</strong>
        </div>
        <div class="mb-4 flex items-center justify-between p-4 bg-red-100 rounded text-lg border border-red-300">
          {{ $tc('Expense', 2) }}: <strong>{{ $number(reportData.report.expenses.total) }}</strong>
        </div>
        <div class="mb-4 flex items-center justify-between p-4 bg-yellow-100 rounded text-lg border border-yellow-300">
          {{ $tc('Salary', 2) }}: <strong>{{ $number(reportData.report.salaries.total) }}</strong>
        </div>
        <div class="mb-4 flex items-center justify-between p-4 bg-gray-700 rounded text-lg border border-gray-800 text-white fill-white">
          {{ $t('Outcome') }}:
          <strong>{{
            $number(
              reportData.report.orders.total_amount -
                reportData.report.orders.total_tax -
                reportData.report.expenses.total -
                reportData.report.salaries.total
            )
          }}</strong>
        </div>
      </div>
      <div v-else-if="form.report == 'Customer'">
        <div class="mb-4 flex items-center justify-between p-4 bg-purple-100 rounded text-lg border border-purple-300">
          <span>
            {{ $t('Name') }}: <strong>{{ reportData.report.customer.name }}</strong>
          </span>
          <span>
            {{ $t('Phone') }}: <strong>{{ reportData.report.customer.phone }}</strong>
          </span>
        </div>
        <div class="mb-4 flex items-center justify-between p-4 bg-indigo-100 rounded text-lg border border-indigo-300">
          {{ $t('Total Orders') }}: <strong>{{ $number(reportData.report.orders.total_orders, 0) }}</strong>
        </div>
        <div class="mb-4 flex items-center justify-between p-4 bg-green-100 rounded text-lg border border-green-300">
          {{ $t('Total Order Amount') }}:
          <strong>{{ $number(reportData.report.orders.total_amount) }}</strong>
        </div>
        <div class="mb-4 flex items-center justify-between p-4 bg-orange-100 rounded text-lg border border-orange-300">
          {{ $t('Due Payment Requests') }}: <strong>{{ $number(reportData.report.due_payments, 0) }}</strong>
        </div>
        <div class="mb-4 flex items-center justify-between p-4 bg-blue-100 rounded text-lg border border-blue-300">
          {{ $t('Balance') }}: <strong>{{ $number(reportData.report.balance) }}</strong>
        </div>
      </div>
      <div v-else-if="form.report == 'User'">
        <div class="mb-4 flex items-center justify-between p-4 bg-purple-100 rounded text-lg border border-purple-300">
          <span>
            {{ $t('Name') }}: <strong>{{ reportData.report.user.name }}</strong>
          </span>
          <span>
            {{ $t('Phone') }}: <strong>{{ reportData.report.user.phone }}</strong>
          </span>
        </div>
        <div class="mb-4 p-4 bg-indigo-100 rounded text-lg border border-indigo-300">
          <div class="flex items-center justify-between">
            {{ $t('Total Orders') }}: <strong>{{ $number(reportData.report.orders.total_orders, 0) }}</strong>
          </div>
          <div class="mt-2 flex items-center justify-between">
            {{ $t('Total Order Amount') }}:
            <strong>{{ $number(reportData.report.orders.total_amount) }}</strong>
          </div>
        </div>
        <div class="mb-4 p-4 bg-green-100 rounded text-lg border border-green-300">
          <div class="flex items-center justify-between">
            {{ $t('Total Orders Assigned') }}:
            <strong>{{ $number(reportData.report.assigned_orders.total_orders, 0) }}</strong>
          </div>
          <div class="mt-2 flex items-center justify-between">
            {{ $t('Total Assigned Order Amount') }}:
            <strong>{{ $number(reportData.report.assigned_orders.total_amount) }}</strong>
          </div>
        </div>

        <div class="mb-4 flex items-center justify-between p-4 bg-orange-100 rounded text-lg border border-orange-300">
          {{ $t('Added Expenses') }}: <strong>{{ $number(reportData.report.expenses) }}</strong>
        </div>
        <div class="mb-4 flex items-center justify-between p-4 bg-blue-100 rounded text-lg border border-blue-300">
          {{ $tc('Salary', 2) }}: <strong>{{ $number(reportData.report.salaries) }}</strong>
        </div>
      </div>
      <div v-else-if="form.report == 'Tax'">
        <div class="mb-4 p-4 bg-indigo-100 rounded text-lg border border-indigo-300">
          <div class="flex items-center justify-between">
            {{ $t('Total Order Amount') }}:
            <strong>{{ $number(reportData.report.orders.total_amount) }}</strong>
          </div>
          <div class="mt-2 flex items-center justify-between">
            {{ $t('Total Tax Amount') }}: <strong>{{ $number(reportData.report.orders.total_tax) }}</strong>
          </div>
        </div>

        <div
          v-if="reportData.report.orders.taxes && reportData.report.orders.taxes.length"
          class="px-4 pt-2 pb-4 bg-orange-100 rounded text-lg border border-orange-300"
        >
          <div :key="'tax_' + i" class="mt-2 flex items-center justify-between" v-for="(tax, i) in reportData.report.orders.taxes">
            {{ tax.name }} ({{ tax.code }}): <strong>{{ $number(tax.total) }}</strong>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Layout from '@/Shared/Layout.vue';
import debounce from 'lodash/debounce';
import LoadingButton from '@/Shared/LoadingButton.vue';

export default {
  layout: Layout,
  components: { LoadingButton },
  props: { icustomers: Array, members: Array },
  metaInfo() {
    return { title: this.$tc('Report', 2) };
  },
  data() {
    return {
      show: true,
      errors: null,
      sending: false,
      reportData: null,
      form: {
        user_id: null,
        end_date: null,
        start_date: null,
        customer_id: null,
        report: 'General',
      },
      users: [],
      user: null,
      customers: [],
      customer: null,
    };
  },
  mounted() {
    let date = new Date();
    this.users = this.members;
    this.customers = this.icustomers;
    this.form.end_date = this.$date(date);
    this.form.start_date = this.$date(new Date(date.getFullYear(), date.getMonth(), 1));
  },
  methods: {
    submit() {
      this.sending = true;
      this.$axios
        .post(this.route('reports.get'), this.form)
        .then(res => {
          this.show = false;
          this.reportData = res.data;
          this.errors = null;
        })
        .catch(err => (this.errors = err.response.data.errors))
        .finally(() => (this.sending = false));
    },
    customerChanged(c) {
      this.customer = c ? c : null;
      this.form.customer_id = c ? c.value : null;
    },
    searchCustomers(search, loading) {
      if (search) {
        loading(true);
        this.searchingCustomers(loading, search, this);
      }
    },
    searchingCustomers: debounce((loading, search, vm) => {
      fetch(vm.route('ajax.customers') + '?search=' + escape(search)).then(res => {
        res.json().then(data => (vm.customers = data));
        loading(false);
      });
    }, 350),
    userChanged(c) {
      this.user = c ? c : null;
      this.form.user_id = c ? c.value : null;
    },
    searchUsers(search, loading) {
      if (search) {
        loading(true);
        this.searchingUsers(loading, search, this);
      }
    },
    searchingUsers: debounce((loading, search, vm) => {
      fetch(vm.route('ajax.users') + '?search=' + escape(search)).then(res => {
        res.json().then(data => (vm.users = data));
        loading(false);
      });
    }, 350),
  },
};
</script>
