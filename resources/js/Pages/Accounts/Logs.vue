<template>
  <div>
    <div>
      <h1 class="mb-6 mt-2 font-bold text-lg md:text-2xl">{{ $tc('Log', 2) }}</h1>
      <div class="np mb-6 flex justify-between items-center">
        <search-filter no-slot v-model="form.search" class="w-full max-w-md ltr:mr-4 rtl:ml-4" @reset="reset" :dropdown="false">
        </search-filter>
      </div>
      <div class="bg-white rounded shadow overflow-x-auto">
        <table class="w-full whitespace-no-wrap">
          <thead>
            <tr class="text-left font-bold">
              <th class="px-6 pt-6 pb-4">{{ $t('Created at') }}</th>
              <th class="px-6 pt-6 pb-4">{{ $t('Name') }}</th>
              <th class="px-6 pt-6 pb-4">{{ $t('Description') }}</th>
              <th class="px-6 pt-6 pb-4" colspan="2">{{ $t('By') }}</th>
            </tr>
          </thead>
          <tbody>
            <tr
              :key="log.id"
              @click="rowClicked(log.id)"
              v-for="log in logs.data"
              class="cursor-pointer hover:bg-teal-200 focus-within:bg-teal-200"
            >
              <td class="border-t px-6 py-4">
                {{ $datetime(log.created_at) }}
              </td>
              <td class="border-t px-6 py-4">
                <div class="flex items-center">
                  {{ log.log_name }}
                  <Icons v-if="log.deleted_at" name="trash" class="flex-shrink-0 w-3 h-3 fill-gray-400 ml-2" />
                </div>
              </td>
              <td class="border-t px-6 py-4">
                <div class="flex items-center">
                  {{ log.description }}
                  <Icons v-if="log.deleted_at" name="trash" class="flex-shrink-0 w-3 h-3 fill-gray-400 ml-2" />
                </div>
              </td>
              <td class="border-t px-6 py-4">
                <div v-if="log.causer">
                  {{ log.causer.name }}
                </div>
                <div v-if="!log.causer && log.log_name==='ProductOrder' && log.event==='updated'" >
                  {{ $t('Webhook') }}
                </div>
              </td>
              <td class="border-t px-6 py-4 w-8">
                <Icons name="cheveron-right" class="block w-6 h-6 fill-gray-400 rtl:rotate" />
              </td>
            </tr>
            <tr v-if="logs.data.length === 0">
              <td class="border-t px-6 py-4" colspan="4">{{ $t('no_x_found', { x: $tc('Log') }) }}</td>
            </tr>
          </tbody>
        </table>
      </div>
      <pagination :links="logs.links" :meta="logs.meta" />
    </div>
    <Modal :show="viewModal" max-width="2xl" :closeable="true" @close="() => (viewModal = false)">
      <ShowLog :log="log" @close="() => (viewModal = false)" />
    </Modal>
  </div>
</template>

<script>
import ShowLog from './ShowLog.vue';
import pickBy from 'lodash/pickBy';
import throttle from 'lodash/throttle';
import mapValues from 'lodash/mapValues';
import Layout from '@/Shared/Layout.vue';
import Modal from '@/Jetstream/Modal.vue';
import Pagination from '@/Shared/Pagination.vue';
import SearchFilter from '@/Shared/SearchFilter.vue';

export default {
  layout: Layout,
  components: { Pagination, SearchFilter, ShowLog, Modal },
  props: { logs: Object, filters: Object },
  metaInfo() {
    return { title: this.$tc('Log', 2) };
  },
  data() {
    return {
      form: {
        search: this.filters.search,
        trashed: this.filters.trashed,
      },
      log: null,
      viewModal: false,
    };
  },
  watch: {
    form: {
      handler: throttle(function () {
        let query = pickBy(this.form);
        this.$inertia.replace(this.route('logs', Object.keys(query).length ? query : { remember: 'forget' }));
      }, 150),
      deep: true,
    },
  },
  methods: {
    rowClicked(n) {
      this.log = this.logs.data.find(l => l.id == n);
      this.viewModal = true;
    },
    reset() {
      this.form = mapValues(this.form, () => null);
    },
  },
};
</script>
