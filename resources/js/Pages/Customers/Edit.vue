<template>
  <div>
    <h1 class="mb-6 mt-2 font-bold text-lg md:text-2xl">
      <Link class="text-gray-600 hover:text-gray-800 inline-flex items-center" :href="route('customers')">
        <Icons name="back" class="flex-shrink-0 w-3 h-3 md:w-5 md:h-5 fill-current ltr:mr-2 rtl:ml-2 rtl:rotate" /> {{ $tc('Customer', 2) }}
      </Link>
      <span class="text-gray-400 font-medium mx-2">/</span>
      {{ form.name }}
    </h1>
    <trashed-message v-if="customer.deleted_at" class="mb-6" @restore="() => (restore = true)">
      <span>{{ $t('already_deleted_x', { x: $tc('Customer') }) }}</span>
    </trashed-message>
    <div class="bg-white rounded shadow overflow-hidden max-w-3xl">
      <form @submit.prevent="submit" autocomplete="off">
        <div class="p-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap">
          <text-input
            v-model="form.name"
            :errors="$page.props.errors?.name"
            class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"
            :label="$t('Name')"
          />
          <text-input
            :label="$t('Phone')"
            v-model="form.phone"
            :errors="$page.props.errors?.phone"
            class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"
          />
          <text-input
            :label="$t('Email')"
            v-model="form.email"
            :errors="$page.props.errors?.email"
            class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"
          />
          <text-input
            :label="$t('Address')"
            v-model="form.address"
            :errors="$page.props.errors?.address"
            class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"
          />
        </div>
        <div class="px-8 pb-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap">
          <text-input
            :label="$t('Description')"
            v-model="form.description"
            :errors="$page.props.errors?.description"
            class="ltr:pr-6 rtl:pl-6 pb-8 w-full"
          />
        </div>
        <div class="np px-8 py-4 bg-gray-100 border-t border-gray-200 flex items-center">
          <DeleteRestoreComponent
            :restore="restore"
            :data="customer"
            model="Customer"
            routeM="customers"
            @close-restore="() => (restore = false)"
          />
          <loading-button :loading="sending" class="btn-gray ltr:ml-auto rtl:mr-auto" type="submit">
            {{ $t('update_x', { x: $tc('Customer') }) }}
          </loading-button>
        </div>
      </form>
    </div>    
    <div class="mt-12 flex align-center justify-between">
      <h2 class="font-bold text-2xl">{{ $t('Shipping Address') }}</h2>
      <div>
        <Button size="sm" color="gray" @click="showShippingModal(null)">
          {{ $t('add_x', {'x': $t('Shipping')}) }}
        </Button>
      </div>
    </div>
    <div class="mt-6 bg-white rounded shadow overflow-x-auto scroll-on-light">
      <table class="w-full whitespace-no-wrap">
        <tr class="text-left font-bold">
          <th class="px-6 pt-6 pb-4">{{ $t('Name') }}</th>
          <th class="px-6 pt-6 pb-4">{{ $t('Address') }}</th>
          <th class="px-6 pt-6 pb-4">{{ $t('City') }}</th>
          <th class="px-6 pt-6 pb-4">{{ $t('State') }}</th>
          <th class="px-6 pt-6 pb-4">{{ $tc('Zipcode') }}</th>
          <th class="px-6 pt-6 pb-4">{{ $tc('Default') }}</th>
          <th class="px-6 pt-6 pb-4">{{ $tc('Action') }}</th>
        </tr>
        <tr
          :key="shipping_addresses.id"
          @click="setShippingDefault(item.id)"
          v-for="item in shipping_addresses"
          class="cursor-pointer hover:bg-gray-200"
        >
          <td class="border-t px-6 py-4">
            <div class="flex items-center">
              {{ item.fname }} {{ item.lname }}
            </div>
          </td>
          <td class="border-t px-6 py-4">
            {{ item.address }}
          </td>
          <td class="border-t px-6 py-4">
            {{ item.city }}
          </td>
          <td class="border-t px-6 py-4">
            {{ item.state }}
          </td>
          <td class="border-t px-6 py-4">
            {{ item.zipcode }}
          </td>
          <td class="border-t px-6 py-4">
            <Icons name="check" class="h-5 w-5 fill-green-400" v-if="item.is_default" />
          </td>
          <td class="border-t px-6 py-4">
            <div class="flex items-center">
              <Button 
                size="xs"
                color="gray"
                @click.stop="showShippingModal(item)"
              >
                {{ $t('Edit') }}
              </Button>
              <Button size="xs" color="red" class="ml-3" @click.stop="deleteShipping(item.id)">
                {{ $t('Delete') }}
              </Button>
              <Icons name="cheveron-right" class="block w-6 h-6 fill-gray-400 rtl:rotate ml-3" />
            </div>
          </td>
        </tr>
        <tr v-if="shipping_addresses.length === 0">
          <td class="border-t px-6 py-4" colspan="7">{{ $t('no_x_found', { x: $tc('Shipping Address') }) }}</td>
        </tr>
      </table>
    </div>
    <div class="mt-12 flex align-center justify-between">
      <h2 class="font-bold text-2xl">{{ $t('Billing Address') }}</h2>
      <div>
        <Button size="sm" color="gray" @click="showBillingModal(null)">
          {{ $t('add_x', {'x': $t('Billing')}) }}
        </Button>
      </div>
    </div>
    <div class="mt-6 bg-white rounded shadow overflow-x-auto scroll-on-light">
      <table class="w-full whitespace-no-wrap">
        <tr class="text-left font-bold">
          <th class="px-6 pt-6 pb-4">{{ $t('Name') }}</th>
          <th class="px-6 pt-6 pb-4">{{ $t('Address') }}</th>
          <th class="px-6 pt-6 pb-4">{{ $t('City') }}</th>
          <th class="px-6 pt-6 pb-4">{{ $t('State') }}</th>
          <th class="px-6 pt-6 pb-4">{{ $tc('Zipcode') }}</th>
          <th class="px-6 pt-6 pb-4">{{ $tc('Default') }}</th>
          <th class="px-6 pt-6 pb-4">{{ $tc('Action') }}</th>
        </tr>
        <tr
          :key="billing_addresses.id"
          @click="setBillingDefault(item.id)"
          v-for="item in billing_addresses"
          class="cursor-pointer hover:bg-gray-200"
        >
          <td class="border-t px-6 py-4">
            <div class="flex items-center">
              {{ item.fname }} {{ item.lname }}
            </div>
          </td>
          <td class="border-t px-6 py-4">
            {{ item.address }}
          </td>
          <td class="border-t px-6 py-4">
            {{ item.city }}
          </td>
          <td class="border-t px-6 py-4">
            {{ item.state }}
          </td>
          <td class="border-t px-6 py-4">
            {{ item.zipcode }}
          </td>
          <td class="border-t px-6 py-4">
            <Icons name="check" class="h-5 w-5 fill-green-400" v-if="item.is_default" />
          </td>
          <td class="border-t px-6 py-4">
            <div class="flex items-center">
              <Button 
                size="xs"
                color="gray"
                @click.stop="showBillingModal(item)"
              >
                {{ $t('Edit') }}
              </Button>
              <Button size="xs" color="red" class="ml-3" @click.stop="deleteBilling(item.id)">
                {{ $t('Delete') }}
              </Button>
              <Icons name="cheveron-right" class="block w-6 h-6 fill-gray-400 rtl:rotate ml-3" />
            </div>
          </td>
        </tr>
        <tr v-if="billing_addresses.length === 0">
          <td class="border-t px-6 py-4" colspan="7">{{ $t('no_x_found', { x: $tc('Billing Address') }) }}</td>
        </tr>
      </table>
    </div>
    <h2 class="mt-12 font-bold text-2xl">{{ $t('Service') }} {{ $tc('Measurement', 2) }}</h2>
    <div class="mt-6 bg-white rounded shadow overflow-x-auto scroll-on-light">
      <table class="w-full whitespace-no-wrap">
        <tr class="text-left font-bold">
          <th class="px-6 pt-6 pb-4">{{ $t('Name') }}</th>
          <th class="px-6 pt-6 pb-4">{{ $tc('Service') }}</th>
          <th class="px-6 pt-6 pb-4">{{ $tc('Field', 2) }}</th>
          <th class="px-6 pt-6 pb-4" colspan="2">{{ $tc('Measurement') }}</th>
        </tr>
        <tr
          :key="measurement.id"
          @click="rowClicked(measurement.id)"
          v-for="measurement in customer.measurements"
          class="cursor-pointer hover:bg-teal-200 focus-within:bg-teal-200"
        >
          <td class="border-t px-6 py-4">
            <div class="flex items-center">
              {{ measurement.name }}
              <Icons v-if="measurement.deleted_at" name="trash" class="flex-shrink-0 w-3 h-3 fill-gray-400 ml-2" />
            </div>
          </td>
          <td class="border-t px-6 py-4">
            <div v-if="measurement.service">
              {{ measurement.service.name }}
            </div>
          </td>
          <td class="border-t px-6 py-4 w-56 max-w-sm" style="min-width: 250px">
            <span class="whitespace-normal" v-html="displayExtra(measurement.extra_attributes)"></span>
          </td>
          <td class="border-t px-6 py-4">
            {{ measurement.measurement }}
          </td>
          <td class="border-t px-6 py-4 w-8">
            <Icons name="cheveron-right" class="block w-6 h-6 fill-gray-400 rtl:rotate" />
          </td>
        </tr>
        <tr v-if="customer.measurements.length === 0">
          <td class="border-t px-6 py-4" colspan="5">{{ $t('no_x_found', { x: $tc('Measurement') }) }}</td>
        </tr>
      </table>
    </div>
    <Modal :show="viewShipping" max-width="2xl" :closeable="true" @close="viewShipping = false">
      <ShippingModal 
        :shippingAddress="shippingAddress" 
        :show="viewShipping"
        :customer_id="customer.id"
        @close="() => (viewShipping = false)" />
    </Modal>
    <Modal :show="viewBilling" max-width="2xl" :closeable="true" @close="viewBilling = false">
      <BillingModal 
        :billingAddress="billingAddress" 
        :show="viewBilling"
        :customer_id="customer.id"
        @close="() => (viewBilling = false)" />
    </Modal>
  </div>
