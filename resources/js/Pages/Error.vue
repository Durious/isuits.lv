<template>
  <div class="w-full min-h-screen flex items-center p-6 bg-gradient-gray">
    <div class="w-full max-w-sm mx-auto bg-white text-gray-700 rounded shadow-lg leading-normal">
      <div class="p-4">
        <h4 class="font-bold">{{ title }}</h4>
        <h4 class="text-sm mt-2">
          {{ description }}
        </h4>
      </div>
      <button
        type="button"
        @click="goBack"
        class="px-4 py-2 w-full text-sm rounded-b border-t border-gray-200 bg-gray-200 hover:bg-gray-300"
      >
        {{ $t('Go Back') }}
      </button>
    </div>
  </div>
</template>

<script>
export default {
  props: { status: Number },
  computed: {
    title() {
      return {
        403: this.$t('403: Forbidden'),
        419: this.$t('419: Page Expired'),
        500: this.$t('500: Server Error'),
        404: this.$t('404: Page Not Found'),
        503: this.$t('503: Service Unavailable'),
      }[this.status];
    },
    description() {
      return {
        500: this.$t('Whoops, something went wrong on our servers.'),
        419: this.$t('Whoops, please refresh the page then try again.'),
        403: this.$t('Sorry, you are forbidden from accessing this page.'),
        404: this.$t('Sorry, the page you are looking for could not be found.'),
        503: this.$t('Sorry, we are doing some maintenance. Please check back soon.'),
      }[this.status];
    },
  },
  methods: {
    goBack() {
      if (window) {
        history.back();
      } else {
        this.$inertia.visit(this.route('dashboard'));
      }
    },
  },
};
</script>
