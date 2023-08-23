<template>
  <div>
    <div v-if="payment && payment.id" class="w-full ltr:text-left rtl:text-right">
      <div v-if="modal" class="np flex justify-between items-center px-6 py-4 mb-4 bg-gray-100 border-b rounded-t">
        <p class="font-bold flex-1">{{ $t('payment_no_x', { x: payment.id }) }}</p>
        <div class="flex items-center">
          <template v-if="!payment.received">
            <a @click="receivedPayment()" class="modal-close cursor-pointer text-gray-700 hover:text-gray-800">
              <Icons name="check2" class="h-5 w-5 fill-current mr-3" />
            </a>
          </template>
          <a class="modal-close mx-2 cursor-pointer text-gray-700 hover:text-gray-800" @click="printPayment()">
            <Icons name="printer" class="h-5 w-5 fill-current" />
          </a>
          <a class="modal-close mx-2 cursor-pointer text-gray-700 hover:text-gray-800" @click="editPayment(payment.id)">
            <Icons name="pencil" class="h-5 w-5 fill-current" />
          </a>
          <a
            @click="smsToCustomer()"
            v-if="$page.props.user.account.sms_enabled && $page.props.user.can_sms"
            class="modal-close mx-2 cursor-pointer text-gray-700 hover:text-gray-800"
          >
            <Icons name="sms" class="h-5 w-5 fill-current" />
          </a>
          <a class="modal-close ml-2 cursor-pointer" @click="$emit('close')">
            <svg class="fill-current text-black" xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 18 18">
              <path
                d="M14.53 4.53l-1.06-1.06L9 7.94 4.53 3.47 3.47 4.53 7.94 9l-4.47 4.47 1.06 1.06L9 10.06l4.47 4.47 1.06-1.06L10.06 9z"
              ></path>
            </svg>
          </a>
        </div>
      </div>

      <!--Body-->
      <div class="print">
        <div class="max-w-2xl h-full py-4 px-6 leading-normal">
          <div class="flex flex-wrap xs:flex-no-wrap justify-around w-full items-start">
            <div class="text-gray-900 mx-auto xs:mx-0" style="width: 180px">
              <img
                :alt="$page.props.user.account.name"
                v-if="$page.props.user.account.logo_path"
                :src="`/storage/account/${$page.props.user.account.logo_path}`"
              />
              <logo v-else />
            </div>
            <div class="text-sm px-4 py-4 xs:py-0 text-center xs:text-left">
              <div class="font-extrabold">{{ payment.account.name }}</div>
              <div class="font-bold">{{ payment.account.phone }}</div>
              {{ payment.account.email }}
            </div>
          </div>

          <div v-if="payment.account.header" class="my-6 px-4 py-3 border rounded">
            {{ payment.account.header }}
          </div>

          <div
            class="px-4 py-3 rounded text-sm flex justify-between bg-gray-200 w-full"
          >
            <div>
              {{ $t('Payment No') }}:
              <span class="font-extrabold inline-block">
                {{ payment.id }}
              </span>
            </div>
            <div>
              {{ $t('Reference') }}: <span class="font-extrabold inline-block">{{ $reference(payment.reference) }}</span>
            </div>
            <div>
              {{ $t('Date') }}:
              <span class="font-extrabold inline-block">{{ $datetime(payment.created_at) }}</span>
            </div>
          </div>
          <!-- :href="`/orders/${payment.id}/photo/${$page.props.user.id + '_' + payment.hash}`" -->
          <a
            target="_blank"
            v-if="payment.photo_path"
            class="np w-full block my-6 px-4 py-3 rounded border bg-gray-200 hover:bg-gray-300"
            :href="`/img/${payment.photo_path}?ref=${$page.props.user ? $page.props.user.id + '_' + payment.hash : payment.hash}`"
          >
            {{ $t('View Payment Photo') }}
          </a>

          <div id="details" class="block xs:flex my-6">
            <div id="company" class="ltr:pr-0 rtl:pl-0 xs:ltr:pr-3 xs:rtl:pl-3 w-full xs:max-w-1/2">
              <div class="px-2 py-2 border rounded-t font-bold">
                {{ $t('Company Details') }}
              </div>
              <div class="border rounded-b border-t-0 px-2 py-2">
                <div class="flex">
                  <span class="ltr:mr-2 rtl:ml-2" style="min-width: 70px"> {{ $t('Name') }}: </span>
                  <span>
                    <strong>{{ payment.account.name }}</strong>
                  </span>
                </div>
                <div v-if="payment.account.address" class="flex">
                  <span class="ltr:mr-2 rtl:ml-2" style="min-width: 70px"> {{ $t('Address') }}: </span>
                  <span>{{ payment.account.address }}</span>
                </div>
                <div class="flex">
                  <span class="ltr:mr-2 rtl:ml-2" style="min-width: 70px"> {{ $t('Phone') }}: </span>
                  <span>{{ payment.account.phone }}</span>
                </div>
                <div v-if="payment.account.email" class="flex">
                  <span class="ltr:mr-2 rtl:ml-2" style="min-width: 70px"> {{ $t('Email') }}: </span>
                  <span>{{ payment.account.email }}</span>
                </div>
              </div>
            </div>
            <div id="customer" class="mt-4 xs:mt-0 pl-0 xs:pl-3 w-full xs:max-w-1/2">
              <div class="px-2 py-2 border rounded-t font-bold">
                {{ $t('Customer Details') }}
              </div>

              <div class="border rounded-b border-t-0 px-2 py-2">
                <div class="flex">
                  <span class="ltr:mr-2 rtl:ml-2" style="min-width: 70px"> {{ $t('Name') }}: </span>
                  <span>
                    <strong>{{ payment.customer.name }}</strong>
                  </span>
                </div>
                <div v-if="payment.customer.address" class="flex">
                  <span class="ltr:mr-2 rtl:ml-2" style="min-width: 70px"> {{ $t('Address') }}: </span>
                  <span>{{ payment.customer.address }}</span>
                </div>
                <div class="flex">
                  <span class="ltr:mr-2 rtl:ml-2" style="min-width: 70px"> {{ $t('Phone') }}: </span>
                  <span>{{ payment.customer.phone }}</span>
                </div>
                <div v-if="payment.customer.email" class="flex">
                  <span class="ltr:mr-2 rtl:ml-2" style="min-width: 70px"> {{ $t('Email') }}: </span>
                  <span>{{ payment.customer.email }}</span>
                </div>
              </div>
            </div>
          </div>

          <div class="mt-6 px-4 py-3 border rounded font-bold text-lg">
            <h1 class="border-b pb-4 px-4 -mx-4">{{ payment.received ? $t('Payment Note') : $t('Payment Request') }}</h1>
            <div class="flex items-center justify-between mt-4">
              {{ $t('Amount') }}
              <div class="text-right">{{ $number(payment.amount) }}</div>
            </div>
            <div v-if="payment.received">
              <div class="text-sm flex items-center justify-between mt-4">
                {{ $t('Paid by') }}
                <div class="text-right">{{ $capitalize(payment.gateway) }}</div>
              </div>
              <div v-if="payment.gateway_transaction_id" class="text-sm flex items-center justify-between mt-1">
                {{ $t('Gateway Transaction Id') }}
                <div class="text-right">{{ payment.gateway_transaction_id }}</div>
              </div>
            </div>
            <div v-else class="flex items-center mt-4 px-4 py-3 rounded bg-red-500 text-white fill-white text-sm">
              {{ $t('Payment is not yet received') }}
              <a
                v-if="payment.gateway == 'PayU'"
                class="ltr:ml-auto rtl:mr-auto bg-gray-700 hover:bg-gray-800 px-2 py-1 rounded -my-1 -ltr:mr-2 rtl:ml-2 text-center"
                :href="route('payu.request', payment.id)"
              >
                {{ $t('Try again with PayU') }}
              </a>
            </div>
          </div>

          <div class="pt-6" v-if="payment.description">
            <h4 class="font-bold">{{ $t('Comment / Note') }}</h4>
            <p>{{ payment.description }}</p>
          </div>

          <div v-if="payment.account.footer" class="mt-6 px-4 py-3 border rounded" :class="modal ? '' : 'mb-3'">
            {{ payment.account.footer }}
          </div>

          <div class="print-only fixed bottom-0 w-full text-center text-sm text-gray-600 pt-6">
            {{ $t('This is a computer-generated document. No signature is required.') }}
          </div>
        </div>
      </div>

      <!--Footer-->
      <div v-if="modal" class="np block xs:flex items-end justify-between px-6 py-4 mt-4 bg-gray-100 border-t rounded-b">
        <div class="m-1 xs:m-0">
          <button
            type="button"
            @click="editPayment()"
            class="px-4 py-3 text-sm rounded bg-gray-200 hover:bg-gray-400 border ltr:mr-2 rtl:ml-2"
          >
            {{ $t('Edit') }}
          </button>
          <button
            type="button"
            :disabled="sending"
            @click="smsToCustomer()"
            v-if="$page.props.user.account.sms_enabled && $page.props.user.can_sms"
            class="inline-flex items-center mt-1 px-4 py-3 text-sm rounded bg-gray-200 hover:bg-gray-400 border ltr:mr-2 rtl:ml-2"
          >
            <div v-if="sending" class="btn-spinner dark ltr:mr-2 rtl:ml-2" />
            {{ $t('SMS') }}
          </button>
          <button
            type="button"
            :disabled="sending"
            @click="receivedPayment()"
            v-if="!payment.received"
            class="inline-flex items-center mt-1 px-4 py-3 text-sm rounded bg-gray-200 hover:bg-gray-400 border ltr:mr-2 rtl:ml-2"
          >
            <div v-if="sending" class="btn-spinner dark ltr:mr-2 rtl:ml-2" />
            {{ $t('Mark as Received') }}
          </button>
        </div>
        <button type="button" @click="$emit('close')" class="btn-gray">
          {{ $t('Close') }}
        </button>
      </div>
    </div>

    <Modal v-if="viewsms" :show="viewsms" max-width="2xl" :closeable="true" @close="viewsms = false">
      <SmsDialog :order="payment" @close="() => (viewsms = false)" />
    </Modal>
  </div>