</template>

<script>
import Layout from '@/Shared/Layout.vue';
import Modal from '@/Jetstream/Modal.vue';
import Button from '@/Jetstream/Button.vue';
import DeleteMixin from '@/Misc/DeleteMixin';
import TextInput from '@/Shared/TextInput.vue';
import SelectInput from '@/Shared/SelectInput.vue';
import LoadingButton from '@/Shared/LoadingButton.vue';
import TrashedMessage from '@/Shared/TrashedMessage.vue';
import BillingModal from '@/Pages/Customers/BillingModal.vue';
import ShippingModal from '@/Pages/Customers/ShippingModal.vue';
import DeleteRestoreComponent from '@/Shared/DeleteRestoreComponent.vue';

export default {
  layout: Layout,
  remember: 'form',
  props: { customer: Object },
  mixins: [DeleteMixin('customer')],
  components: { 
    Modal,
    Button, 
    TextInput, 
    SelectInput, 
    BillingModal,
    ShippingModal,
    LoadingButton, 
    TrashedMessage, 
    DeleteRestoreComponent, 
  },
  metaInfo() {
    return {
      title: this.$t('edit_x', { x: this.form.name }),
    };
  },
  watch: {
    customer: function (v) {
      this.shipping_addresses = v.shipping_addresses
      this.billing_addresses = v.billing_addresses
    },
  },
  data() {
    return {
      restore: false,
      sending: false,
      form: {
        name: this.customer.name,
        email: this.customer.email,
        phone: this.customer.phone,
        address: this.customer.address,
        description: this.customer.description,
      },
      shipping_addresses: this.customer.shipping_addresses,
      shippingAddress: null,
      viewShipping: false,
      billing_addresses: this.customer.billing_addresses,
      billingAddress: null,
      viewBilling: false,
    };
  },
  methods: {
    rowClicked(n) {
      this.$inertia.visit(this.route('measurements.edit', n));
    },
    submit() {
      this.sending = true;
      this.$inertia.put(this.route('customers.update', this.customer.id), this.form, {
        onFinish: () => (this.sending = false),
      });
    },
    displayExtra(attr) {
      let extra = '';
      if (Array.isArray(attr)) {
        attr.map((a, i) => {
          for (let [key, value] of Object.entries(a)) {
            if (value.includes('{') && value.includes('}') && value.includes(':')) {
              extra += `<span class="inline-block"><strong>${key}</strong>: `;
              const cbv = JSON.parse(value);
              for (let [k, v] of Object.entries(cbv)) {
                if (v) {
                  extra += `<span class="inline-block text-green-600 ltr:mr-2 rtl:ml-2">&#10003; ${k},</span> `;
                } else {
                  extra += `<span class="inline-block text-red-500 ltr:mr-2 rtl:ml-2">&#10005; ${k},</span> `;
                }
              }
              extra += `</span>`;
            } else {
              extra += `<span class="inline-block"><strong>${key}</strong>: ${value},</span> `;
            }
          }
        });
      }
      return extra;
    },
    setShippingDefault(shipping_address_id) {
      this.$inertia.post(this.route('customer_info.shipping.default'), {
        shipping_address_id,
        customer_id: this.customer.id
      }, {
        onError: (response) => {
          this.errors = response
        }
      });
    },
    deleteShipping(shipping_address_id) {
      this.$inertia.delete(this.route('customer_info.shipping.delete', shipping_address_id), null, {
        onError: (response) => {
          this.errors = response
        }
      });
    },
    showShippingModal(shippingAddress) {
      this.shippingAddress = shippingAddress
      this.viewShipping = true
    },
    setBillingDefault(billing_address_id) {
      this.$inertia.post(this.route('customer_info.billing.default'), {
        billing_address_id,
        customer_id: this.customer.id
      }, {
        onError: (response) => {
          this.errors = response
        }
      });
    },
    deleteBilling(billing_address_id) {
      this.$inertia.delete(this.route('customer_info.billing.delete', billing_address_id), null, {
        onError: (response) => {
          this.errors = response
        }
      });
    },
    showBillingModal(billingAddress) {
      this.billingAddress = billingAddress
      this.viewBilling = true
    }
  },
};
</script>
