<template>
  <div id="nav" class="relative px-4">
    <template v-for="(group_name, i) in Object.keys(menus)" :key="'menu_group_' + i">
      <div class="text-white my-2 capitalize text-sm" v-if="checkOwnerAvailable(group_name)">{{$t(group_name)}}</div>
      <template v-for="(menu_item, j) in menus[group_name]" :key="'menu_item_' + i + '_' + j">
        <div :class="{
          'px-4 rounded-md': true,
          'hover:text-white text-gray-300': !isActive(menu_item.link),
          'text-white bg-gray-900': isActive(menu_item.link)
        }"
        v-if="!menu_item.owner || $user.owner"
        >
          <Link class="flex items-center group py-3" :onclick="menu_item.link === 'chats' ? 'window.open(\'https://dashboard.tawk.to\')' : ''" :href="menu_item.link === 'chats' ? '' : route(menu_item.link)">
            <Icons :name="menu_item.icon" class="w-4 h-4 ltr:mr-4 rtl:ml-4"
              :class="isActive(menu_item.link)
                ? 'z-10 fill-gray-100'
                : 'fill-gray-300 group-hover:text-white fill-white'
              "
            />
            <div class="z-10">{{ $tc(menu_item.title, 2) }}</div>
          </Link>
        </div>
      </template>
    </template>
  </div>
</template>

<script>
export default {
  props: { url: String },
  data() {
    return {
      menus: {
        Dashboard: [
          { title: 'Dashboard', link: 'dashboard', icon: 'dashboard' },
        ],
        Product: [
          { title: 'Product', link: 'products', icon: 'truck' },
          { title: 'Category', link: 'categories', icon: 'list' },
          { title: 'Product Order', link: 'product_orders', icon: 'cart' },
          { title: 'custom_field', link: 'customfields', icon: 'cog', owner: true },
        ],
        Service: [
          { title: 'Service', link: 'services', icon: 'service' },
          { title: 'Service Order', link: 'orders', icon: 'store-front' },
          { title: 'Measurement', link: 'measurements', icon: 'measurement' },
          { title: 'Measurement Field', link: 'measurement_fields', icon: 'measurement_field', owner: true },
        ],
        Other: [
          { title: 'Customer', link: 'customers', icon: 'customer' },
          { title: 'Chat', link: 'chats', icon: 'sms' },
          { title: 'Payment', link: 'payments', icon: 'payment' },
          { title: 'Expense', link: 'expenses', icon: 'expense' },
          { title: 'Contact', link: 'contacts', icon: 'contacts' },
          { title: 'Report', link: 'reports', icon: 'report' },
        ],
        Owner: [
          { title: 'User', link: 'users', icon: 'users', owner: true },
          { title: 'Salary', link: 'salaries', icon: 'salary', owner: true },
          { title: 'Tax', link: 'taxes', icon: 'tax', owner: true },
          { title: 'Setting', link: 'settings', icon: 'settings', owner: true },
          { title: 'Activity Log', link: 'logs', icon: 'logs', owner: true },
        ]
      },
    };
  },
  methods: {
    isActive(link) {
        if(link === 'dashboard')
          return this.url === 'admin'
      return this.url.startsWith('admin/' + link);
    },
    checkOwnerAvailable(group_name) {
      if(this.$user.owner){
        return true;
      } else {
        return this.menus[group_name].filter(item => (!item.owner)).length > 0
      }
    }
  },
};
</script>
