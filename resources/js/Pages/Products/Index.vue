<template>
  <div>
    <h1 class='mb-6 mt-2 font-bold text-lg md:text-2xl'>{{ $tc('Product', 2) }}</h1>
    <div class='np mb-6 flex justify-between items-center'>
      <search-filter v-model='form.search' :dropdown='false' class='w-full max-w-md ltr:mr-4 rtl:ml-4' @reset='reset' />
      <div>
        <Button
          class='btn-gray mr-4'
          type='button'
          @click='importProducts'
        >
          {{ $t('import_x', { x: $tc('Product') }) }}
        </Button>

        <Button
          class='btn-gray mr-4'
          type='button'
          @click='exportProducts'
        >
          {{ $t('export_x', { x: $tc('Product') }) }}
        </Button>

        <Link class='btn-gray' :href="route('products.create')">
          <span class='inline md:hidden'><Icons name='add'
                                                class='w-4 h-4 text-white group-hover:text-white fill-white' /></span>
          <span class='hidden md:inline'>{{ $t('create_x', { x: $tc('Product') }) }}</span>
        </Link>
      </div>
    </div>
    <div class='bg-white rounded shadow overflow-x-auto scroll-on-light'>
      <table class='w-full whitespace-no-wrap'>
        <thead>
        <tr class='text-left font-bold'>
          <th class='px-6 pt-6 pb-4'>{{ $t('Name') }}</th>
          <th class='px-6 pt-6 pb-4'>{{ $t('Category') }}</th>
          <th class='px-6 pt-6 pb-4'>{{ $t('Type') }}</th>
          <th class='px-6 pt-6 pb-4'>{{ $t('Photo') }}</th>
          <th class='px-6 pt-6 pb-4'>{{ $t('Price') }}</th>
          <th class='px-6 pt-6 pb-4'>{{ $t('Description') }}</th>
        </tr>
        </thead>
        <tbody>
        <tr
          :key='product.id'
          v-for='product in products.data'
          @click='rowClicked(product.id)'
          class='cursor-pointer hover:bg-teal-200 focus-within:bg-teal-200'
        >
          <td class='border-t px-6 py-4'>
            <div class='flex items-center'>
              {{ product.name }}
              <Icons v-if='product.deleted_at' name='trash' class='flex-shrink-0 w-3 h-3 fill-gray-400 ml-2' />
            </div>
          </td>
          <td class='border-t px-6 py-4'>
            <div class='flex items-center'>
              {{ product.category.name }}
            </div>
          </td>
          <td class='border-t px-6 py-4 max-w-lg truncate'>
            {{ $capitalize(product.type) }}
          </td>
          <td class='border-t px-6 py-4 max-w-lg truncate'>
            <img :src="'/storage/product/' + product.main_photo" alt='product-photo' class='h-12 object-cover' />
          </td>
          <td class='border-t px-6 py-4 max-w-lg truncate'>
            {{ product.price }}
          </td>
          <td class='border-t px-6 py-4 max-w-lg truncate'>
            {{ product.description }}
          </td>
          <td class='border-t px-6 py-4 w-8'>
            <Icons name='cheveron-right' class='block w-6 h-6 fill-gray-400 rtl:rotate' />
          </td>
        </tr>
        <tr v-if='products.data.length === 0'>
          <td class='border-t px-6 py-4' colspan='5'>{{ $t('no_x_found', { x: $tc('Product') }) }}</td>
        </tr>
        </tbody>
      </table>
    </div>
    <pagination :links='products.links' :meta='products.meta' />
    <Modal v-if='viewModal' :show='viewModal' max-width='2xl' :closeable='true' @close='() => (viewModal = false)'>
      <form @submit.prevent='submit' autocomplete='off'>
        <div class='px-8 pb-8 pt-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap'>
          <file-input type='file' accept='text/csv' :label="$t('Pick CSV file.')" v-model='form.csv'
                      class='ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-full' />
        </div>
        <div class='px-8 py-4 bg-gray-100 border-t border-gray-200 flex justify-end'>
          <loading-button :loading='sending' class='btn-gray' type='submit'>
            {{ $t('import_x', { x: $tc('Products') }) }}
          </loading-button>
          <Button
            class='btn-gray ml-4'
            type='button'
            @click='closeModal'
          >
            {{ $tc('Close') }}
          </Button>
        </div>
      </form>
    </Modal>
  </div>
</template>

<script>
import pickBy from 'lodash/pickBy';
import throttle from 'lodash/throttle';
import Layout from '@/Shared/Layout.vue';
import mapValues from 'lodash/mapValues';
import Pagination from '@/Shared/Pagination.vue';
import SearchFilter from '@/Shared/SearchFilter.vue';
import Modal from '@/Jetstream/Modal.vue';
import FileInput from '@/Shared/FileInput.vue';
import Button from '@/Jetstream/Button.vue';
import LoadingButton from '@/Shared/LoadingButton.vue';

export default {
  layout: Layout,
  props: { products: Object, search: String },
  components: { Pagination, SearchFilter, Modal, FileInput, Button, LoadingButton },
  data() {
    return {
      form: {
        search: this.search,
        csv: null,
      },
      viewModal: false,
      sending: false,
    };
  },
  watch: {
    form: {
      handler: throttle(function() {
        let query = pickBy(this.form);
        this.$inertia.replace(this.route('products', Object.keys(query).length ? query : { remember: 'forget' }));
      }, 250),
      deep: true,
    },
  },
  metaInfo() {
    return { title: this.$tc('Product', 2) };
  },
  methods: {
    rowClicked(n) {
      this.$inertia.visit(this.route('products.edit', n));
    },
    reset() {
      this.form = mapValues(this.form, () => null);
    },
    closeModal() {
      this.viewModal = false;
      this.sending = false;
    },
    importProducts() {
      this.form.csv = null;
      this.viewModal = true;
    },
    async exportProducts() {
      this.$axios.post(this.route('products.export'))
        .then(res => {
          const now = new Date();

          const year = now.getFullYear();
          const month = (now.getMonth() + 1).toString().padStart(2, '0'); // add leading zero if month is less than 10
          const day = now.getDate().toString().padStart(2, '0'); // add leading zero if day is less than 10
          const hour = now.getHours().toString().padStart(2, '0'); // add leading zero if hour is less than 10
          const minute = now.getMinutes().toString().padStart(2, '0'); // add leading zero if minute is less than 10
          const second = now.getSeconds().toString().padStart(2, '0'); // add leading zero if second is less than 10

          const filename = 'products_' + `${year}_${month}_${day}_${hour}_${minute}_${second}.csv`;

          var universalBOM = '\uFEFF';
          var a = window.document.createElement('a');
          a.setAttribute('href', 'data:text/csv; charset=utf-8,' + encodeURIComponent(universalBOM + res.data));
          a.setAttribute('download', filename);
          window.document.body.appendChild(a);
          a.click();
        });
    },
    submit() {
      if (this.sending)
        return;

      if (!this.form.csv)
        return;

      this.sending = true;

      var data = new FormData();
      data.append('csv', this.form.csv || '');

      this.$inertia.post(this.route('products.import'), data, {
        onFinish: (res) => {
          const thiz = this;
          setTimeout(function() {
            thiz.viewModal = false;
          }, 2000);

          this.sending = false;
        },
      });
    },
  },
};
</script>