</template>

<script>
import Logo from '@/Shared/Logo.vue';
import Dropdown from '@/Shared/Dropdown.vue';
import SmsDialog from '@/Shared/SmsDialog.vue';

export default {
  components: { Logo, Dropdown, SmsDialog },
  props: {
    payment: Object,
    modal: {
      default: true,
    },
    edit: { type: Function },
  },
  metaInfo() {
    return {
      title: this.$t('Payment Number', { x: this.payment.id }),
    };
  },
  data() {
    return {
      sending: false,
      emailing: false,
      viewsms: false,
    };
  },
  methods: {
    printPayment() {
      window.print();
    },
    editPayment() {
      this.$emit('close');
      this.$inertia.visit(this.route('payments.edit', this.payment.id));
    },
    receivedPayment() {
      if (!this.payment.received) {
        this.$emit('close');
        // TODO Confirm first
        this.$inertia.put(this.route('payments.status', this.payment.id), { received: 1 });
      }
    },
    smsToCustomer() {
      this.viewsms = true;
    },
    emailPayment() {
      this.sending = true;
      this.emailing = true;
      console.log('Emailing the order no ' + this.payment.id);
      this.$axios
        .post(this.route('payments.email', this.payment.id))
        .then(res => {
          this.sending = false;
          this.emailing = false;
          this.$page.props.flash.message = res.data.success
            ? 'Payment has been sent to the customer email address.'
            : 'System is unable to sent email, either customer do not have email or system settings are not correct.';
        })
        .catch(err => {
          this.sending = false;
          this.emailing = false;
          this.$page.props.flash.error = 'Request has been failed, please check the logs in storage folder and contact developer.';
        });
    },
  },
};
</script>
