<template>
  <Link
    :href="href"
    :class="space == 'less' ? 'md:py-2' : 'md:py-3'"
    class="flex items-center border-b border-darker px-4 md:px-2 py-4 lg:px-4 focus:bg-blue-600 hover:bg-blue-700"
  >
    <slot name="icon">
      <div class="h-5 w-5 mr-3">
        <Icons v-if="!hideIcon" name="link" />
      </div>
    </slot>
    <slot></slot>
  </Link>
</template>

<script>
export default {
  props: ['href', 'space', 'hideIcon'],
  data() {
    return { open: false };
  },
};
</script>
