<template>
  <div v-if='show' class='w-full ltr:text-left rtl:text-right'>
    <div v-if='modal' class='np flex justify-between items-center px-6 py-4 mb-4 bg-gray-100 border-b rounded-t'>
      <p class='font-bold'>{{ $t('Product Review') }}</p>
      <div class='flex items-center'>
        <a class='modal-close ml-2 cursor-pointer' @click="$emit('close')">
          <svg class='fill-current text-black' xmlns='http://www.w3.org/2000/svg' width='18' height='18'
               viewBox='0 0 18 18'>
            <path
              d='M14.53 4.53l-1.06-1.06L9 7.94 4.53 3.47 3.47 4.53 7.94 9l-4.47 4.47 1.06 1.06L9 10.06l4.47 4.47 1.06-1.06L10.06 9z'>
            </path>
          </svg>
        </a>
      </div>
    </div>
    <div class='w-full px-10'>
      <div class='p-2 flex items-center'>
        <span class='font-medium text-gray-700 mr-4'>{{ $t('Rate') }}</span>
        <star-rating :star-size='25' v-model:rating='form.rate' :show-rating='false'></star-rating>
      </div>
      <div class='p-2'>
        <label class='form-label font-medium text-gray-700' for='customer_id'>
          {{ $tc('Customer') }}
        </label>
        <v-select transition='' v-model='customer' :clearable='false' :options='customers' input-id='customer_id'
                  @option:selected='customerChanged' :dir='$page.props.user.account.direction'
                  :placeholder="$t('search_x', { x: $tc('Customer') })" :class='{ error: false }'></v-select>
      </div>
      <div class='p-2'>
        <text-input :label="$t('title')" v-model='form.title' :errors='errors?.title' />
      </div>
      <div class='p-2'>
        <textarea-input :label="$t('Content')" v-model='form.content' :error='errors?.content' />
      </div>
    </div>
    <div class='np block xs:flex px-6 py-4 mt-4 bg-gray-100 border-t rounded-b justify-end'>
      <Button size='sm' color='red' @click='deleteReview()' v-if='this.review'>
        {{ $t('Delete') }}
      </Button>
      <loading-button :loading='sending' class='btn-gray ml-5' @click='submit()'>
        {{ $t('save') }}
      </loading-button>
      <button @click="$emit('close')" class='btn-gray ml-5 uppercase'>
        {{ $t('Close') }}
      </button>
    </div>
  </div>
</template>

<script>
import _ from 'lodash';
import StarRating from 'vue-star-rating';
import Button from '@/Jetstream/Button.vue';
import TextInput from '@/Shared/TextInput.vue';
import TextareaInput from '@/Shared/TextareaInput.vue';
import LoadingButton from '@/Shared/LoadingButton.vue';

const default_value = {
  rate: 0,
  title: '',
  content: '',
  customer_id: null,
};

export default {
  props: {
    show: Boolean,
    review: Object,
    customers: Object,
    product_id: Number,
    modal: {
      type: Boolean,
      default: true,
    },
  },
  components: { TextInput, TextareaInput, LoadingButton, StarRating, Button },
  data() {
    return {
      errors: {},
      sending: false,
      form: default_value,
      customer: null,
    };
  },
  watch: {
    show: function() {
      const review = _.cloneDeep(this.review);
      this.form = review ? {
        rate: review.rate,
        title: review.title,
        content: review.content,
        customer_id: review.customer_id,
      } : _.cloneDeep(default_value);
      if (review) {
        this.customer = this.customers.find(item => item.id === parseInt(review.customer_id));
      } else {
        this.customer = null;
      }
    },
    customer: function(v) {
      this.form.customer_id = v?.value ?? null;
    },
  },
  methods: {
    submit() {
      this.sending = true;
      this.$inertia.post(
        this.route('products.save_review', this.review?.id ?? 0),
        {
          ...this.form,
          product_id: this.product_id,
        },
        {
          onSuccess: () => {
            this.$emit('close');
          },
          onFinish: () => {
            this.sending = false;
          },
          onError: (response) => {
            this.errors = response;
          },
        },
      );
    },
    deleteReview() {
      this.$inertia.delete(
        this.route('products.delete_review', this.review?.id ?? 0),
        {
          onSuccess: () => {
            this.$emit('close');
          },
        },
      );
    },
  },
};
</script>
