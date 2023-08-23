<template>
  <div :class="modal ? 'modal flex items-center w-full h-full' : ''">
    <div :class="modal ? 'bg-white w-full rounded shadow-lg max-w-2xl mx-auto my-auto animate zoomIn' : ''">
      <div class="ltr:text-left rtl:text-right">
        <div v-if="modal" class="np flex justify-between items-center px-6 py-4 mb-4 bg-gray-100 border-b rounded-t">
          <p class="font-bold flex-1">{{ $t('add_x', { x: $tc('Payment') }) }}</p>
          <div class="flex items-center">
            <a class="modal-close cursor-pointer z-50" @click="$emit('close')">
              <svg class="fill-current text-black" xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 18 18">
                <path
                  d="M14.53 4.53l-1.06-1.06L9 7.94 4.53 3.47 3.47 4.53 7.94 9l-4.47 4.47 1.06 1.06L9 10.06l4.47 4.47 1.06-1.06L10.06 9z"
                ></path>
              </svg>
            </a>
          </div>
        </div>

        <div :class="modal ? 'print' : ''">
          <form @submit.prevent="submit" autocomplete="off">
            <div class="p-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap">
              <text-input
                type="date"
                :label="$t('Date')"
                v-model="form.date"
                pattern="\d{4}-\d{2}-\d{2}"
                :errors="errors?.date"
                class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"
              />
              <text-input
                :label="$t('Reference')"
                v-model="form.reference"
                :errors="errors?.reference"
                class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"
              />
              <text-input
                step="0.01"
                type="number"
                :label="$t('Amount')"
                v-model="form.amount"
                :errors="errors?.amount"
                class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"
              />
              <div class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2">
                <label class="form-label" for="gateway">{{ $t('Gateway') }}</label>
                <v-select
                  transition=""
                  :clearable="false"
                  input-id="gateway"
                  :options="gateways"
                  v-model="form.gateway"
                  :dir="$user.account.direction"
                  :placeholder="$t('select_x', { x: $t('Gateway') })"
                  :class="{ error: errors.gateway && errors.gateway.length }"
                ></v-select>
                <div v-if="errors?.gateway" class="form-error">{{ errors.gateway[0] }}</div>
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
                  :dir="$user.account.direction"
                  @option:selected="customerChanged"
                  :placeholder="$t('search_x', { x: $tc('Customer') })"
                  :class="{ error: errors?.customer_id && errors.customer_id.length }"
                ></v-select>
                <div v-if="errors?.customer_id" class="form-error">{{ errors.customer_id[0] }}</div>
              </div>
            </div>
            <div class="px-8 pb-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap">
              <textarea-input
                :label="$t('Description')"
                v-model="form.description"
                :errors="errors?.description"
                class="ltr:pr-6 rtl:pl-6 pb-8 w-full"
              />
              <div v-if="form.gateway == 'Stripe'" class="w-full">
                <label for="card-element">
                  {{ $t('Credit or debit card') }}
                </label>
                <stripe-element-card
                  :amount="amount"
                  ref="stripeCard"
                  :pk="publishableKey"
                  @token="tokenCreated"
                  @loading="loading = $event"
                  class="stripe-card w-full mt-2 mb-6 pr-6"
                />
              </div>
              <checkbox-input
                class="mb-8"
                id="received"
                v-model:checked="form.received"
                :checked="form.received"
                v-else-if="form.gateway != 'PayU'"
                :label="$t('I am receiving this amount')"
              ></checkbox-input>
            </div>
            <div
              :class="{ 'rounded-b': modal }"
              class="px-8 py-4 bg-gray-100 border-t border-gray-200 rounded-b-md flex justify-end items-center"
            >
              <loading-button :loading="sending" class="btn-gray" type="submit">
                {{ $t('create_x', { x: $tc('Payment') }) }}
              </loading-button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import debounce from 'lodash/debounce';
