<template>
  <div>
    <h1 class="mb-6 mt-2 font-bold text-lg md:text-2xl">
      <Link class="text-gray-600 hover:text-gray-800 inline-flex items-center" :href="route('product_orders')">
      <Icons name="back" class="flex-shrink-0 w-3 h-3 md:w-5 md:h-5 fill-current ltr:mr-2 rtl:ml-2 rtl:rotate" />
      {{ $tc('Product Order', 2) }}
      </Link>
      <span class="text-gray-400 font-medium mx-2">/</span>
      {{ order.reference }}
    </h1>
    <div class="bg-white rounded shadow max-w-3xl">
      <form @submit.prevent="submit" autocomplete="off">
        <div class="p-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap">
          <div class="w-full flex pb-8">
            <div class="ltr:pr-6 rtl:pl-6 w-full lg:w-1/2">
              <label class="form-label font-medium text-gray-700" for="customer_id">
                {{ $tc('Customer') }}
              </label>
              <v-select transition="" v-model="customer" :clearable="false" :options="customers" input-id="customer_id"
                @option:selected="customerChanged" :dir="$page.props.user.account.direction"
                :placeholder="$t('search_x', { x: $tc('Customer') })" :class="{ error: false }"></v-select>
            </div>
            <text-input :label="$t('Reference')" v-model="form.reference" :errors="$page.props.errors?.reference"
              class="ltr:pr-6 rtl:pl-6 w-full lg:w-1/2" />
          </div>
          <div class="w-full flex pb-8">
            <v-select transition="" v-model="product" :clearable="false" :options="products" @option:selected="addToOrder"
              :dir="$page.props.user.account.direction" :placeholder="$t('Search product to add to order')"
              class="ltr:pr-6 rtl:pl-6 w-full"></v-select>
          </div>
          <div class="ltr:mr-6 rtl:ml-6 mb-8 w-full border rounded overflow-x-auto lg:overflow-x-hidden pb-4 lg:pb-0">
            <table class="w-full">
              <thead>
                <tr>
                  <th class="border-b pl-4 pr-2 py-2 bg-gray-200 text-center">No</th>
                  <th class="border-b pl-2 pr-4 py-2 bg-gray-200 ltr:text-left rtl:text-right"></th>
                  <th class="border-b pl-2 pr-4 py-2 bg-gray-200 ltr:text-left rtl:text-right">{{ $tc('Product') }}</th>
                  <th class="border-b px-4 py-2 bg-gray-200 w-40">{{ $tc('Customization') }}</th>
                  <th class="border-b px-4 py-2 bg-gray-200 w-16">{{ $t('Price') }}</th>
                  <th class="border-b px-4 py-2 bg-gray-200 w-12">{{ $t('Qty') }}</th>
                  <th class="border-b px-4 py-2 bg-gray-200">{{ $t('Amount') }}</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="(cart, index) in form.carts" :key="'cart_' + cart.id">
                  <td class="border-b pl-4 pr-2 py-2">
                    <div class="flex flex-col content-center items-center justify-around w-6">
                      <div class="pt-1">{{ index + 1 }}</div>
                      <button type="button" @click="removeCart(cart.id)"
                        class="mt-1 p-1 text-gray-500 hover:text-red-600">
                        <Icons name="trash" class="flex-shrink-0 w-3 h-3 fill-current" />
                      </button>
                    </div>
                  </td>
                  <td class="border-b px-4 py-2 no-drop">
                    <img :src="'/storage/product/' + cart.product.main_photo" alt="product-photo"
                      class="h-12 object-cover" />
                  </td>
                  <td class="border-b pl-2 pr-4 py-2 leading-normal">
                    {{ cart.product.name }}
                  </td>
                  <td class="border-b px-4 py-2 no-drop">
                    <div v-if="isCustomizable(cart)"
                      :class="`bg-${cart.customization ? 'gray' : 'red'}-500 rounded text-sm py-1 px-2 text-white cursor-pointer w-20 text-center mx-auto`"
                      @click="openCustomizationField(cart)">
                      {{ cart.customization ? 'Edit' : 'Add' }}
                    </div>
                    <div v-else class="text-center font-bold">
                      N/A
                    </div>
                  </td>
                  <td class="border-b px-4 py-2 ltr:text-right rtl:text-left no-drop">
                    {{ $number(cart.unit) }}
                  </td>
                  <td class="border-b px-4 py-2 no-drop">
                    <text-input small type="number" class="w-16 text-center" v-model="cart.qty" />
                  </td>
                  <td class="border-b px-4 py-2 ltr:text-right rtl:text-left">
                    {{ $number(cart.unit * cart.qty) }}
                  </td>
                </tr>
              </tbody>
              <tfoot>
                <tr>
                  <th class="border-b px-4 py-2 bg-gray-200 ltr:text-right rtl:text-left" colspan="5">{{ $t('Total') }}</th>
                  <th class="border-b px-4 py-2 bg-gray-200 text-center">{{ totalQuantity }}</th>
                  <th class="border-b px-4 py-2 bg-gray-200 ltr:text-right rtl:text-left">
                    {{ $number(totalAmount) }}
                  </th>
                </tr>
              </tfoot>
            </table>
          </div>
        </div>
        <div class="px-8 py-4 bg-gray-100 border-t border-gray-200 flex items-center">
          <loading-button :loading="sending" class="btn-gray ltr:ml-auto rtl:mr-auto" type="submit">
            {{ $t('update_x', { x: $tc('Product Order', 1) }) }}
          </loading-button>
        </div>
      </form>
    </div>
    <Modal :show="viewModal" max-width="3xl" :closeable="true" @close="() => (viewModal = false)">
      <Customization 
        :opened="viewModal" 
        :cart="cart" 
        :icustom_fields="custom_fields"
        @submit="(form) => changeCustomization(form)"
        @close="() => (viewModal = false)" />
    </Modal>
  </div>
