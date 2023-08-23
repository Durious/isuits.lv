<template>
  <div>
    <h1 class="mb-6 mt-2 font-bold text-lg md:text-2xl">{{ $tc('Category', 2) }}</h1>
    <div class="np mb-6 flex justify-end items-center">
      <Link class="btn-gray" :href="route('categories.create')">
        <span class="inline md:hidden"><Icons name="add" class="w-4 h-4 text-white group-hover:text-white fill-white" /></span>
        <span class="hidden md:inline">{{ $t('create_x', { x: $tc('Category') }) }}</span>
      </Link>
    </div>
    <div class="bg-white rounded shadow overflow-x-auto scroll-on-light">
      <table class="w-full whitespace-no-wrap">
        <thead>
          <tr class="text-left font-bold">
            <th class="px-6 pt-6 pb-4">{{ $t('Name') }}</th>
            <th class="px-6 pt-6 pb-4">{{ $t('Description') }}</th>
            <th class="px-6 pt-6 pb-4">{{ $t('Photo') }}</th>
          </tr>
        </thead>
        <tbody>
          <tr
            :key="category.id"
            v-for="category in categories"
            @click="rowClicked(category.id)"
            class="cursor-pointer hover:bg-teal-200 focus-within:bg-teal-200"
          >
            <td class="border-t px-6 py-4">
              <div class="flex items-center">
                {{ category.name }}
                <Icons v-if="category.deleted_at" name="trash" class="flex-shrink-0 w-3 h-3 fill-gray-400 ml-2" />
              </div>
            </td>
            <td class="border-t px-6 py-4 max-w-lg truncate">
              {{ category.description }}
            </td>
            <td class="border-t px-6 py-4 max-w-lg truncate">
              <img :src="'/storage/category/' + category.photo" alt="category-photo" class="h-12 object-cover" />
            </td>
            <td class="border-t px-6 py-4 w-8">
              <Icons name="cheveron-right" class="block w-6 h-6 fill-gray-400 rtl:rotate" />
            </td>
          </tr>
          <tr v-if="categories.length === 0">
            <td class="border-t px-6 py-4" colspan="5">{{ $t('no_x_found', { x: $tc('Category') }) }}</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>
  
<script>
import Layout from '@/Shared/Layout.vue';

export default {
  layout: Layout,
  props: { categories: Object },
  metaInfo() {
    return { title: this.$tc('Category', 2) };
  },
  methods: {
    rowClicked(n) {
      this.$inertia.visit(this.route('categories.edit', n));
    },
  }
};
</script>
  