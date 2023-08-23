<template>
  <div>
    <h1 class="mb-6 mt-2 font-bold text-lg md:text-2xl">
      <Link class="text-gray-600 hover:text-gray-800 inline-flex items-center" :href="route('salaries')">
        <Icons name="back" class="flex-shrink-0 w-3 h-3 md:w-5 md:h-5 fill-current ltr:mr-2 rtl:ml-2 rtl:rotate" /> {{ $t('Salaries') }}
      </Link>
      <span class="text-gray-400 font-medium mx-2">/</span> {{ $t('Create') }}
    </h1>
    <div class="bg-white rounded shadow overflow-hidden max-w-3xl">
      <form @submit.prevent="submit" autocomplete="off">
        <div class="p-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap">
          <text-input
            :label="'Date'"
            type="date"
            v-model="form.date"
            pattern="\d{4}-\d{2}-\d{2}"
            :errors="$page.props.errors?.date"
            class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"
          />
          <text-input
            v-model="form.amount"
            :errors="$page.props.errors?.amount"
            class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"
            :label="'Amount'"
          />
        </div>
        <div class="px-8 pb-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap">
          <div class="ltr:pr-6 rtl:pl-6 pb-8 w-full">
            <label class="form-label" for="staff_id">{{ $t('Staff') }}</label>
            <v-select
              :dir="$page.props.user.account.direction"
              transition=""
              :value="staff"
              input-id="staff_id"
              @input="staffChanged"
              @search="searchStaff"
              :options="staff_members"
              placeholder="Search Staff"
              @option:selected="staffChanged"
              :class="{ error: $page.props.errors?.staff_id && $page.props.errors?.staff_id.length }"
            ></v-select>
            <div v-if="$page.props.errors?.staff_id" class="form-error">{{ $page.props.errors?.staff_id[0] }}</div>
          </div>
          <text-input
            v-model="form.description"
            :errors="$page.props.errors?.description"
            class="ltr:pr-6 rtl:pl-6 pb-8 w-full"
            :label="'Description'"
          />
        </div>
        <div class="px-8 pb-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0">
          <checkbox-input
            id="advance"
            :checked="form.advance"
            v-model:checked="form.advance"
            :label="$t('Advance payment (deduct from next salary)')"
          ></checkbox-input>
        </div>
        <div class="px-8 py-4 bg-gray-100 border-t border-gray-200 flex justify-end items-center">
          <loading-button :loading="sending" class="btn-gray" type="submit">{{ $t('Create Salary') }}</loading-button>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import Layout from '@/Shared/Layout.vue';
import debounce from 'lodash/debounce';
import TextInput from '@/Shared/TextInput.vue';
import CheckboxInput from '@/Shared/CheckboxInput.vue';
import LoadingButton from '@/Shared/LoadingButton.vue';

export default {
  layout: Layout,
  remember: 'form',
  props: { members: Array },
  metaInfo: { title: 'Create Salary' },
  components: { LoadingButton, TextInput, CheckboxInput },
  data() {
    return {
      sending: false,
      form: {
        date: null,
        amount: null,
        advance: null,
        staff_id: null,
        description: null,
      },
      staff: null,
      staff_members: [],
    };
  },
  mounted() {
    this.staff_members = this.members.map(m => ({
      value: m.value,
      label: m.label + (m.salary ? ' (' + parseFloat(m.salary).toFixed(2) + ')' : ''),
    }));
    this.form.date = this.$options.filters.formatDate(new Date());
  },
  methods: {
    staffChanged(s) {
      this.staff = s ? s : null;
      this.form.staff_id = s ? s.value : null;
    },
    submit() {
      this.sending = true;
      this.$inertia.post(this.route('salaries.store'), this.form, {
        onFinish: () => (this.sending = false),
      });
    },
    searchStaff(search, loading) {
      if (search) {
        loading(true);
        this.searchingStaff(loading, search, this);
      }
    },
    searchingStaff: debounce((loading, search, vm) => {
      fetch(vm.route('ajax.staff') + '?with_salaries=1&search=' + escape(search)).then(res => {
        res.json().then(
          data =>
            (vm.staff_members = data.map(m => ({
              value: m.value,
              label: m.label + (m.salary ? ' (' + parseFloat(m.salary).toFixed(2) + ')' : ''),
            })))
        );
        loading(false);
      });
    }, 350),
  },
};
</script>
