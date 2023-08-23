<template>
  <div v-if="order" class="w-full -my-6">
    <div class="w-full bg-white rounded shadow-lg leading-normal p-4">
      <h4 class="font-bold">{{ $t('Send SMS to Customer') }}</h4>
      <h4 class="text-sm mt-2 mb-4" v-html="$t('sending_to_html', { name: order.customer.name, phone: order.customer.phone })"></h4>
      <div v-if="sent" class="text-green-500 mb-4">
        {{ $t('SMS has been successfully sent to customer.') }}
      </div>
      <div v-else>
        <div v-if="error" class="text-red-500 mb-4">
          {{ error }}
        </div>
        <div v-if="errors?.text" class="text-red-500 mb-4">
          {{ errors.text.join(', ') }}
        </div>
      </div>
      <textarea-input v-model="text" :resize="false" :errors="errors?.text" class="pb-10 w-full" label="SMS Text" />
      <div class="-m-4 px-8 py-4 bg-gray-100 border-t border-gray-200 flex items-center rounded-b">
        <button class="text-gray-700 hover:text-gray-800" type="button" @click="$emit('close')">
          {{ $t('Cancel') }}
        </button>
        <loading-button type="button" @click="send" :loading="sending" class="btn-gray px-4 py-2 ml-auto flex items-center">
          <div v-if="sending" class="btn-spinner ltr:mr-2 rtl:ml-2" />
          {{ $t('Send') }}
        </loading-button>
      </div>
    </div>
  </div>
</template>

<script>
import LoadingButton from '@/Shared/LoadingButton.vue';
import TextareaInput from '@/Shared/TextareaInput.vue';
export default {
  components: { TextareaInput, LoadingButton },
  props: { order: Object },
  data() {
    return { data: null, text: null, sending: false, sent: false, errors: {}, error: null };
  },
  methods: {
    send() {
      this.errors = {};
      this.error = null;
      this.sending = true;
      this.sending = true;
      this.$axios
        .post(this.route('customers.sms', this.order.customer.id), { text: this.text })
        .then(res => {
          this.sending = false;
          this.sent = res.data.success;
          if (res.data.success) {
            this.$emit('close');
          } else {
            this.error = res.data.error;
          }
          // this.$modal.show('dialog', {
          //   title: res.data.success ? this.$t('SMS Sent') : this.$t('Error Occurred'),
          //   text: res.data.success
          //     ? this.$t('SMS has been successfully sent to customer.')
          //     : res.data.error || this.$t('System is unable to send sms, please check logs in storage directory.'),
          //   buttons: [
          //     {
          //       title: this.$t('Okay'),
          //       class: 'px-6 py-3 border-l bg-gray-200 hover:bg-gray-400',
          //     },
          //   ],
          // });
        })
        .catch(err => {
          this.sending = false;
          console.log(err.response);

          this.errors = err.response.data.errors;
        });
    },
  },
};
</script>