</template>
  
<script>
import Filters from '@/Misc/Filters';
import Layout from '@/Shared/Layout.vue';
import Modal from '@/Jetstream/Modal.vue';
import TextInput from '@/Shared/TextInput.vue';
import LoadingButton from '@/Shared/LoadingButton.vue';
import Customization from '@/Pages/ProductOrders/Customization.vue';

export default {
  layout: Layout,
  remember: 'form',
  props: {
    order: Object,
    iproducts: Array,
    icustomers: Array,
    icategories: Array
  },
  components: { LoadingButton, TextInput, Modal, Customization },
  metaInfo() {
    return {
      title: this.$tc('Product Order', 2),
    };
  },
  data() {
    return {
      viewModal: false,
      customers: [],
      products: [],
      customer: this.icustomers.find(item => {
        return item.id === this.order.customer.id
      }),
      form: {
        reference: this.order.reference,
        customer_id: this.order.customer_id,
        carts: []
      },
      sending: false,
      errors: {},
      product: null,
      cart: null,
      custom_fields: []
    }
  },
  mounted() {
    this.customers = this.icustomers;
    this.products = this.iproducts;
    this.form.carts = this.order.carts.map(item => ({
      id: item.id,
      unit: item.unit,
      qty: item.quantity,
      product: this.iproducts.find(item2 => {
        return Number(item2.id) === Number(item.product_id)
      }),
      customization: JSON.parse(item.customization),
    }))
  },
  computed: {
    totalAmount() {
      return this.form.carts.reduce((a, s) => parseFloat(s.unit) * parseFloat(s.qty) + a, 0);
    },
    totalQuantity() {
      return this.form.carts.reduce((a, s) => parseFloat(s.qty) + a, 0);
    },
  },
  methods: {
    ...Filters,
    submit() {
      const data = this.form.carts.map(item => ({
        id: item.id,
        customization: JSON.stringify(item.customization),
        product_id: item.product.id,
        quantity: item.qty,
        unit: item.unit
      }))
      this.$inertia.put(this.route('product_orders.update', this.order.id), {
        carts: data,
        customer: this.form.customer_id,
        reference: this.form.reference
      }, {
        onFinish: () => (this.sending = false),
      });
    },
    customerChanged(c) {
      this.form.customer_id = c ? c.value : null;
    },
    addToOrder(s) {
      const maxId = Math.max(...this.form.carts.map(cart => cart.id));
      this.form.carts.push({
        id: maxId + 1,
        unit: s.price,
        qty: 1,
        product: s,
        customization: null
      });
      this.product = null
    },
    openCustomizationField(cart) {
      this.cart = cart
      this.custom_fields = this.icategories.find(item => {
        return Number(item.id) === Number(cart.product.category_id)
      }).custom_fields
      this.viewModal = true
    },
    changeCustomization(p) {
      this.viewModal = false;
      const cartIndex = this.form.carts.findIndex(item =>  Number(item.id) === Number(p.id))
      this.form.carts[cartIndex].customization = p.data
    },
    removeCart(id) {
      this.form.carts = this.form.carts.filter(item => Number(item.id) !== Number(id))
    },
    isCustomizable(cart) {
      return this.icategories.find(item => {
        return Number(item.id) === Number(cart.product.category_id)
      }).custom_fields.length > 0
    }
  }
};
</script>
  