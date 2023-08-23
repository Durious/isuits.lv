<template>
  <div id="create">
    <template v-for="(m, i) in menus" :key="'mm_' + i">
      <Link
        :href="route(m.link)"
        :class="{ 'bg-gray-900': isUrl(m.url) }"
        class="block px-6 py-3 text-white fill-white hover:bg-gray-900 hover:text-white fill-white"
      >
        <div class="z-10">{{ m.title }}</div>
      </Link>
    </template>
  </div>
</template>

<script>
export default {
  props: { url: String },
  data() {
    return {
      selected: 0,
      menus: [
        { title: this.$t('new_x', { x: this.$tc('Product') }), link: 'products.create', url: 'products/create' },
        { title: this.$t('new_x', { x: this.$tc('Service Order') }), link: 'orders.new', url: 'orders/new' },
        { title: this.$t('new_x', { x: this.$tc('Service') }), link: 'services.create', url: 'services/create' },
        { title: this.$t('new_x', { x: this.$tc('Customer') }), link: 'customers.create', url: 'customers/create' },
        { title: this.$t('new_x', { x: this.$tc('Measurement') }), link: 'measurements.create', url: 'measurements/create' },
        { title: this.$t('new_x', { x: this.$tc('Payment') }), link: 'payments.new', url: 'payments/new' },
        { title: this.$t('new_x', { x: this.$tc('Expense') }), link: 'expenses.create', url: 'expenses/create' },
        { title: this.$t('new_x', { x: this.$tc('Contact') }), link: 'contacts.create', url: 'contacts/create' },
      ],
    };
  },
  methods: {
    isUrl(...urls) {
      if (urls[0] === '') {
        return this.url === '';
      }
      return urls.filter(url => this.url.startsWith(url)).length;
    },
  },
};
</script>