import TextInput from '@/Shared/TextInput.vue';
import CheckboxInput from '@/Shared/CheckboxInput.vue';
import TextareaInput from '@/Shared/TextareaInput.vue';
import LoadingButton from '@/Shared/LoadingButton.vue';
// import { StripeElements } from 'vue-stripe-checkout';
import { StripeElementCard } from '@vue-stripe/vue-stripe';

export default {
  remember: 'form',
  components: { CheckboxInput, LoadingButton, TextInput, TextareaInput, StripeElementCard },
  props: { modal: Boolean, c: Object, icustomers: Array, amount: Number, oId: { default: false } },
  data() {
    return {
      loading: false,
      sending: false,
      form: {
        date: null,
        reference: null,
        amount: null,
        gateway: null,
        received: null,
        order_id: null,
        customer_id: null,
        token: null,
        token_id: null,
        description: null,
      },
      paid: 0,
      errors: {},
      error: null,
      gateways: [],
      customers: [],
      message: null,
      customer: null,
      publishableKey: null,
    };
  },
  watch: {
    c: function (c) {
      if (this.c) {
        this.customers.push(this.c);
        this.form.customer_id = this.c.value;
        this.customer = this.c;
      }
    },
    amount: function (amount) {
      if (this.amount) {
        this.form.amount = this.$number(this.amount) + '';
      }
    },
  },
  mounted() {
    this.customers = this.icustomers || [];
    if (this.oId) {
      this.$axios
        .post(this.route('payments.order', this.oId))
        .then(({ data }) => (this.paid = data.reduce((a, p) => a + parseFloat(p.amount), 0)))
        .then(() => {
          if (this.amount) {
            this.form.amount = this.$number(this.amount - this.paid) + '';
          }
        })
        .catch(err => console.log(err));
    } else if (this.amount) {
      this.form.amount = this.$number(this.amount) + '';
    }
    this.form.date = new Date().toISOString().split('T')[0];
    this.gateways = this.$page.props.user.account.gateways.split(',');
    if (this.c) {
      this.customers.push(this.c);
      this.form.customer_id = this.c.value;
      this.customer = this.c;
    }
    if (this.$page.props.user.account.payu) {
      this.gateways.push('PayU');
    }
    if (this.$page.props.user.account.stripe) {
      this.gateways.push('Stripe');
      this.publishableKey = this.$page.props.user.account.stripe_key;
    }
  },
  methods: {
    customerChanged(c) {
      console.log(c);
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
    submit() {
      this.sending = true;
      if (this.form.gateway == 'Stripe' && !this.form.token_id) {
        this.$refs.stripeCard.submit();
      } else {
        this.$axios
          .post(this.route('payments.store'), this.form)
          .then(res => {
            this.sending = false;
            if (res.data.success) {
              // this.$page.props.flash.success = res.data.message;
              if (res.data.payu) {
                window.location.href = this.route('payu.request', res.data.id);
                // this.$inertia.visit(this.route('payu.request', res.data.id));
              }
              if (this.modal) {
                this.$emit('close');
                // this.$inertia.reload({ replace: true, preserveState: true, data: { message: this.message } });
              } else {
                this.form = {
                  date: new Date(),
                  reference: null,
                  amount: null,
                  gateway: null,
                  received: null,
                  order_id: null,
                  customer_id: null,
                  token: null,
                  token_id: null,
                  description: null,
                };
                this.customer = null;
              }
            }
          })
          .catch(err => {
            this.sending = false;
            this.form.token = null;
            this.form.token_id = null;
            this.errors = err.response.data.errors;
            this.$page.props.flash.error = err.response.data.message;

            // if (err.response.data.errors) {
            //   this.errors = err.response.data.errors;
            //   if (Object.keys(this.errors).length === 1) {
            //     this.$page.props.flash.error = 'There is one form error.';
            //   } else {
            //     this.$page.props.flash.error = `There are ${Object.keys(this.errors).length} form errors.`;
            //   }
            // }
            this.$nextTick(() => {
              document.getElementById('page-contents').scrollTop = 0;
            });
          });
      }
    },
    tokenCreated(token) {
      this.form.token = token;
      this.form.token_id = token.id;
      this.submit();
    },
  },
};
</script>
