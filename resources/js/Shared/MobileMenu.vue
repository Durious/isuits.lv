<template>
  <nav class="md:hidden bottom-0 w-full h-12 bg-gray-800 text-xs">
    <ul class="flex justify-around items-center text-white fill-white text-center text-lg font-bold">
      <template v-for="(m, i) in menus" :key="'mm_' + i">
        <li class="relative p-3" :class="isUrl(m.link) ? 'w-12 mt-2' : ''">
          <Link
            :href="route(m.link)"
            :class="
              isUrl(m.link)
                ? 'z-50 opacity-100 transition-all duration-200 absolute left-0 bottom-0 bg-gray-900 rounded-full p-4 -ml-2'
                : ''
            "
          >
            <Icons :name="m.icon" class="mx-auto" :class="isUrl(m.link) ? 'h-8 w-8 text-white fill-white ' : 'h-6 w-6 fill-current'" />
          </Link>
        </li>
      </template>
    </ul>
  </nav>
</template>

<script>
import Icon from '@/Shared/Icon.vue';

export default {
  components: { Icon },
  props: {
    url: String,
  },
  data() {
    return {
      selected: 0,
      menus: [
        { title: this.$tc('Customer', 2), link: 'customers', icon: 'customer' },
        { title: this.$tc('Measurement', 2), link: 'measurements', icon: 'measurement' },
        { title: this.$tc('Order', 2), link: 'orders', icon: 'store-front' },
        { title: this.$tc('Expense', 2), link: 'expenses', icon: 'expense' },
        { title: this.$tc('Page', 2), link: 'pages', icon: 'bars' },
        // { title: 'Settings', link: 'settings', icon: 'settings' },
      ],
    };
  },
  methods: {
    select(i) {
      this.selected = i;
    },
    isUrl(...urls) {
      if (urls[0] === '') {
        return this.url === '';
      }

      return urls.filter(url => this.url.startsWith(url)).length;
    },
  },
};
</script>
