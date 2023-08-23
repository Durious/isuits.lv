<template>
  <div>
    <h1 class="mb-6 mt-2 font-bold text-lg md:text-2xl">{{ $tc('Tax', 2) }}</h1>
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
      <Link class="btn-gray" :href="route('taxes.create')">
        <span class="inline md:hidden"><Icons name="add" class="w-4 h-4 text-white fill-white group-hover:text-white fill-white" /></span>
        <span class="hidden md:inline">{{ $t('create_x', { x: $tc('Tax') }) }}</span>
      </Link>
    </div>
    <div class="bg-white rounded shadow overflow-x-auto scroll-on-light">
      <table class="w-full whitespace-no-wrap">
        <thead>
          <tr class="text-left font-bold">
            <th class="px-6 pt-6 pb-4">{{ $t('Code') }}</th>
            <th class="px-6 pt-6 pb-4">{{ $t('Name') }}</th>
            <th class="px-6 pt-6 pb-4">{{ $t('Rate') }}</th>
            <th class="px-6 pt-6 pb-4 text-center">{{ $t('State') }}</th>
            <th class="px-6 pt-6 pb-4 text-center">{{ $t('Same') }}</th>
            <th class="px-6 pt-6 pb-4 text-center">{{ $t('Compound') }}</th>
            <th class="px-6 pt-6 pb-4" colspan="2">{{ $t('Description') }}</th>
          </tr>
        </thead>
        <tbody>
          <tr
            :key="tax.id"
            @click="rowClicked(tax.id)"
            v-for="tax in taxes.data"
            class="cursor-pointer hover:bg-teal-200 focus-within:bg-teal-200"
          >
            <td class="border-t px-6 py-4">
              <div class="flex items-center">
                {{ tax.code }}
                <Icons v-if="tax.deleted_at" name="trash" class="flex-shrink-0 w-3 h-3 fill-gray-400 ml-2" />
              </div>
            </td>
            <td class="border-t px-6 py-4">
              {{ tax.name }}
            </td>
            <td class="border-t px-6 py-4">
              <div class="flex items-center justify-end">
                <Icons v-if="tax.active" name="check" class="flex-shrink-0 w-3 h-3 fill-green-600 ltr:mr-2 rtl:ml-2" />
                <div class="text-right">{{ $number(tax.rate) }}</div>
              </div>
            </td>
            <td class="border-t px-6 py-4">
              <Icons v-if="tax.state" name="check" class="flex-shrink-0 w-4 h-4 fill-green-600 mx-auto" />
              <Icons v-else name="cross" class="flex-shrink-0 w-4 h-4 text-red-600 mx-auto" />
            </td>
            <td class="border-t px-6 py-4">
              <Icons v-if="tax.same" name="check" class="flex-shrink-0 w-4 h-4 fill-green-600 mx-auto" />
              <Icons v-else name="cross" class="flex-shrink-0 w-4 h-4 text-red-600 mx-auto" />
            </td>
            <td class="border-t px-6 py-4">
              <Icons v-if="tax.compound" name="check" class="flex-shrink-0 w-4 h-4 fill-green-600 mx-auto" />
              <Icons v-else name="cross" class="flex-shrink-0 w-4 h-4 text-red-600 mx-auto" />
            </td>
            <td class="border-t px-6 py-4 max-w-lg truncate">
              {{ tax.description }}
            </td>
            <td class="border-t px-6 py-4 w-8">
              <Icons name="cheveron-right" class="block w-6 h-6 fill-gray-400 rtl:rotate" />
            </td>
          </tr>
          <tr v-if="taxes.data.length === 0">
            <td class="border-t px-6 py-4" colspan="8">{{ $t('no_x_found', { x: $tc('Tax') }) }}</td>
          </tr>
        </tbody>
      </table>
    </div>
    <pagination :links="taxes.links" :meta="taxes.meta" />
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
  metaInfo: { title: 'Taxes' },
  components: { Pagination, SearchFilter },
  props: { taxes: Object, filters: Object },
  metaInfo() {
    return { title: this.$tc('Tax', 2) };
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
        this.$inertia.replace(this.route('taxes', Object.keys(query).length ? query : { remember: 'forget' }));
      }, 250),
      deep: true,
    },
  },
  methods: {
    rowClicked(n) {
      this.$inertia.visit(this.route('taxes.edit', n));
    },
    reset() {
      this.form = mapValues(this.form, () => null);
    },
  },
};
</script>
