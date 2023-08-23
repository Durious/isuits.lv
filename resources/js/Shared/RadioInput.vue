<template>
  <span class="radio ltr:mr-2 rtl:ml-3 inline-flex items-center">
    <input :id="id" type="radio" :name="name" :value="value" :checked="checked" @change="$emit('input', $event.target.checked ? v : '')" />
    <label :for="id" v-if="label" :class="{ 'text-red-600': errors.length }">
      <span class="ltr:mr-2 rtl:ml-2" :class="{ 'border-red-600': errors.length }"></span> {{ label }}
    </label>
  </span>
</template>

<script>
export default {
  props: {
    label: {
      type: String,
      required: false,
    },
    name: {
      type: String,
      required: false,
    },
    value: {
      required: false,
    },
    id: {
      type: String,
      required: false,
    },
    errors: {
      type: Array,
      default: () => [],
    },
    checked: {
      type: Boolean,
      required: false,
    },
  },
  data() {
    return { v: this.value };
  },
};
</script>
