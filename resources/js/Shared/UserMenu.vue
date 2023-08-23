<template>
  <div id="user-name">
    <template v-for="(m, i) in menus" :key="'mm_' + i">
      <Link
        :href="m.link"
        :method="m.method"
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
        {
          method: 'get',
          title: this.$t('My Profile'),
          // link: '/profile/' + this.$page.props.user.id,
          link: route('profile.edit', this.$page.props.user.id),
        },
        {
          method: 'get',
          title: this.$t('Change Password'),
          // link: '/profile/' + this.$page.props.user.id + '/password',
          link: route('profile.password', this.$page.props.user.id),
        },
        // { title: this.$t('Logout'), link: '/logout', method: 'post' },
        { title: this.$t('Logout'), link: route('logout'), url: 'logout', method: 'post' },
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
