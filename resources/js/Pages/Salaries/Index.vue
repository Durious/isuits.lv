<template>
  <div>
    <h1 class="mb-6 mt-2 font-bold text-lg md:text-2xl">{{ $t('Salaries') }}</h1>
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
      <div>
        <button :disabled="sending" class="inline-flex items-center btn-gray ltr:mr-2 rtl:ml-2" @click="generateSalaries()">
          <div v-if="sending" class="btn-spinner ltr:mr-2 rtl:ml-2" />
          {{ $t('Generate') }}
        </button>
        <Link class="btn-gray" :href="route('salaries.create')">
          <span class="inline md:hidden"><Icons name="add" class="w-4 h-4 text-white fill-white group-hover:text-white fill-white" /></span>
          <span class="hidden md:inline">{{ $t('Create Salary') }}</span>
        </Link>
      </div>
    </div>
    <div class="bg-white rounded shadow overflow-x-auto scroll-on-light">
      <table class="w-full whitespace-no-wrap">
        <thead>
          <tr class="text-left font-bold">
            <th class="px-6 pt-6 pb-4">{{ $t('Date') }}</th>
            <th class="px-6 pt-6 pb-4">{{ $t('Staff') }}</th>
            <th class="px-6 pt-6 pb-4">{{ $t('Amount') }}</th>
            <th class="px-6 pt-6 pb-4">{{ $t('Advance') }}</th>
            <th class="px-6 pt-6 pb-4" colspan="2">{{ $t('Description') }}</th>
          </tr>
        </thead>
        <tbody>
          <tr
            :key="salary.id"
            @click="rowClicked(salary.id)"
            v-for="salary in salaries.data"
            class="cursor-pointer hover:bg-teal-200 focus-within:bg-teal-200"
          >
            <td class="border-t px-6 py-4">
              <div class="flex items-center">
                {{ $date(salary.date) }}
                <Icons v-if="salary.deleted_at" name="trash" class="flex-shrink-0 w-3 h-3 fill-gray-400 ml-2" />
              </div>
            </td>
            <td class="border-t px-6 py-4 leading-normal">
              <div v-if="salary.staff">
                <div>{{ salary.staff.name }}</div>
                <div>{{ salary.staff.phone }}</div>
              </div>
            </td>
            <td class="border-t px-6 py-4 text-right font-bold">
              <div>{{ $number(salary.amount) }}</div>
              <div v-if="salary.settled_on">{{ $date(salary.settled_on) }}</div>
            </td>
            <td class="border-t px-6 py-4 text-center w-16">
              <Icons v-if="salary.advance" name="check" class="flex-shrink-0 w-4 h-4 fill-green-500 mx-auto" />
              <Icons v-else name="cross" class="flex-shrink-0 w-3 h-3 fill-red-500 mx-auto" />
            </td>
            <td class="border-t px-6 py-4 max-w-lg truncate">
              {{ salary.description }}
            </td>
            <td class="border-t px-6 py-4 w-8">
              <Icons name="cheveron-right" class="block w-6 h-6 fill-gray-400 rtl:rotate" />
            </td>
          </tr>
          <tr v-if="salaries.data.length === 0">
            <td class="border-t px-6 py-4" colspan="6">{{ $t('No salaries found.') }}</td>
          </tr>
        </tbody>
      </table>
    </div>
    <pagination :links="salaries.links" :meta="salaries.meta" />
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
import LoadingButton from '@/Shared/LoadingButton.vue';

export default {
  metaInfo: { title: 'Salaries' },
  layout: Layout,
  components: {
    Icon,
    Pagination,
    SearchFilter,
    LoadingButton,
  },
  props: {
    salaries: Object,
    filters: Object,
  },
  data() {
    return {
      form: {
        search: this.filters.search,
        trashed: this.filters.trashed,
      },
      sending: false,
    };
  },
  watch: {
    form: {
      handler: throttle(function () {
        let query = pickBy(this.form);
        this.$inertia.replace(this.route('salaries', Object.keys(query).length ? query : { remember: 'forget' }));
      }, 250),
      deep: true,
    },
  },
  methods: {
    rowClicked(n) {
      this.$inertia.visit(this.route('salaries.edit', n));
    },
    reset() {
      this.form = mapValues(this.form, () => null);
    },
    generateSalaries() {
      this.sending = true;
      this.$inertia.post(this.route('salaries.generate'), {
        onFinish: () => (this.sending = false),
      });
    },
  },
};
</script>
