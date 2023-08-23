<template>
  <layout :title="form.id ? $t('update_x', { x: form.name }) : $t('create_x', { x: $t('service') })">
    <div>
      <h1 class='mb-6 mt-2 font-bold text-lg md:text-2xl'>
        <Link class='text-gray-600 hover:text-gray-800 inline-flex items-center' :href="route('services')">
          <Icons name='back' class='flex-shrink-0 w-3 h-3 md:w-5 md:h-5 fill-current ltr:mr-2 rtl:ml-2 rtl:rotate' />
          {{ $tc('Service', 2) }}
        </Link>
        <span class='text-gray-400 font-medium mx-1'>/</span>
        <span>{{ form.id ? form.name : $t('create_x', { x: $t('service') }) }}</span>
      </h1>
      <trashed-message v-if='service?.deleted_at' class='mb-6' @restore='() => (restore = true)'>
        <span>{{ $t('already_deleted_x', { x: $tc('Service') }) }}</span>
      </trashed-message>
      <div class='w-full flex flex-wrap'>
        <div class='bg-white rounded shadow w-full overflow-hidden md:w-2/5'>
          <form @submit.prevent='submit' autocomplete='off'>
            <div class='p-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap'>
              <text-input v-model='form.code' :error='errors?.code' class='ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2'
                          :label="$t('Code')" />
              <text-input v-model='form.name' :error='errors?.name' class='ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2'
                          :label="$t('Name')" />
            </div>
            <div class='px-8 pb-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap'>
              <text-input v-model='form.price' :error='errors?.price' class='ltr:pr-6 rtl:pl-6 pb-8 w-full'
                          :label="$t('Price')" />
              <file-input type='file' accept='image/*' :label="$t('Photo')" v-model='form.photo' :error='errors?.photo'
                          class='ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-full' />
              <text-input
                :label="$t('Description')"
                v-model='form.description'
                :error='errors?.description'
                class='ltr:pr-6 rtl:pl-6 pb-8 w-full'
              />
              <checkbox-input id='active' :label="$t('Active')" v-model:checked='form.active' class='mb-8' />
            </div>
            <div class='px-8 py-4 bg-gray-100 border-t border-gray-200 flex items-center'>
              <template v-if='service'>
                <DeleteRestoreComponent
                  :restore='restore'
                  :data='service'
                  :permanentEnable='false'
                  model='Service'
                  routeM='services'
                  @close-restore='() => (restore = false)'
                />
              </template>
              <loading-button :loading='sending' class='btn-gray ltr:ml-auto rtl:mr-auto' type='submit'>
                {{ form.id ? $t('update_x', { x: $t('service') }) : $t('create_x', { x: $t('service') }) }}
              </loading-button>
            </div>
          </form>
        </div>
        <div class='w-full md:w-3/5 md:pl-5'>
          <div class='bg-white rounded shadow'>
            <div class='flex items-center justify-between'>
              <h3 class='font-bold text-lg px-6 pt-6 pb-4'>{{ $t('Service Reviews') }}</h3>
            </div>
            <div class='overflow-x-auto scroll-on-light'>
              <table class='w-full whitespace-no-wrap'>
                <tr class='text-left font-bold'>
                  <th class='px-6 pt-6 pb-4'>{{ $t('Customer') }}</th>
                  <th class='px-6 pt-6 pb-4'>{{ $tc('Title') }}</th>
                  <th class='px-6 pt-6 pb-4'>{{ $tc('Rate') }}</th>
                  <th class='px-6 pt-6 pb-4' colspan='2'>{{ $tc('Content') }}</th>
                </tr>
                <tr :key='review.id' @click='showReviewModal(review.id)' v-for='review in reviews'
                    class='cursor-pointer hover:bg-teal-200 focus-within:bg-teal-200'>
                  <td class='border-t px-6 py-4'>
                    <div class='flex items-center'>
                      {{ review.customer.name }}
                      <Icons v-if='review.deleted_at' name='trash' class='flex-shrink-0 w-3 h-3 fill-gray-400 ml-2' />
                    </div>
                  </td>
                  <td class='border-t px-6 py-4'>
                    {{ review.title }}
                  </td>
                  <td class='border-t px-6 py-4'>
                    {{ review.rate }}
                  </td>
                  <td class='border-t px-6 py-4 max-w-md truncate'>
                    {{ review.content }}
                  </td>
                  <td class='border-t px-6 py-4 w-8'>
                    <Icons name='cheveron-right' class='block w-6 h-6 fill-gray-400 rtl:rotate' />
                  </td>
                </tr>
                <tr v-if='reviews.length === 0'>
                  <td class='border-t px-6 py-4' colspan='5'>{{ $t('no_x_found', { x: $tc('Review') }) }}</td>
                </tr>
              </table>
            </div>
          </div>
        </div>
      </div>
      <Modal :show='viewReview' max-width='2xl' :closeable='true' @close='viewReview = false'>
        <ReviewModal
          :review='review'
          :show='viewReview'
          :customers='icustomers'
          :service_id='service.id'
          @close='() => (viewReview = false)' />
      </Modal>
    </div>
  </layout>
</template>

<script>
import Layout from '@/Shared/Layout.vue';
import DeleteMixin from '@/Misc/DeleteMixin';
import TextInput from '@/Shared/TextInput.vue';
import FileInput from '@/Shared/FileInput.vue';
import LoadingButton from '@/Shared/LoadingButton.vue';
import CheckboxInput from '@/Shared/CheckboxInput.vue';
import TrashedMessage from '@/Shared/TrashedMessage.vue';
import DeleteRestoreComponent from '@/Shared/DeleteRestoreComponent.vue';
import ReviewModal from '@/Pages/Services/ReviewModal.vue';
import Modal from '@/Jetstream/Modal.vue';

export default {
  mixins: [DeleteMixin('service')],
  props: { service: Object, customers: Array, icustomers: Object, ireviews: Object },
  components: {
    Layout,
    LoadingButton,
    TextInput,
    TrashedMessage,
    CheckboxInput,
    DeleteRestoreComponent,
    FileInput,
    ReviewModal,
    Modal,
  },
  data() {
    return {
      errors: {},
      restore: false,
      sending: false,
      form: {
        id: this.service?.id,
        code: this.service?.code,
        name: this.service?.name,
        price: this.service?.price,
        photo: this.service?.photo,
        description: this.service?.description,
        active: this.service?.active == 1 ? true : false,
      },
      reviews: [],
      review: null,
      viewReview: false,
    };
  },
  watch: {
    ireviews: function (cv) {
      this.reviews = cv
    }
  },
  mounted() {
    this.reviews = this.ireviews;
  },
  methods: {
    submit() {
      this.sending = true;
      this.$inertia['post'](
        this.form.id ? route('services.update', this.service.id) : route('services.store'),
        this.form,
        {
          onSuccess: () => (this.errors = {}),
          onFinish: () => (this.sending = false),
          onError: errors => (this.errors = errors),
        },
      );
    },
    showReviewModal(review_id) {
      this.review = this.reviews.find(item => item.id === review_id);
      this.viewReview = true;
    },
  },
};
</script>
