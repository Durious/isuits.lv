<template>
  <div>
    <h1 class="mb-6 mt-2 font-bold text-lg md:text-2xl">{{ $tc('custom_field', 2) }}</h1>
    <div class="np mb-6 flex justify-end items-center">
      <Link class="btn-gray" :href="route('customfields.create')">
      <span class="inline md:hidden">
        <Icons name="add" class="w-4 h-4 text-white group-hover:text-white fill-white" />
      </span>
      <span class="hidden md:inline">{{ $t('create_x', { x: $tc('custom_field') }) }}</span>
      </Link>
    </div>
    <div class="bg-white rounded shadow overflow-x-auto scroll-on-light">
      <table class="w-full whitespace-no-wrap">
        <thead>
          <tr class="text-left font-bold">
            <th class="px-6 pt-6 pb-4">{{ $t('Name') }}</th>
            <th class="px-6 pt-6 pb-4">{{ $t('Type') }}</th>
            <th class="px-6 pt-6 pb-4">{{ $t('Tag') }}</th>
            <th class="px-6 pt-6 pb-4">{{ $t('Order') }}</th>
            <th class="px-6 pt-6 pb-4">{{ $t('Description') }}</th>
          </tr>
        </thead>
        <tbody>
          <tr :key="item.id" v-for="(item, index) in custom_fields" @click="rowClicked(item.id)"
            class="cursor-pointer hover:bg-teal-200 focus-within:bg-teal-200">
            <td class="border-t px-6 py-4">
              <div class="flex items-center">
                {{ item.name }}
                <Icons v-if="item.deleted_at" name="trash" class="flex-shrink-0 w-3 h-3 fill-gray-400 ml-2" />
              </div>
            </td>
            <td class="border-t px-6 py-4 max-w-lg truncate">
              {{ item.type }}
            </td>
            <td class="border-t px-6 py-4 max-w-lg truncate">
              {{ item.tag }}
            </td>
            <td class="border-t px-6 py-4 max-w-lg truncate text-center">
              <span class="px-2" v-if="index !== 0" @click.stop="levelChange(item.id, custom_fields[index - 1].id)">&uarr;</span>
              <span class="px-2" v-if="index !== custom_fields.length - 1" @click.stop="levelChange(item.id, custom_fields[index + 1].id)">&darr;</span>
            </td>
            <td class="border-t px-6 py-4 max-w-lg truncate">
              {{ item.description }}
            </td>
            <td class="border-t px-6 py-4 w-8">
              <Icons name="cheveron-right" class="block w-6 h-6 fill-gray-400 rtl:rotate" />
            </td>
          </tr>
          <tr v-if="custom_fields.length === 0">
            <td class="border-t px-6 py-4" colspan="5">{{ $t('no_x_found', { x: $tc('custom_field') }) }}</td>
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
  props: { custom_fields: Object },
  metaInfo() {
    return { title: this.$tc('custom_field', 2) };
  },
  methods: {
    rowClicked(n) {
      this.$inertia.visit(this.route('customfields.edit', n));
    },
    levelChange(n1, n2) {
      this.$inertia.post(this.route('customfields.level'), {id1: n1, id2: n2}, {
        onError: (response) => {
          this.errors = response
        }
      });
    }
  }
};
</script>