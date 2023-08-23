<template>
  <div v-if="order && order.id" class="bg-white rounded-md ltr:text-left rtl:text-right">
    <div v-if="modal && $page.props.user" class="np flex justify-between items-center px-6 py-4 mb-4 bg-gray-100 border-b rounded-t">
      <p class="font-bold">{{ $t('Order Number', { x: order.id }) }}</p>
      <div class="flex items-center">
        <template v-if="order.status != 'Completed' && ($page.props.user.edit_all || $page.props.user.id == order.user?.id)">
          <Dropdown placement="bottom-end">
            <div class="modal-close mx-2 cursor-pointer text-gray-700 hover:text-gray-800">
              <Icons class="w-5 h-5 fill-current" name="scissors" />
            </div>
            <template v-slot:dropdown>
              <div class="mt-2 py-2 bg-gray-800 rounded text-sm">
                <button
                  type="button"
                  @click="updateStatus('Pending')"
                  class="block w-full ltr:text-left rtl:text-right px-6 py-3 text-white hover:bg-gray-900 hover:text-white fill-white"
                >
                  {{ $t('mark_as_x', { x: $t('Pending') }) }}
                </button>
                <button
                  type="button"
                  @click="updateStatus('Received')"
                  class="block w-full ltr:text-left rtl:text-right px-6 py-3 text-white hover:bg-gray-900 hover:text-white fill-white"
                >
                  {{ $t('mark_as_x', { x: $t('Received') }) }}
                </button>
                <button
                  type="button"
                  @click="updateStatus('Preparing')"
                  class="block w-full ltr:text-left rtl:text-right px-6 py-3 text-white hover:bg-gray-900 hover:text-white fill-white"
                >
                  {{ $t('mark_as_x', { x: $t('Preparing') }) }}
                </button>
                <button
                  type="button"
                  @click="updateStatus('Ready')"
                  class="block w-full ltr:text-left rtl:text-right px-6 py-3 text-white hover:bg-gray-900 hover:text-white fill-white"
                >
                  {{ $t('mark_as_x', { x: $t('Ready') }) }}
                </button>
                <button
                  type="button"
                  @click="updateStatus('Completed')"
                  class="block w-full ltr:text-left rtl:text-right px-6 py-3 text-white hover:bg-gray-900 hover:text-white fill-white"
                >
                  {{ $t('mark_as_x', { x: $t('Completed') }) }}
                </button>
              </div>
            </template>
          </Dropdown>
        </template>
        <a @click="printOrder()" class="modal-close mx-2 cursor-pointer text-gray-700 hover:text-gray-800">
          <Icons name="printer" class="h-5 w-5 fill-current" />
        </a>
        <a
          @click="editOrder(order.id)"
          v-if="$page.props.user.edit_all || $page.props.user.id == order.user.id"
          class="modal-close mx-2 cursor-pointer text-gray-700 hover:text-gray-800"
        >
          <Icons name="pencil" class="h-5 w-5 fill-current" />
        </a>
        <a
          @click="smsToCustomer()"
          v-if="$page.props.user.account.sms_enabled && ($page.props.user.can_sms || $page.props.user.owner)"
          class="modal-close mx-2 cursor-pointer text-gray-700 hover:text-gray-800"
        >
          <Icons name="sms" class="h-5 w-5 fill-current" />
        </a>
        <button
          type="button"
          :disabled="emailing"
          @click="emailOrder()"
          class="modal-close mx-2 cursor-pointer text-gray-700 hover:text-gray-800"
        >
          <Icons name="email" class="h-5 w-5 fill-current" />
        </button>
        <a class="modal-close ml-2 cursor-pointer" @click="hide()">
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
        <div class="flex flex-wrap xs:flex-no-wrap justify-around w-full items-center">
          <div class="text-gray-900 mx-auto xs:mx-0" style="width: 180px">
            <img :alt="order.account.name" v-if="order.account.logo_path" :src="`/storage/account/${order.account.logo_path}`" />
            <logo v-else />
          </div>
          <div class="text-sm px-4 py-4 xs:py-0 text-center xs:ltr:text-left rtl:text-right">
            <div class="font-extrabold">{{ order.account.name }}</div>
            <div class="font-bold">{{ order.account.phone }}</div>
            {{ order.account.email }}
          </div>
          <div class="text-sm">
            <div class="flex">
              <span class="ltr:text-right rtl:text-left ltr:mr-2 rtl:ml-2" style="width: 70px">{{ $t('Order No') }}:</span>
              <span class="font-bold">{{ order.id }}</span>
            </div>
            <div class="flex">
              <span class="ltr:text-right rtl:text-left ltr:mr-2 rtl:ml-2" style="width: 70px">{{ $t('Date') }}:</span>
              <span class="font-bold">
                <span class="inline-block">{{ $datetime(order.created_at) }}</span>
              </span>
            </div>
            <div class="flex">
              <span class="ltr:text-right rtl:text-left ltr:mr-2 rtl:ml-2" style="width: 70px">{{ $t('Reference') }}:</span>
              <span class="font-bold">{{ $reference(order.reference) }}</span>
            </div>
          </div>
        </div>

        <div v-if="order.account.header" class="my-6 px-4 py-3 border rounded">
          {{ order.account.header }}
        </div>

        <div
          class="my-6 px-4 py-3 rounded text-sm flex justify-between"
          :class="{
            'bg-gray-200': order.status == $t('Received'),
            'bg-indigo-200': order.status == $t('Preparing'),
            'bg-green-200': order.status == $t('Ready'),
            'bg-green-700 text-white fill-white': order.status == $t('Completed'),
          }"
        >
          <div>
            {{ $t('Priority') }}:
            <span class="font-extrabold inline-block">
              {{ order.priority == 3 ? $t('Urgent') : order.priority == 2 ? $t('High') : $t('Normal') }}
            </span>
          </div>
          <div>
            {{ $t('Status') }}: <span class="font-extrabold inline-block">{{ order.status }}</span>
          </div>
          <div>
            {{ $t('Delivery Date') }}:
            <span class="font-extrabold inline-block">{{ $date(order.delivery_date) }}</span>
          </div>
        </div>

        <!-- :href="`/${order.photo_path}?ref=${order.user ? order.user.id + '_' + order.hash : order.hash}`" -->
        <a
          target="_blank"
          v-if="order.photo_path"
          class="np w-full block my-6 px-4 py-3 rounded border bg-gray-200 hover:bg-gray-300"
          :href="`/orders/${order.id}/photo/${order.user.id + '--' + order.hash}`"
        >
          {{ $t('View Order Photo') }}
        </a>

        <div id="details" class="block xs:flex my-6">
          <div id="company" class="ltr:pr-0 rtl:pl-0 xs:ltr:pr-3 xs:rtl:pl-3 w-full xs:max-w-1/2">
            <div class="px-2 py-2 border rounded-t font-bold">
              {{ $t('Company Details') }}
            </div>
            <div class="border rounded-b border-t-0 px-2 py-2">
              <div class="flex">
                <span class="ltr:mr-2 rtl:ml-2" style="min-width: 70px">{{ $t('Name') }}:</span>
                <span>
                  <strong>{{ order.account.name }}</strong>
                </span>
              </div>
              <div v-if="order.account.address" class="flex">
                <span class="ltr:mr-2 rtl:ml-2" style="min-width: 70px">{{ $t('Address') }}:</span>
                <span>{{ order.account.address }}</span>
              </div>
              <div class="flex">
                <span class="ltr:mr-2 rtl:ml-2" style="min-width: 70px">{{ $t('Phone') }}:</span>
                <span>{{ order.account.phone }}</span>
              </div>
              <div v-if="order.account.email" class="flex">
                <span class="ltr:mr-2 rtl:ml-2" style="min-width: 70px">{{ $t('Email') }}:</span>
                <span>{{ order.account.email }}</span>
              </div>
            </div>
          </div>
          <div id="customer" class="mt-4 xs:mt-0 ltr:pl-0 rtl:pr-0 xs:ltr:pl-3 xs:rtl:pr-3 w-full xs:max-w-1/2">
            <div class="px-2 py-2 border rounded-t font-bold">
              {{ $t('Customer Details') }}
            </div>

            <div class="border rounded-b border-t-0 px-2 py-2">
              <div class="flex">
                <span class="ltr:mr-2 rtl:ml-2" style="min-width: 70px">{{ $t('Name') }}:</span>
                <span>
                  <strong>{{ order.customer.name }}</strong>
                </span>
              </div>
              <div v-if="order.customer.address" class="flex">
                <span class="ltr:mr-2 rtl:ml-2" style="min-width: 70px">{{ $t('Address') }}:</span>
                <span>{{ order.customer.address }}</span>
              </div>
              <div class="flex">
                <span class="ltr:mr-2 rtl:ml-2" style="min-width: 70px">{{ $t('Phone') }}:</span>
                <span>{{ order.customer.phone }}</span>
              </div>
              <div v-if="order.customer.email" class="flex">
                <span class="ltr:mr-2 rtl:ml-2" style="min-width: 70px">{{ $t('Email') }}:</span>
                <span>{{ order.customer.email }}</span>
              </div>
            </div>
          </div>
        </div>

        <div class="border rounded leading-tight">
          <p class="px-4 py-3 border-b rounded-t font-bold">
            {{ $tc('Service', 2) }}
          </p>
          <div class="rounded-b overflow-x-auto scroll-on-light">
            <table class="w-full all max-w-full min-w-0">
              <thead>
                <tr>
                  <th class="border-b bg-gray-200 px-4 py-2">{{ $t('Item / Details') }}</th>
                  <th class="border-b bg-gray-200 px-4 py-2 text-center">{{ $t('Price') }}</th>
                  <th class="border-b bg-gray-200 px-4 py-2 text-center">{{ $t('Qty') }}</th>
                  <th class="border-b bg-gray-200 px-4 py-2 text-center">{{ $t('Amount') }}</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="service in order.services" :key="'service_' + service.id">
                  <td class="border-b px-4 py-2">
                    <div style="min-width: 180px">
                      <div>{{ service.name }} ({{ service.code }})</div>
                      <div v-if="$page.props.user">
                        <small class="text-muted">
                          {{ $tc('Measurement') }}:
                          <button class="text-indigo-600 hover:fonr-bold" @click="showMeasurement(service.measurement)">
                            {{ service.measurement.name }}
                          </button>
                        </small>
                      </div>
                    </div>
                  </td>
                  <td class="border-b px-4 py-2 ltr:text-right rtl:text-left">
                    {{ $number(service.price) }}
                  </td>
                  <td class="border-b px-4 py-2 ltr:text-right rtl:text-left">
                    {{ $number(service.qty) }}
                  </td>
                  <td class="border-b px-4 py-2 ltr:text-right rtl:text-left">
                    {{ $number(service.amount) }}
                  </td>
                </tr>
              </tbody>
              <tfoot>
                <tr>
                  <th colspan="3" class="border-b px-4 py-2 bg-gray-200 ltr:text-right rtl:text-left">{{ $t('Total') }}</th>
                  <th class="border-b px-4 py-2 bg-gray-200 ltr:text-right rtl:text-left">
                    {{ $number(order.total) }}
                  </th>
                </tr>
                <tr v-if="order.discount">
                  <th class="border-b px-4 py-2 bg-gray-200 ltr:text-right rtl:text-left" colspan="3">{{ $t('Discount') }}</th>
                  <th class="border-b px-4 py-2 bg-gray-200 ltr:text-right rtl:text-left">
                    {{ $number(order.discount_amount) }}
                  </th>
                </tr>
                <template v-if="order.taxes.length">
                  <tr v-for="(tax, ti) in order.taxes" :key="'tr_' + ti">
                    <th class="border-b px-4 py-2 bg-gray-200 ltr:text-right rtl:text-left" colspan="3">{{ tax.name }}</th>
                    <th class="border-b px-4 py-2 bg-gray-200 ltr:text-right rtl:text-left">
                      {{ $number(tax.pivot.total_amount) }}
                    </th>
                  </tr>
                </template>
                <tr v-if="order.taxes.length || order.discount">
                  <th class="border-b px-4 py-2 bg-gray-200 ltr:text-right rtl:text-left" colspan="3">{{ $t('Grand Total') }}</th>
                  <th class="border-b px-4 py-2 bg-gray-200 ltr:text-right rtl:text-left">
                    {{ $number(order.grand_total) }}
                  </th>
                </tr>
                <template v-if="order.payments.length">
                  <tr v-for="(p, pi) in order.payments" :key="'payment_' + pi">
                    <th class="border-b px-4 py-2 bg-gray-200 ltr:text-right rtl:text-left font-normal" colspan="3">
                      {{ $tc('Payment') }} ({{ $date(p.date) }})
                    </th>
                    <th class="border-b px-4 py-2 bg-gray-200 ltr:text-right rtl:text-left font-normal">
                      {{ $number(p.amount) }}
                    </th>
                  </tr>
                  <tr>
                    <th class="border-b px-4 py-2 bg-gray-200 ltr:text-right rtl:text-left" colspan="3">{{ $t('Balance') }}</th>
                    <th class="border-b px-4 py-2 bg-gray-200 ltr:text-right rtl:text-left">
                      {{ $number(order.grand_total - this.total_paid) }}
                    </th>
                  </tr>
                </template>
              </tfoot>
            </table>
          </div>
        </div>

        <div class="pt-6">
          <h4 class="font-bold">{{ $t('Comment / Note') }}</h4>
          <p>
            {{ order.note }}
          </p>
        </div>

        <div v-if="order.account.footer" class="mt-6 px-4 py-3 border rounded" :class="modal ? '' : 'mb-3'">
          {{ order.account.footer }}
        </div>

        <div class="print-only mt-auto w-full text-center text-sm text-gray-600 pt-6">
          {{ $t('This is a computer-generated document. No signature is required.') }}
        </div>
      </div>
    </div>

    <!--Footer-->
    <div v-if="modal" class="np block xs:flex items-end justify-between px-6 py-4 mt-4 bg-gray-100 border-t rounded-b">
      <div class="m-1 xs:m-0">
        <button
          @click="editOrder()"
          v-if="$page.props.user.edit_all || $page.props.user.id == order.user.id"
          class="px-4 py-3 text-sm rounded bg-gray-200 hover:bg-gray-400 border ltr:mr-2 rtl:ml-2"
        >
          {{ $t('Edit') }}
        </button>
        <button
          :disabled="sending"
          @click="smsToCustomer()"
          v-if="$page.props.user.account.sms_enabled && ($page.props.user.can_sms || $page.props.user.owner)"
          class="inline-flex items-center mt-1 px-4 py-3 text-sm rounded bg-gray-200 hover:bg-gray-400 border ltr:mr-2 rtl:ml-2"
        >
          <div v-if="sending" class="btn-spinner dark ltr:mr-2 rtl:ml-2" />
          {{ $t('SMS') }}
        </button>
        <button
          :disabled="sending"
          @click="emailOrder()"
          class="inline-flex items-center mt-1 px-4 py-3 text-sm rounded bg-gray-200 hover:bg-gray-400 border ltr:mr-2 rtl:ml-2"
        >
          <div v-if="sending" class="btn-spinner dark ltr:mr-2 rtl:ml-2" />
          Notify
        </button>
        <template v-if="order.status != 'Completed' && ($page.props.user.edit_all || $page.props.user.id == order.user.id)">
          <dropdown class="mt-1" placement="top-start">
            <div
              class="flex items-center cursor-pointer select-none group px-4 py-3 text-sm rounded bg-gray-200 hover:bg-gray-400 border ltr:mr-2 rtl:ml-2"
            >
              {{ $t('Status') }}
              <Icons class="w-2 h-2 fill-current ml-2" name="cheveron-up" />
            </div>
            <template v-slot:dropdown>
              <div class="mb-2 py-2 bg-gray-800 rounded text-sm">
                <button
                  type="button"
                  @click="updateStatus('Completed')"
                  class="block w-full ltr:text-left rtl:text-right px-6 py-3 text-white hover:bg-gray-900 hover:text-white fill-white"
                >
                  {{ $t('mark_as_x', { x: $t('Completed') }) }}
                </button>
                <button
                  type="button"
                  @click="updateStatus('Ready')"
                  class="block w-full ltr:text-left rtl:text-right px-6 py-3 text-white hover:bg-gray-900 hover:text-white fill-white"
                >
                  {{ $t('mark_as_x', { x: $t('Ready') }) }}
                </button>
                <button
                  type="button"
                  @click="updateStatus('Preparing')"
                  class="block w-full ltr:text-left rtl:text-right px-6 py-3 text-white hover:bg-gray-900 hover:text-white fill-white"
                >
                  {{ $t('mark_as_x', { x: $t('Preparing') }) }}
                </button>
                <button
                  type="button"
                  @click="updateStatus('Received')"
                  class="block w-full ltr:text-left rtl:text-right px-6 py-3 text-white hover:bg-gray-900 hover:text-white fill-white"
                >
                  {{ $t('mark_as_x', { x: $t('Received') }) }}
                </button>
              </div>
            </template>
          </dropdown>
        </template>
      </div>
      <button @click="hide()" class="btn-gray">
        {{ $t('Close') }}
      </button>
    </div>

    <Modal :show="viewMeasurement" max-width="2xl" :closeable="true" @close="viewMeasurement = false">
      <MeasurementComponent
        :measurement="measurement"
        @close="() => (viewMeasurement = false)"
        :notify="order.customer.id != measurement?.customer.id"
      />
    </Modal>
    <Modal :show="send_sms" max-width="sm" :closeable="false" @close="send_sms = false">
      <SmsDialog :order="order" @close="() => (send_sms = false)" />
    </Modal>
    <Dialog :show="message" :content="message" :closeText="$t('ok')" :close="() => (message = null)" />
    <Dialog
      :show="confirm"
      :close="() => (confirm = false)"
      :action-text="dialogButtonText"
      :action="dialogAction"
      :title="dialogTitle"
      :content="dialogBody"
    />
  </div>
