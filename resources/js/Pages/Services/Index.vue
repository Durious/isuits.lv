<template>
  <div>
    <h1 class='mb-6 mt-2 font-bold text-lg md:text-2xl'>{{ $tc('Service', 2) }}</h1>
    <div class='np mb-6 flex justify-between items-center'>
      <search-filter v-model='form.search' class='w-full max-w-md ltr:mr-4 rtl:ml-4' @reset='reset'>
        <label class='block text-gray-700'>{{ $t('Trashed') }}</label>
        <v-select
          v-model='form.trashed'
          :options="[
            { value: '', label: 'Not Trashed' },
            { value: 'with', label: $t('With Trashed') },
            { value: 'only', label: $t('Only Trashed') },
          ]"
          :reduce='selected => selected.value'
        ></v-select>
      </search-filter>
      <div>
        <Button
          class='btn-gray mr-4'
          type='button'
          @click='importServices'
        >
          {{ $t('import_x', { x: $tc('Service') }) }}
        </Button>

        <Button
          class='btn-gray mr-4'
          type='button'
          @click='exportServices'
        >
          {{ $t('export_x', { x: $tc('Service') }) }}
        </Button>
        <Link class='btn-gray' :href="route('services.create')">
          <span class='inline md:hidden'><Icons name='add'
                                                class='w-4 h-4 text-white fill-white group-hover:text-white fill-white' /></span>
          <span class='hidden md:inline'>{{ $t('create_x', { x: $tc('Service') }) }}</span>
        </Link>
      </div>
    </div>
    <div class='bg-white rounded shadow overflow-x-auto scroll-on-light'>
      <table class='w-full whitespace-no-wrap'>
        <thead>
        <tr class='text-left font-bold'>
          <th class='px-6 pt-6 pb-4'>{{ $t('Code') }}</th>
          <th class='px-6 pt-6 pb-4'>{{ $t('Name') }}</th>
          <th class='px-6 pt-6 pb-4'>{{ $t('Image') }}</th>
          <th class='px-6 pt-6 pb-4'>{{ $t('Status') }}</th>
          <th class='px-6 pt-6 pb-4 text-right'>{{ $t('Price') }}</th>
          <th class='px-6 pt-6 pb-4' colspan='2'>{{ $t('Description') }}</th>
        </tr>
        </thead>
        <tbody>
        <tr
          :key='service.id'
          @click='rowClicked(service.id)'
          v-for='service in services.data'
          class='cursor-pointer hover:bg-teal-200 focus-within:bg-teal-200'
        >
          <td class='border-t px-6 py-4'>
            <div class='flex items-center'>
              {{ service.code }}
              <Icons v-if='service.deleted_at' name='trash' class='flex-shrink-0 w-3 h-3 fill-gray-400 ml-2' />
            </div>
          </td>
          <td class='border-t px-6 py-4'>
            {{ service.name }}
          </td>
          <td class='border-t px-6 py-4'>
            <img :src="'/storage/service/' + service.photo" alt='service-photo' class='h-12 object-contain' />
          </td>
          <td class='border-t px-6 py-4'>
              <span :class="`${service.active == 1 ? 'bg-green-200' : 'bg-red-200'} rounded text-sm py-1 px-2`">
                {{ service.active == 1 ? $t('Active') : $t('Deactive') }}
              </span>
          </td>
          <td class='border-t px-6 py-4'>
            <div class='flex items-center justify-end'>
              <Icons v-if='service.active' name='check'
                     class='flex-shrink-0 w-3 h-3 fill-green-600 ltr:mr-2 rtl:ml-2' />
              <div class='text-right'>{{ $number(service.price) }}</div>
            </div>
          </td>
          <td class='border-t px-6 py-4 max-w-lg truncate'>
            {{ service.description }}
          </td>
          <td class='border-t px-6 py-4 w-8'>
            <Icons name='cheveron-right' class='block w-6 h-6 fill-gray-400 rtl:rotate' />
          </td>
        </tr>
        <tr v-if='services.data.length === 0'>
          <td class='border-t px-6 py-4' colspan='5'>{{ $t('no_x_found', { x: $tc('Service') }) }}</td>
        </tr>
        </tbody>
      </table>
    </div>
    <pagination :links='services.links' :meta='services.meta' />
    <Modal v-if='viewModal' :show='viewModal' max-width='2xl' :closeable='true' @close='() => (viewModal = false)'>
      <form @submit.prevent='submit' autocomplete='off'>
        <div class='px-8 pb-8 pt-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap'>
          <file-input type='file' accept='text/csv' :label="$t('Pick CSV file.')" v-model='form.csv'
                      class='ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-full' />
        </div>
        <div class='px-8 py-4 bg-gray-100 border-t border-gray-200 flex justify-end'>
          <loading-button :loading='sending' class='btn-gray' type='submit'>
            {{ $t('import_x', { x: $tc('Services') }) }}
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
import Icon from '@/Shared/Icon.vue';
import pickBy from 'lodash/pickBy';
import Layout from '@/Shared/Layout.vue';
import throttle from 'lodash/throttle';
import mapValues from 'lodash/mapValues';
import Pagination from '@/Shared/Pagination.vue';
import SearchFilter from '@/Shared/SearchFilter.vue';
import Modal from '@/Jetstream/Modal.vue';
import FileInput from '@/Shared/FileInput.vue';
import Button from '@/Jetstream/Button.vue';
import LoadingButton from '@/Shared/LoadingButton.vue';

export default {
  layout: Layout,
  props: { services: Object, filters: Object },
  components: { Icon, Pagination, SearchFilter, Modal, FileInput, Button, LoadingButton },
  metaInfo() {
    return { title: this.$tc('Service', 2) };
  },
  data() {
    return {
      form: {
        search: this.filters.search,
        trashed: this.filters.trashed,
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
        this.$inertia.replace(this.route('services', Object.keys(query).length ? query : { remember: 'forget' }));
      }, 250),
      deep: true,
    },
  },
  methods: {
    rowClicked(n) {
      this.$inertia.visit(this.route('services.edit', n));
    },
    reset() {
      this.form = mapValues(this.form, () => null);
    },
    closeModal() {
      this.viewModal = false;
      this.sending = false;
    },
    importServices() {
      this.form.csv = null;
      this.viewModal = true;
    },
    async exportServices() {
      this.$axios.post(this.route('services.export'))
        .then(res => {
          const now = new Date();

          const year = now.getFullYear();
          const month = (now.getMonth() + 1).toString().padStart(2, '0'); // add leading zero if month is less than 10
          const day = now.getDate().toString().padStart(2, '0'); // add leading zero if day is less than 10
          const hour = now.getHours().toString().padStart(2, '0'); // add leading zero if hour is less than 10
          const minute = now.getMinutes().toString().padStart(2, '0'); // add leading zero if minute is less than 10
          const second = now.getSeconds().toString().padStart(2, '0'); // add leading zero if second is less than 10

          const filename = 'services_' + `${year}_${month}_${day}_${hour}_${minute}_${second}.csv`;

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

      this.$inertia.post(this.route('services.import'), data, {
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
