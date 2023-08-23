<template>
  <div class="pt-2">
    <h1 class="mb-6 mt-2 font-bold text-lg md:text-2xl">{{ $t('Hello') }} {{ $page.props.user.name }},</h1>
    <div>
      <ul class="list-reset border bg-white rounded-lg menu-list shadow-lg">
        <li>
          <Link :href="route('profile.edit', $page.props.user)" class="block p-4 font-bold hover:bg-gray-300 border-b">
            {{ $t('My Profile') }}
          </Link>
        </li>
        <li>
          <Link :href="route('profile.change.password', $page.props.user)" class="block p-4 font-bold hover:bg-gray-300 border-b">
            {{ $t('Change Password') }}
          </Link>
        </li>
        <li>
          <Link :href="route('logout')" method="post" class="block p-4 font-bold hover:bg-gray-300">
            {{ $t('Logout') }}
          </Link>
        </li>
      </ul>
      <h1 class="my-6 font-bold text-lg">{{ $t('Page Links') }}</h1>
      <ul class="list-reset border bg-white rounded-lg menu-list shadow-lg">
        <li v-for="(m, i) in menus" :key="'pmm_' + i">
          <Link :href="route(m.link)" class="block p-4 font-bold hover:bg-gray-300 border-b">
            {{ m.title }}
          </Link>
        </li>
      </ul>
      <template v-if="$page.props.user.owner">
        <h1 class="my-6 font-bold text-lg">{{ $t('Owner Links') }}</h1>
        <ul class="list-reset border bg-white rounded-lg menu-list shadow-lg">
          <li v-for="(m, i) in owner_menus" :key="'pamm_' + i">
            <Link :href="route(m.link)" class="block p-4 font-bold hover:bg-gray-300 border-b">
              {{ m.title }}
            </Link>
          </li>
        </ul>
      </template>
    </div>
  </div>
</template>

<script>
import Layout from '@/Shared/Layout.vue';

export default {
  layout: Layout,
  metaInfo() {
    return { title: this.$tc('Page', 2) };
  },
  data() {
    return {
      menus: [
        { title: this.$t('Dashboard'), link: 'dashboard', icon: 'dashboard' },
        { title: this.$tc('Service', 2), link: 'services', icon: 'service' },
        { title: this.$tc('Order', 2), link: 'orders', icon: 'store-front' },
        { title: this.$tc('Measurement', 2), link: 'measurements', icon: 'measurement' },
        { title: this.$tc('Customer', 2), link: 'customers', icon: 'customer' },
        { title: this.$tc('Payment', 2), link: 'payments', icon: 'payment' },
        { title: this.$tc('Expense', 2), link: 'expenses', icon: 'expense' },
        { title: this.$tc('Contact', 2), link: 'contacts', icon: 'contacts' },
      ],
      owner_menus: [
        { title: this.$tc('Report', 2), link: 'reports', icon: 'report' },
        { title: this.$tc('User', 2), link: 'users', icon: 'users', owner: true },
        { title: this.$tc('Salary', 2), link: 'salaries', icon: 'salary', owner: true },
        { title: this.$tc('Tax', 2), link: 'taxes', icon: 'tax', owner: true },
        { title: this.$tc('Setting', 2), link: 'settings', icon: 'settings', owner: true },
        {
          title: this.$tc('Measurement Field', 2),
          link: 'measurement_fields',
          icon: 'measurement_field',
          owner: true,
        },
        { title: this.$t('Activity Log'), link: 'logs', icon: 'logs', owner: true },
      ],
    };
  },
  computed: {
    mil() {
      return this.menus.length;
    },
  },
};
</script>
