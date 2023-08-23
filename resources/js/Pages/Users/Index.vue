<template>
  <div>
    <h1 class="mb-6 mt-2 font-bold text-lg md:text-2xl">{{ $tc('User', 2) }}</h1>
    <div class="np mb-6 flex justify-between items-center">
      <search-filter v-model="form.search" class="w-full max-w-md ltr:mr-4 rtl:ml-4" @reset="reset">
        <label class="block text-gray-700">{{ $t('Role') }}</label>
        <v-select
          v-model="form.role"
          :options="[
            { value: '', label: 'All' },
            { value: 'user', label: $t('Tailor') },
            { value: 'owner', label: $t('Owner') },
          ]"
          :reduce="selected => selected.value"
        ></v-select>

        <label class="mt-4 block text-gray-700">{{ $t('Trashed') }}</label>
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
      <Link class="btn-gray" :href="route('users.create')">
        <span class="inline md:hidden"><Icons name="add" class="w-4 h-4 text-white fill-white group-hover:text-white fill-white" /></span>
        <span class="hidden md:inline">{{ $t('create_x', { x: $tc('User') }) }}</span>
      </Link>
    </div>
    <div class="bg-white rounded shadow overflow-x-auto scroll-on-light">
      <table class="w-full whitespace-no-wrap">
        <thead>
          <tr class="text-left font-bold">
            <th class="px-6 pt-6 pb-4">{{ $t('Name') }}</th>
            <th class="px-6 pt-6 pb-4">{{ $t('Username') }}</th>
            <th class="px-6 pt-6 pb-4">{{ $t('Email') }}</th>
            <th class="pl-6 pr-4 pt-6 pb-4">{{ $t('Active') }}</th>
            <th class="pl-6 pr-4 pt-6 pb-4">{{ $t('Owner') }}</th>
            <th class="px-4 pt-6 pb-4">{{ $t('SMS') }}</th>
            <th class="px-4 pt-6 pb-4">{{ $t('View') }}</th>
            <th class="pl-4 pr-6 pt-6 pb-4">{{ $t('Edit') }}</th>
            <th class="px-6 pt-6 pb-4" colspan="2">{{ $tc('Salary') }}</th>
          </tr>
        </thead>
        <tbody>
          <tr
            :key="user.id"
            v-for="user in users.data"
            @click="rowClicked(user.id)"
            class="cursor-pointer hover:bg-teal-200 focus-within:bg-teal-200"
          >
            <td class="border-t px-6 py-4">
              <div class="flex items-center">
                <img v-if="user.photo" class="block w-5 h-5 rounded-full ltr:mr-2 rtl:ml-2 -my-2" :src="'/' + user.photo" />
                {{ user.name }}
                <Icons v-if="user.deleted_at" name="trash" class="flex-shrink-0 w-3 h-3 fill-gray-400 ml-2" />
              </div>
            </td>
            <td class="border-t px-6 py-4">
              {{ user.username }}
            </td>
            <td class="border-t px-6 py-4">
              {{ user.email }}
            </td>
            <td class="border-t pl-6 pr-4 py-4 w-10 text-center">
              <Icons v-if="user.active" name="check" class="flex-shrink-0 w-4 h-4 fill-green-600 mx-auto" />
              <Icons v-else name="cross" class="flex-shrink-0 w-3 h-3 fill-red-600 mx-auto" />
            </td>
            <td class="border-t pl-6 pr-4 py-4 w-10 text-center">
              <Icons v-if="user.owner" name="check" class="flex-shrink-0 w-4 h-4 fill-green-600 mx-auto" />
              <Icons v-else name="cross" class="flex-shrink-0 w-3 h-3 fill-red-600 mx-auto" />
            </td>
            <td class="border-t px-4 py-4 w-10 text-center">
              <Icons v-if="user.can_sms" name="check" class="flex-shrink-0 w-4 h-4 fill-green-600 mx-auto" />
              <Icons v-else name="cross" class="flex-shrink-0 w-3 h-3 fill-red-600 mx-auto" />
            </td>
            <td class="border-t px-4 py-4 w-10 text-center">
              <Icons v-if="user.view_all" name="check" class="flex-shrink-0 w-4 h-4 fill-green-600 mx-auto" />
              <Icons v-else name="cross" class="flex-shrink-0 w-3 h-3 fill-red-600 mx-auto" />
            </td>
            <td class="border-t pl-4 pr-6 py-4 w-10 text-center">
              <Icons v-if="user.edit_all" name="check" class="flex-shrink-0 w-4 h-4 fill-green-600 mx-auto" />
              <Icons v-else name="cross" class="flex-shrink-0 w-3 h-3 fill-red-600 mx-auto" />
            </td>
            <td class="border-t px-6 py-4 text-right font-bold">
              {{ $number(user.salary) }}
            </td>
            <td class="border-t w-8">
              <Link class="px-4 flex items-center" :href="route('users.edit', user.id)" tabindex="-1">
                <Icons name="cheveron-right" class="block w-6 h-6 fill-gray-400 rtl:rotate" />
              </Link>
            </td>
          </tr>
          <tr v-if="users.length === 0">
            <td class="border-t px-6 py-4" colspan="9">{{ $t('no_x_found', { x: $tc('User') }) }}</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script>
import pickBy from 'lodash/pickBy';
import Layout from '@/Shared/Layout.vue';
import throttle from 'lodash/throttle';
import mapValues from 'lodash/mapValues';
import SearchFilter from '@/Shared/SearchFilter.vue';

export default {
  layout: Layout,
  components: { SearchFilter },
  props: { users: Array, filters: Object },
  metaInfo() {
    return { title: this.$tc('User', 2) };
  },
  data() {
    return {
      form: {
        search: this.filters.search,
        role: this.filters.role,
        trashed: this.filters.trashed,
      },
    };
  },
  watch: {
    form: {
      handler: throttle(function () {
        let query = pickBy(this.form);
        this.$inertia.replace(this.route('users', Object.keys(query).length ? query : { remember: 'forget' }));
      }, 250),
      deep: true,
    },
  },
  methods: {
    rowClicked(n) {
      this.$inertia.visit(this.route('users.edit', n));
    },
    reset() {
      this.form = mapValues(this.form, () => null);
    },
  },
};
</script>
