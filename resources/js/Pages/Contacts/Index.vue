<template>
  <div>
    <h1 class="mb-6 mt-2 font-bold text-lg md:text-2xl">{{ $tc('Contact', 2) }}</h1>
    <div class="np mb-6 flex justify-between items-center">
      <search-filter v-model="form.search" class="w-full max-w-md ltr:mr-4 rtl:ml-4" @reset="reset">
        <label class="block text-gray-700">{{ $t('Trashed') }}</label>
        <v-select
          v-model="form.trashed"
          :options="[
            { value: '', label: 'Not Trashed' },
            { value: 'with', label: $t('With Trashed') },
            { value: 'only', label: $t('Only Trashed') },
          ]"
          :reduce="selected => selected.value"
        ></v-select>
      </search-filter>
      <Link class="btn-gray" :href="route('contacts.create')">
        <span class="inline md:hidden"><Icons name="add" class="w-4 h-4 text-white fill-white group-hover:text-white fill-white" /></span>
        <span class="hidden md:inline">{{ $t('create_x', { x: $tc('Contact') }) }}</span>
      </Link>
    </div>
    <div class="bg-white rounded shadow overflow-x-auto scroll-on-light">
      <table class="w-full whitespace-no-wrap">
        <thead>
          <tr class="text-left font-bold">
            <th class="px-6 pt-6 pb-4">{{ $t('Name') }}</th>
            <th class="px-6 pt-6 pb-4">{{ $t('Phone') }}</th>
            <th class="px-6 pt-6 pb-4">{{ $t('Email') }}</th>
            <th class="px-6 pt-6 pb-4" colspan="2">{{ $t('Description') }}</th>
          </tr>
        </thead>
        <tbody>
          <tr
            :key="contact.id"
            @click="rowClicked(contact.id)"
            v-for="contact in contacts.data"
            class="cursor-pointer hover:bg-teal-200 focus-within:bg-teal-200"
          >
            <td class="border-t px-6 py-4">
              <div class="flex items-center">
                {{ contact.name }}
                <Icons v-if="contact.deleted_at" name="trash" class="flex-shrink-0 w-3 h-3 fill-gray-400 ml-2" />
              </div>
            </td>
            <td class="border-t px-6 py-4">
              {{ contact.phone }}
            </td>
            <td class="border-t px-6 py-4">
              {{ contact.email }}
            </td>
            <td class="border-t px-6 py-4 max-w-lg truncate">
              {{ contact.description }}
            </td>
            <td class="border-t px-6 py-4 w-8">
              <Icons name="cheveron-right" class="block w-6 h-6 fill-gray-400 rtl:rotate" />
            </td>
          </tr>
          <tr v-if="contacts.data.length === 0">
            <td class="border-t px-6 py-4" colspan="5">{{ $t('no_x_found', { x: $tc('Contact') }) }}</td>
          </tr>
        </tbody>
      </table>
    </div>
    <pagination :links="contacts.links" :meta="contacts.meta" />
  </div>
</template>

<script>
import pickBy from 'lodash/pickBy';
import Layout from '@/Shared/Layout.vue';
import throttle from 'lodash/throttle';
import mapValues from 'lodash/mapValues';
import Pagination from '@/Shared/Pagination.vue';
import SearchFilter from '@/Shared/SearchFilter.vue';

export default {
  layout: Layout,
  components: { Pagination, SearchFilter },
  props: { contacts: Object, filters: Object },
  metaInfo() {
    return { title: this.$tc('Contact', 2) };
  },
  data() {
    return {
      form: {
        search: this.filters.search,
        trashed: this.filters.trashed,
      },
    };
  },
  watch: {
    form: {
      handler: throttle(function () {
        let query = pickBy(this.form);
        this.$inertia.replace(this.route('contacts', Object.keys(query).length ? query : { remember: 'forget' }));
      }, 250),
      deep: true,
    },
  },
  methods: {
    rowClicked(n) {
      this.$inertia.visit(this.route('contacts.edit', n));
    },
    reset() {
      this.form = mapValues(this.form, () => null);
    },
  },
};
</script>
