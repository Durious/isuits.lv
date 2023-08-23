<template>
    <div class="w-full ltr:text-left rtl:text-right">
        <div v-if="modal" class="np flex justify-between items-center px-6 py-4 mb-4 bg-gray-100 border-b rounded-t">
            <p class="font-bold">{{ $t('Billing Address') }}</p>
            <div class="flex items-center">
                <a class="modal-close ml-2 cursor-pointer" @click="$emit('close')">
                    <svg class="fill-current text-black" xmlns="http://www.w3.org/2000/svg" width="18" height="18"
                        viewBox="0 0 18 18">
                        <path
                            d="M14.53 4.53l-1.06-1.06L9 7.94 4.53 3.47 3.47 4.53 7.94 9l-4.47 4.47 1.06 1.06L9 10.06l4.47 4.47 1.06-1.06L10.06 9z">
                        </path>
                    </svg>
                </a>
            </div>
        </div>
        <div class="w-full h-full px-10 leading-normal">
            <div class="flex flex-wrap py-4">
                <div class="w-1/2 p-2" v-for="item in keys">
                    <text-input :label="$t(item)" v-model="form[item]" :errors="errors[item]" />
                </div>
                <div class="w-full p-2">
                    <text-input :label="$t('Other')" v-model="form.other" :errors="errors?.other" />
                </div>
            </div>
        </div>
        <div class="np block xs:flex px-6 py-4 mt-4 bg-gray-100 border-t rounded-b">
            <loading-button :loading="sending" class="btn-gray ml-auto" @click="submit()">
                {{ $t('save') }}
            </loading-button>
            <button @click="$emit('close')" class="btn-gray ml-5 uppercase">
                {{ $t('Close') }}
            </button>
        </div>
    </div>
</template>

<script>
import _ from 'lodash';
import TextInput from '@/Shared/TextInput.vue';
import TextareaInput from '@/Shared/TextareaInput.vue';
import LoadingButton from '@/Shared/LoadingButton.vue';

const default_billing = {
    id: 0,
    fname: '',
    lname: '',
    city: '',
    address: '',
    state: '',
    country: '',
    zipcode: '',
    taxcode: '',
    vatcode: '',
    fiscalcode: '',
    recipientcode: '',
    certified_email: '',
    other: ''
}

export default {
    props: {
        billingAddress: Object,
        modal: {
            type: Boolean,
            default: true
        },
        show: Boolean,
        customer_id: Number
    },
    components: { TextInput, TextareaInput, LoadingButton },
    data() {
        return {
            errors: {},
            sending: false,
            form: default_billing,
            keys: [ 'fname','lname','country','address','city','zipcode','vatcode','state','fiscalcode','recipientcode','taxcode','certified_email' ]
        }
    },
    watch: {
        show: function() {
            this.form = _.cloneDeep(this.billingAddress) ?? default_billing
        }
    },
    methods: {
    submit() {
      this.sending = true
      this.$inertia.put(
        this.route('customer_info.billing.save', this.customer_id),
        this.form,
        {
          onSuccess: () => {
            this.$emit('close');
          },
          onFinish: () => {
            this.sending = false
          },
          onError: (response) => {
            this.errors = response
          }
        }
      );
    }
  }
}
</script>