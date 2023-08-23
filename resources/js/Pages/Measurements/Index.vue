<template>
  <div>
    <h1 class="mb-6 mt-2 font-bold text-lg md:text-2xl">{{ $tc('Measurement', 2) }}</h1>
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
      <Link class="btn-gray" :href="route('measurements.create')">
        <span class="inline md:hidden"><Icons name="add" class="w-4 h-4 text-white fill-white group-hover:text-white fill-white" /></span>
        <span class="hidden md:inline">{{ $t('create_x', { x: $tc('Measurement') }) }}</span>
      </Link>
    </div>
    <div class="bg-white rounded shadow overflow-x-auto scroll-on-light">
      <table class="w-full whitespace-no-wrap leading-normal">
        <thead>
          <tr class="text-left font-bold">
            <th class="px-6 pt-6 pb-4">{{ $t('Name') }}</th>
            <th class="px-6 pt-6 pb-4">{{ $tc('Service') }}</th>
            <th class="px-6 pt-6 pb-4">{{ $tc('Customer') }}</th>
            <th class="px-6 pt-6 pb-4">{{ $tc('Field', 2) }}</th>
            <th class="px-6 pt-6 pb-4" colspan="2">{{ $t('Description') }}</th>
          </tr>
        </thead>
        <tbody>
          <tr
            :key="measurement.id"
            @click="rowClicked(measurement.id)"
            v-for="measurement in measurements.data"
            class="cursor-pointer hover:bg-teal-200 focus-within:bg-teal-200"
          >
            <td class="border-t px-6 py-4 w-56">
              <div class="flex items-center">
                {{ measurement.name }}
                <Icons v-if="measurement.deleted_at" name="trash" class="flex-shrink-0 w-3 h-3 fill-gray-400 ltr:ml-2 rtl:mr-2" />
              </div>
            </td>
            <td class="border-t px-6 py-4 w-40">
              <div v-if="measurement.service">
                {{ measurement.service.name }}
              </div>
            </td>
            <td class="border-t px-6 py-4 w-48">
              <div v-if="measurement.customer">
                {{ measurement.customer.name }}
              </div>
            </td>
            <td class="border-t px-6 py-4 w-56 max-w-sm" style="min-width: 250px">
              <span class="whitespace-normal" v-html="displayExtra(measurement.extra_attributes)"></span>
            </td>
            <td class="border-t px-6 py-4 max-w-lg truncate">
              {{ measurement.measurement }}
            </td>
            <td class="border-t px-6 py-4 w-8">
              <Icons name="cheveron-right" class="block w-6 h-6 fill-gray-400 rtl:rotate" />
            </td>
          </tr>
          <tr v-if="measurements.data.length === 0">
            <td class="border-t px-6 py-4" colspan="5">{{ $t('no_x_found', { x: $tc('Measurement') }) }}</td>
          </tr>
        </tbody>
      </table>
    </div>
    <pagination :links="measurements.links" :meta="measurements.meta" />
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
  props: { measurements: Object, filters: Object },
  metaInfo() {
    return { title: this.$tc('Measurement', 2) };
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
        this.$inertia.replace(this.route('measurements', Object.keys(query).length ? query : { remember: 'forget' }));
      }, 250),
      deep: true,
    },
  },
  methods: {
    rowClicked(n) {
      this.$inertia.visit(this.route('measurements.edit', n));
    },
    reset() {
      this.form = mapValues(this.form, () => null);
    },
    displayExtra(attr) {
      let extra = '';
      if (Array.isArray(attr)) {
        attr.map((a, i) => {
          for (let [key, value] of Object.entries(a)) {
            if (value && value.includes('{') && value.includes('}') && value.includes(':')) {
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
      // for (let [key, value] of Object.entries(attr)) {
      //   if (value.includes('{') && value.includes('}') && value.includes(':')) {
      //     extra += `<span class="inline-block"><strong>${key}</strong>: `;
      //     const cbv = JSON.parse(value);
      //     for (let [k, v] of Object.entries(cbv)) {
      //       if (v) {
      //         extra += `<span class="inline-block text-green-600 ltr:mr-2 rtl:ml-2">&#10003; ${k},</span> `;
      //       } else {
      //         extra += `<span class="inline-block text-red-500 ltr:mr-2 rtl:ml-2">&#10005; ${k},</span> `;
      //       }
      //     }
      //     extra += `</span>`;
      //   } else {
      //     extra += `<span class="inline-block"><strong>${key}</strong>: ${value},</span> `;
      //   }
      // }
      return extra;
    },
  },
};
</script>
