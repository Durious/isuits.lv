<template>
  <div class="w-full min-h-screen flex items-center p-6 bg-gradient-gray">
    <div class="w-full max-w-sm mx-auto bg-white text-gray-700 rounded shadow-lg leading-normal">
      <div class="p-4">
        <h4 class="font-bold text-sm">{{ $t('Database Status') }}</h4>
        <h4 class="font-extrabold mt-2">
          {{ info }}
        </h4>
      </div>
      <button
        type="button"
        @click="goHome"
        class="px-4 py-2 w-full text-sm rounded-b border-t border-gray-200 bg-gray-200 hover:bg-gray-300"
      >
        {{ $t('Go back to Home') }}
      </button>
    </div>
  </div>
</template>

<script>
export default {
  props: ['info'],
  methods: {
    goHome() {
      this.$inertia.visit(this.route('dashboard'));
    },
  },
};
</script>
