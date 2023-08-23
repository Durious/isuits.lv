<template>
  <div>
    <h1 class="mb-6 mt-2 font-bold text-lg md:text-2xl">
      {{ $tc('Measurement Field', 2) }}
    </h1>
    <div class="np mb-6 flex justify-between items-center">
      <search-filter @reset="reset" v-model="form.search" class="w-full max-w-md ltr:mr-4 rtl:ml-4">
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
      <Link class="btn-gray" :href="route('measurement_fields.create')">
        <span class="inline md:hidden"><Icons name="add" class="w-4 h-4 text-white fill-white group-hover:text-white fill-white" /></span>
        <span class="hidden md:inline">{{ $t('create_x', { x: $tc('Measurement Field') }) }}</span>
      </Link>
    </div>
    <div class="bg-white rounded shadow overflow-x-auto scroll-on-light">
      <table class="w-full whitespace-no-wrap">
        <thead>
          <tr class="text-left font-bold">
            <th class="px-6 pt-6 pb-4">{{ $t('Name') }}</th>
            <th class="px-6 pt-6 pb-4 text-center">{{ $t('Type') }}</th>
            <th class="px-6 pt-6 pb-4 text-center">{{ $tc('Order') }}</th>
            <th class="px-6 pt-6 pb-4 text-center">{{ $t('Required') }}</th>
            <th class="px-6 pt-6 pb-4">{{ $t('Options') }}</th>
            <th class="px-6 pt-6 pb-4" colspan="2">{{ $t('Description') }}</th>
          </tr>
        </thead>
        <tbody>
          <tr
            :key="measurement_field.id"
            @click="rowClicked(measurement_field.id)"
            v-for="measurement_field in measurement_fields.data"
            class="cursor-pointer hover:bg-teal-200 focus-within:bg-teal-200"
          >
            <td class="border-t px-6 py-4 w-64">
              <div class="flex items-center">
                {{ measurement_field.name }}
                <Icons v-if="measurement_field.deleted_at" name="trash" class="flex-shrink-0 w-3 h-3 fill-gray-400 ml-2" />
              </div>
            </td>
            <td class="border-t px-6 py-4 text-center w-40">
              {{ measurement_field.type }}
            </td>
            <td class="border-t px-6 py-4 text-center w-16">
              {{ measurement_field.order }}
            </td>
            <td class="border-t px-6 py-4 text-center w-16">
              <Icons v-if="measurement_field.required" name="check" class="flex-shrink-0 w-4 h-4 fill-green-600 mx-auto" />
              <Icons v-else name="cross" class="flex-shrink-0 w-3 h-3 fill-red-600 mx-auto" />
            </td>
            <td class="border-t px-6 py-4 w-64">
              <!-- {{ measurement_field.options }} -->
              <template v-if="measurement_field.options && measurement_field.options.length">
                <span :key="o.value" v-for="(o, i) in measurement_field.options">
                  {{ o.value + (i + 1 == measurement_field.options.length ? '' : ', ') }}
                </span>
              </template>
            </td>
            <td class="border-t px-6 py-4 w-64 max-w-lg truncate">
              {{ measurement_field.description }}
            </td>
            <td class="border-t px-6 py-4 w-8">
              <Icons name="cheveron-right" class="block w-6 h-6 fill-gray-400 rtl:rotate" />
            </td>
          </tr>
          <tr v-if="measurement_fields.data.length === 0">
            <td class="border-t px-6 py-4" colspan="7">
              {{ $t('no_x_found', { x: $tc('Measurement Field') }) }}
            </td>
          </tr>
        </tbody>
      </table>
    </div>
    <pagination :links="measurement_fields.links" :meta="measurement_fields.meta" />
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
  props: { measurement_fields: Object, filters: Object },
  metaInfo() {
    return { title: this.$tc('Measurement Field', 2) };
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
        this.$inertia.replace(this.route('measurement_fields', Object.keys(query).length ? query : { remember: 'forget' }));
      }, 250),
      deep: true,
    },
  },
  methods: {
    rowClicked(n) {
      this.$inertia.visit(this.route('measurement_fields.edit', n));
    },
    reset() {
      this.form = mapValues(this.form, () => null);
    },
  },
};
</script>
