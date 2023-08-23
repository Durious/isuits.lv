<template>
  <template v-if="href">
    <Link
      :href="href"
      :class="`inline-flex items-center px-4 py-${arr_size[size]} bg-${color}-${active ? 900: 500} shadow border border-transparent rounded-md font-semibold text-sm text-white fill-white tracking-widest hover:bg-${color}-700 active:bg-${color}-900 focus:ring focus:ring-${color}-300 transition ease-in-out duration-150`"
    >
      <slot></slot>
    </Link>
  </template>
  <template v-else>
    <button
      :type="type"
      :class="`inline-flex items-center px-4 py-${arr_size[size]} bg-${color}-${active ? 900: 500} border border-transparent rounded-md font-semibold text-sm text-white fill-white tracking-widest hover:bg-${color}-700 active:bg-${color}-900 focus:ring focus:ring-${color}-300 transition ease-in-out duration-150`"
    >
      <slot></slot>
    </button>
  </template>
</template>

<script>
export default {
  props: {
    type: {
      type: String,
      default: 'submit',
    },
    size: {
      type: String,
      default: 'md'
    },
    color: {
      type: String,
      default: 'gray'
    },
    active: {
      type: Boolean,
      default: false
    },
    href: {
      type: String,
      default: '',
    },
  },
  data() {
    return {
      arr_size: {
        'lg': 4,
        'md': 3,
        'sm': 2,
        'xs': 1
      }
    }
  }
};
</script>