</template>

<script>
import md5 from 'md5';
import Logo from '@/Shared/Logo.vue';
import Dialog from '@/Shared/Dialog.vue';
import Modal from '@/Jetstream/Modal.vue';
import Dropdown from '@/Shared/Dropdown.vue';
import SmsDialog from '@/Shared/SmsDialog.vue';
import MeasurementComponent from '@/Pages/Measurements/Show.vue';

export default {
  metaInfo() {
    return {
      title: this.$t('Order Number', { x: this.order.id }),
    };
  },
  props: {
    order: {
      default: {},
    },
    modal: {
      default: true,
    },
    edit: { type: Function },
  },
  components: { Logo, Dropdown, Dialog, Modal, MeasurementComponent, SmsDialog },
  computed: {
    total_paid: function () {
      return this.$number(this.order.payments.reduce((a, p) => a + parseFloat(p.amount), 0));
    },
  },
  data() {
    return {
      sending: false,
      confirm: false,
      send_sms: false,
      emailing: false,
      message: null,
      dialogButtonText: null,
      dialogAction: null,
      dialogTitle: null,
      dialogBody: null,
      viewMeasurement: false,
    };
  },
  methods: {
    showMeasurement(m) {
      // this.$event.fire('loading', true);
      fetch(this.route('measurements.show', [m.id, md5(m.name)]) + '?ajax=1').then(res => {
        res.json().then(data => {
          // this.$event.fire('loading', false);
          this.measurement = data;
          this.viewMeasurement = true;
        });
      });
    },
    printOrder() {
      window.print();
    },
    editOrder() {
      this.$emit('close');
      this.$inertia.get(route('orders.edit', this.order.id));
      // this.$inertia.visit(route('orders.edit', this.order.id));
    },
    updateStatusNow(status) {
      this.$emit('close');
      this.$inertia.put(this.route('orders.status', this.order.id), { status });
    },
    updateStatus(status) {
      if (this.order.status == 'Completed') {
        this.message = this.$t('Order is already marked as completed.');
      } else {
        this.dialogButtonText = this.$t('Yes');
        this.dialogAction = () => this.updateStatusNow(status);
        this.dialogTitle = this.$t('update_status_x', { x: this.$t(status) });
        this.dialogBody = this.$t('ask_update_status_x', { x: this.$t(status) });
        this.confirm = true;
        // this.$vfm.show('dialog', {
        //   title: this.$t('update_status_x', { x: this.$t(status) }),
        //   text: this.$t('ask_update_status_x', { x: this.$t(status) }),
        //   buttons: [
        //     {
        //       title: 'Yes',
        //       class: 'px-6 py-3 bg-gray-200 hover:bg-gray-400',
        //       handler: () => {
        //         this.$emit('close');
        //         this.$inertia.put(this.route('orders.status', this.order.id), { status });
        //       },
        //     },
        //     {
        //       title: 'No',
        //       class: 'px-6 py-3 border-l bg-gray-200 hover:bg-gray-400',
        //     },
        //   ],
        // });
      }
    },
    smsToCustomer() {
      this.send_sms = true;
    },
    emailOrder() {
      this.sending = true;
      this.emailing = true;
      this.$axios
        .post(this.route('orders.email', this.order.id))
        .then(res => {
          this.sending = false;
          this.emailing = false;
          this.message =
            res.data.message ||
            this.$t('System is unable to sent email, either customer do not have email or system settings are not correct.');
        })
        .catch(err => {
          this.sending = false;
          this.emailing = false;
          this.message =
            err.response.data.message || this.$t('Request has been failed, please check the logs in storage folder and contact developer.');
        });
    },
    hide() {
      this.$emit('close');
    },
  },
};
</script>
