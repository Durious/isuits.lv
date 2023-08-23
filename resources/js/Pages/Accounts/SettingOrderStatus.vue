<template>
  <div class="bg-white rounded shadow overflow-hidden max-w-3xl">
    <form @submit.prevent="submitOrderStatuses" autocomplete="off">
      <div class="p-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap">
        <div class="w-full">
          <div v-for="(item, index) in form.order_statuses" :key="index" class="py-5" :class="index !== 0 ? 'border-t' : ''">
            <text-input v-model="item.value" class="ltr:pr-6 rtl:pl-6 w-full" :label="$t('Status') + (index + 1)"
              :errors="errors['order_statuses.' + index]" />
          </div>
          <div class="w-full flex items-center justify-end mt-5 mb-6 gap-4 ltr:pr-6 rtl:pl-6">
            <button type="button" @click="addOrderStatusItem"
              class="bg-gray-700 px-3 py-1.5 rounded-md text-gray-50 hover:bg-gray-800">
              <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                stroke="currentColor" class="w-6 h-6">
                <path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15" />
              </svg>
            </button>
            <button type="button" @click="removeOrderStatusItem"
              class="bg-gray-700 px-3 py-1.5 rounded-md text-gray-50 hover:bg-gray-800">
              <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                stroke="currentColor" class="w-6 h-6">
                <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 12h-15" />
              </svg>
            </button>
          </div>
        </div>
      </div>
      <div class="px-8 py-4 bg-gray-100 border-t border-gray-200 flex items-center">
        <loading-button :loading="sending" class="btn-gray ltr:ml-auto rtl:mr-auto" type="submit">
          {{ $t('update_x', { x: $tc('Setting', 2) }) }}
        </loading-button>
      </div>
    </form>
  </div>
</template>
<script>
import TextInput from '@/Shared/TextInput.vue';
import LoadingButton from '@/Shared/LoadingButton.vue';

export default {
  components: { TextInput, LoadingButton },
  props: { order_statuses: String },
  data() {
    return {
      errors: {},
      sending: false,
      form: {
        order_statuses: []
      }
    }
  },
  mounted() {
    this.form.order_statuses = this.order_statuses.split(',').map(value => ({value}))
  },
  methods: {
    addOrderStatusItem() {
      this.form.order_statuses.push({value: ''});
    },
    removeOrderStatusItem() {
      this.form.order_statuses.pop();
    },
    submitOrderStatuses() {
      this.sending = true;
      this.errors = {};
      const data = new FormData();
      this.form.order_statuses.forEach((item, index) => {
        data.append(`order_statuses[${index}]`, item.value || '')
      });
      this.$inertia.post(this.route('settings.order_statuses.save'), data, {
        onError: (response) => {
          this.errors = response
          this.sending = false
        },
        onFinish: () => {
          this.sending = false
        },
      });
    },
  }
}
</script>