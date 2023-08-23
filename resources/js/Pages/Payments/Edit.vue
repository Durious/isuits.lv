<template>
  <div>
    <h1 class="mb-6 mt-2 font-bold text-lg md:text-2xl">
      <Link class="text-gray-600 hover:text-gray-800 inline-flex items-center" :href="route('payments')">
        <Icons name="back" class="flex-shrink-0 w-3 h-3 md:w-5 md:h-5 fill-current ltr:mr-2 rtl:ml-2 rtl:rotate" /> {{ $tc('Payment', 2) }}
      </Link>
      <span class="text-gray-400 font-medium mx-2">/</span>
      {{ $t('Payment Number', { x: payment.id }) }}
    </h1>
    <trashed-message v-if="payment.deleted_at" class="mb-6" @restore="() => (restore = true)">
      <span>{{ $t('already_deleted_x', { x: $tc('Payment') }) }}</span>
    </trashed-message>
    <div class="bg-white rounded shadow overflow-hidden max-w-3xl">
      <form @submit.prevent="submit" autocomplete="off">
        <div class="p-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap">
          <text-input
            type="date"
            :label="$t('Date')"
            v-model="form.date"
            pattern="\d{4}-\d{2}-\d{2}"
            :errors="$page.props.errors?.date"
            class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"
          />
          <text-input
            :label="$t('Reference')"
            v-model="form.reference"
            :errors="$page.props.errors?.reference"
            class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"
          />
          <text-input
            :label="$t('Amount')"
            v-model="form.amount"
            :readonly="lock_amount"
            :errors="$page.props.errors?.amount"
            class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"
            :class="lock_amount ? 'readonly' : ''"
          />
          <div class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2">
            <label class="form-label" for="gateway">{{ $t('Gateway') }}</label>
            <v-select
              transition=""
              :clearable="false"
              :options="gateways"
              input-id="gateway"
              v-model="form.gateway"
              :dir="$page.props.user.account.direction"
              :placeholder="$t('select_x', { x: $t('Gateway') })"
              :class="{ error: $page.props.errors?.gateway && $page.props.errors?.gateway.length }"
            ></v-select>
            <div v-if="$page.props.errors?.gateway" class="form-error">{{ $page.props.errors?.gateway[0] }}</div>
          </div>
          <div class="ltr:pr-6 rtl:pl-6 pb-8 w-full">
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
            <div v-if="$page.props.errors?.customer_id" class="form-error">{{ $page.props.errors?.customer_id[0] }}</div>
          </div>
        </div>
        <div class="px-8 pb-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap">
          <textarea-input
            :label="$t('Description')"
            v-model="form.description"
            :errors="$page.props.errors?.description"
            class="ltr:pr-6 rtl:pl-6 pb-8 w-full"
          />
          <checkbox-input
            class="mb-8"
            id="received"
            :label="$t('Received')"
            v-model:checked="form.received"
            :checked="form.received"
          ></checkbox-input>
        </div>
        <div class="px-8 py-4 bg-gray-100 border-t border-gray-200 flex items-center">
          <DeleteRestoreComponent
            :restore="restore"
            :data="payment"
            model="Payment"
            routeM="payments"
            @close-restore="() => (restore = false)"
          />
          <loading-button :loading="sending" class="btn-gray ltr:ml-auto rtl:mr-auto" type="submit">
            {{ $t('update_x', { x: $tc('Payment') }) }}
          </loading-button>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import Layout from '@/Shared/Layout.vue';
import debounce from 'lodash/debounce';
import TextInput from '@/Shared/TextInput.vue';
import DeleteMixin from '@/Misc/DeleteMixin';
import SelectInput from '@/Shared/SelectInput.vue';
import CheckboxInput from '@/Shared/CheckboxInput.vue';
import LoadingButton from '@/Shared/LoadingButton.vue';
import TextareaInput from '@/Shared/TextareaInput.vue';
import TrashedMessage from '@/Shared/TrashedMessage.vue';
import DeleteRestoreComponent from '@/Shared/DeleteRestoreComponent.vue';

export default {
  layout: Layout,
  remember: 'form',
  props: { payment: Object },
  mixins: [DeleteMixin('payment')],
  components: {
    TextInput,
    SelectInput,
    CheckboxInput,
    TextareaInput,
    LoadingButton,
    TrashedMessage,
    DeleteRestoreComponent,
  },
  metaInfo() {
    return {
      title: this.$t('edit_x', { x: this.payment.id }),
    };
  },
  data() {
    return {
      restore: false,
      sending: false,
      form: {
        date: this.payment.date,
        reference: this.payment.reference,
        amount: Number(this.payment.amount),
        gateway: this.payment.gateway,
        order_id: this.payment.order_id,
        customer_id: this.payment.customer_id,
        description: this.payment.description,
        received: this.payment.received == 1 ? true : false,
      },
      gateways: [],
      customers: [],
      customer: null,
      lock_amount: false,
    };
  },
  mounted() {
    if (this.payment.gateway == 'Stripe') {
      this.lock_amount = true;
    }
    this.gateways = this.$page.props.user.account.gateways.split(',');
    this.customer = { value: this.payment.customer.id, label: this.payment.customer.name };
    this.customers = [this.customer];
  },
  methods: {
    submit() {
      this.sending = true;
      this.$inertia.put(this.route('payments.update', this.payment.id), this.form, {
        onFinish: () => (this.sending = false),
      });
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
  },
};
</script>
