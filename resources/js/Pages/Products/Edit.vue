<template>
  <div>
    <h1 class="mb-6 mt-2 font-bold text-lg md:text-2xl">
      <Link class="text-gray-600 hover:text-gray-800 inline-flex items-center" :href="route('products')">
      <Icons name="back" class="flex-shrink-0 w-3 h-3 md:w-5 md:h-5 fill-current ltr:mr-2 rtl:ml-2 rtl:rotate" />
      {{ $tc('Product', 2) }}
      </Link>
      <span class="text-gray-400 font-medium mx-2">/</span> {{ $t('Edit') }}
    </h1>
    <trashed-message v-if="product.deleted_at" class="mb-6" @restore="() => (restore = true)">
      <span>{{ $t('already_deleted_x', { x: $tc('Product') }) }}</span>
    </trashed-message>
    <div class="w-full flex flex-wrap">
      <div class="w-full md:w-2/5 md:pr-5">
        <div class="bg-white rounded shadow overflow-hidden">
          <form @submit.prevent="submit" autocomplete="off">
            <div class="p-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap">
              <text-input v-model="form.name" :errors="errors?.name" class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-full"
                :label="$t('Name')" />
            </div>
            <div class="px-8 pb-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap">
              <div class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-full">
                <label class="form-label" for="category_id">{{ $tc('Category') }}</label>
                <v-select v-model="category" :options="categories" input-id="category_id" @search="searchCategories"
                  :dir="$page.props.user.account.direction" :placeholder="$t('search_x', { x: $tc('Category', 2) })"
                  :class="{
                    error: errors?.category_id && errors?.category_id.length,
                  }"></v-select>
                <div v-if="errors?.category_id" class="form-error">
                  {{ errors?.category_id[0] }}
                </div>
              </div>
            </div>
            <div class="px-8 pb-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap">
              <div class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-full">
                <label class="form-label" for="type">{{ $tc('Type') }}</label>
                <v-select v-model="type" :options="types" input-id="type" :dir="$page.props.user.account.direction"
                  :placeholder="$t('select_x', { x: $tc('Type', 1) })" :class="{
                    error: errors?.type && errors?.type.length,
                  }"></v-select>
                <div v-if="errors?.type" class="form-error">
                  {{ errors?.type }}
                </div>
              </div>
            </div>
            <div class="px-8 pb-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap">
              <text-input type="number" :label="$t('Price')" :enableFloat="true" v-model="form.price"
                :errors="errors?.price" class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-full" />
            </div>
            <div class="px-8 pb-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap">
              <file-input type="file" accept="image/*" :label="$t('Main Photo')" v-model="form.main_photo"
                :error="errors?.main_photo" class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-full" />
            </div>
            <div v-for="(item, index) in form.sub_photos" :key="index"
              class="px-8 pb-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap">
              <file-input type="file" accept="image/*" :label="$t('Sub Photo') + ' ' + (index + 1)" v-model="item.file"
                :error="errors['sub_photos.' + index]" class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-full" />
            </div>
            <div class="w-full flex items-center justify-end mt-5 mb-6 gap-4 ltr:pr-6 rtl:pl-6">
              <button type="button" @click="addOption" v-if="form.sub_photos.length < 3"
                class="bg-gray-700 px-3 py-1.5 rounded-md text-gray-50 hover:bg-gray-800">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                  stroke="currentColor" class="w-6 h-6">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15" />
                </svg>
              </button>
              <button type="button" @click="removeOption"
                class="bg-gray-700 px-3 py-1.5 rounded-md text-gray-50 hover:bg-gray-800">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                  stroke="currentColor" class="w-6 h-6">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 12h-15" />
                </svg>
              </button>
            </div>
            <div class="px-8 pb-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap">
              <textarea-input :label="$t('Description')" v-model="form.description" :errors="errors?.description"
                class="ltr:pr-6 rtl:pl-6 pb-8 w-full" />
            </div>
            <div class="px-8 pb-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap">
              <h3>Size</h3>
            
              <text-input type="text" :label="$t('Small Burst')" v-model="form.small_burst"
                :errors="errors?.small_burst" class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-full" />
              <text-input type="text" :label="$t('Small Waist')" v-model="form.small_waist"
                class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-full" />
              <text-input type="text" :label="$t('Small Hips')" v-model="form.small_hips"
                class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-full" />
              <text-input type="text" :label="$t('Medium Burst')" v-model="form.medium_burst"
                class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-full" />
              <text-input type="text" :label="$t('Medium Waist')" v-model="form.medium_waist"
                class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-full" />
              <text-input type="text" :label="$t('Medium Hips')" v-model="form.medium_hips"
                class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-full" />
              <text-input type="text" :label="$t('Large Burst')" v-model="form.large_burst"
                class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-full" />
              <text-input type="text" :label="$t('Large Waist')" v-model="form.large_waist"
                class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-full" />
              <text-input type="text" :label="$t('Large Hips')" v-model="form.large_hips"
                class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-full" />
            </div>
            <div class="px-8 py-4 bg-gray-100 border-t border-gray-200 flex justify-between items-center">
              <DeleteRestoreComponent :restore="restore" :data="product" :permanentEnable="false" model="Product"
                routeM="products" @close-restore="() => (restore = false)" />
              <loading-button :loading="sending" class="btn-gray" type="submit">
                {{ $t('update_x', { x: $tc('Product') }) }}
              </loading-button>
            </div>
          </form>
        </div>
      </div>
      <div class="w-full md:w-3/5 md:pl-5">
        <div class="bg-white rounded shadow">
          <div class="flex items-center justify-between">
            <h3 class="font-bold text-lg px-6 pt-6 pb-4">{{ $t('Product Reviews') }}</h3>
            <div class="px-6 pt-6">
              <!--              <Button size="sm" color="gray" @click="showReviewModal(0)">-->
              <!--                {{ $t('add_x', {'x': $t('Product Review')}) }}-->
              <!--              </Button>-->
            </div>
          </div>
          <div class="overflow-x-auto scroll-on-light">
            <table class="w-full whitespace-no-wrap">
              <tr class="text-left font-bold">
                <th class="px-6 pt-6 pb-4">{{ $t('Customer') }}</th>
                <th class="px-6 pt-6 pb-4">{{ $tc('Title') }}</th>
                <th class="px-6 pt-6 pb-4">{{ $tc('Rate') }}</th>
                <th class="px-6 pt-6 pb-4" colspan="2">{{ $tc('Content') }}</th>
              </tr>
              <tr :key="review.id" @click="showReviewModal(review.id)" v-for="review in reviews"
                class="cursor-pointer hover:bg-teal-200 focus-within:bg-teal-200">
                <td class="border-t px-6 py-4">
                  <div class="flex items-center">
                    {{ review.customer.name }}
                    <Icons v-if="review.deleted_at" name="trash" class="flex-shrink-0 w-3 h-3 fill-gray-400 ml-2" />
                  </div>
                </td>
                <td class="border-t px-6 py-4">
                  {{ review.title }}
                </td>
                <td class="border-t px-6 py-4">
                  {{ review.rate }}
                </td>
                <td class="border-t px-6 py-4 max-w-md truncate">
                  {{ review.content }}
                </td>
                <td class="border-t px-6 py-4 w-8">
                  <Icons name="cheveron-right" class="block w-6 h-6 fill-gray-400 rtl:rotate" />
                </td>
              </tr>
              <tr v-if="reviews.length === 0">
                <td class="border-t px-6 py-4" colspan="5">{{ $t('no_x_found', { x: $tc('Review') }) }}</td>
              </tr>
            </table>
          </div>
        </div>
        <div class="bg-white rounded shadow" style="margin-top: 2em;">
          <div class="flex items-center justify-between">
            <h3 class="font-bold text-lg px-6 pt-6 pb-4">{{ $t('Product Comments') }}</h3>
            <div class="px-6 pt-6">
            </div>
          </div>
          <div class="overflow-x-auto scroll-on-light">
            <table class="w-full whitespace-no-wrap">
              <tr class="text-left font-bold">
                <th class="px-6 pt-6 pb-4">{{ $t('Customer') }}</th>
                <th class="px-6 pt-6 pb-4" colspan="2">{{ $tc('Comment') }}</th>
              </tr>
              <tr :key="comment.id" @click="showCommentModal(comment.id)" v-for="comment in comments"
                class="cursor-pointer hover:bg-teal-200 focus-within:bg-teal-200">
                <td class="border-t px-6 py-4">
                  <div class="flex items-center">
                    {{ comment.customer.name }}
                    <Icons v-if="comment.deleted_at" name="trash" class="flex-shrink-0 w-3 h-3 fill-gray-400 ml-2" />
                  </div>
                </td>
                <td class="border-t px-6 py-4 max-w-md truncate">
                  {{ comment.comment }}
                </td>
                <td class="border-t px-6 py-4 w-8">
                  <Icons name="cheveron-right" class="block w-6 h-6 fill-gray-400 rtl:rotate" />
                </td>
              </tr>
              <tr v-if="reviews.length === 0">
                <td class="border-t px-6 py-4" colspan="5">{{ $t('no_x_found', { x: $tc('Comment') }) }}</td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
    <Modal :show="viewReview" max-width="2xl" :closeable="true" @close="viewReview = false">
      <ReviewModal :review="review" :show="viewReview" :customers="icustomers" :product_id="product.id"
        @close="() => (viewReview = false)" />
    </Modal>
    <Modal :show="viewComment" max-width="2xl" :closeable="true" @close="viewComment = false">
      <CommentModal :comment="comment" :show="viewComment" :customers="icustomers" :product_id="product.id"
        @close="() => (viewComment = false)" />
    </Modal>
  </div>
</template>

<script>
import { capitalize } from 'vue';
import debounce from 'lodash/debounce';
import Layout from '@/Shared/Layout.vue';
import Modal from '@/Jetstream/Modal.vue';
import Button from '@/Jetstream/Button.vue';
import DeleteMixin from '@/Misc/DeleteMixin';
import FileInput from '@/Shared/FileInput.vue';
import TextInput from '@/Shared/TextInput.vue';
import TextareaInput from '@/Shared/TextareaInput.vue';
import LoadingButton from '@/Shared/LoadingButton.vue';
import TrashedMessage from '@/Shared/TrashedMessage.vue';
import ReviewModal from '@/Pages/Products/ReviewModal.vue';
import CommentModal from '@/Pages/Products/CommentModal.vue';
import DeleteRestoreComponent from '@/Shared/DeleteRestoreComponent.vue';

export default {
  layout: Layout,
  remember: 'form',
  props: { product: Object, icategories: Object, ireviews: Object, icustomers: Object, icomments: Object },
  mixins: [DeleteMixin('product')],
  components: {
    Modal,
    Button,
    TextInput,
    FileInput,
    ReviewModal,
    CommentModal,
    LoadingButton,
    TextareaInput,
    TrashedMessage,
    DeleteRestoreComponent,
  },
  data() {
    return {
      errors: {},
      restore: false,
      sending: false,
      form: {
        main_photo: this.product.main_photo,
        name: this.product.name,
        price: this.product.price,
        type: this.product.type,
        category_id: this.product.category.id,
        description: this.product.description,
        deleted_at: this.product.deleted_at,
        sub_photos: [],
        small_burst: this.product.small_burst,
        small_waist: this.product.small_waist,
        small_hips: this.product.small_hips,
        medium_burst: this.product.medium_burst,
        medium_waist: this.product.medium_waist,
        medium_hips: this.product.medium_hips,
        large_burst: this.product.large_burst,
        large_waist: this.product.large_waist,
        large_hips: this.product.large_hips,
      },
      categories: [],
      category: {
        value: this.product.category.id,
        label: this.product.category.name
      },
      types: [
        { label: "Men", value: "men" },
        { label: "Women", value: "women" }
      ],
      type: {
        label: capitalize(this.product.type),
        value: this.product.type
      },
      reviews: [],
      comments: [],
      review: null,
      viewReview: false,
      viewComment: false,
    };
  },
  watch: {
    category: function (cv) {
      this.form.category_id = cv ? cv.value : null;
    },
    type: function (cv) {
      this.form.type = cv ? cv.value : null;
    },
    ireviews: function (cv) {
      this.reviews = cv
    },
    icomments: function (cv) {
      this.comments = cv;
    }
  },
  mounted() {
    this.categories = this.icategories
    this.reviews = this.ireviews
    this.comments = this.icomments;
    console.log(this.comments);
    if (this.product.sub_photos) {
      this.form.sub_photos = this.product.sub_photos
        .split(',')
        .map(item => ({ file: item }))
    }
  },
  methods: {
    addOption() {
      this.form.sub_photos.push({
        file: ''
      });
    },
    removeOption() {
      this.form.sub_photos.pop();
    },
    submit() {      
      this.sending = true;

      var data = new FormData();
      data.append('name', this.form.name || '');
      data.append('type', this.form.type || '');
      data.append('price', this.form.price || '');
      data.append('main_photo', this.form.main_photo || '');
      data.append('category_id', this.form.category_id || '');
      data.append('description', this.form.description || '');

      data.append('small_burst', this.form.small_burst || '');
      data.append('small_waist', this.form.small_waist || '');
      data.append('small_hips', this.form.small_hips || '');

      data.append('medium_burst', this.form.medium_burst || '');
      data.append('medium_waist', this.form.medium_waist || '');
      data.append('medium_hips', this.form.medium_hips || '');

      data.append('large_burst', this.form.large_burst || '');
      data.append('large_waist', this.form.large_waist || '');
      data.append('large_hips', this.form.large_hips || '');
      this.form.sub_photos.forEach((item, index) => {
        data.append(`sub_photos[${index}]`, item.file || '')
      });

      this.$inertia.post(this.route('products.update', this.product.id), data, {
        onError: (response) => {
          this.errors = response
        },
        onFinish: () => {
          this.sending = false
        },
      });
    },
    searchCategories(search, loading) {
      if (search) {
        loading(true);
        this.searchingCategories(loading, search, this);
      }
    },
    searchingCategories: debounce((loading, search, vm) => {
      fetch(vm.route('ajax.categories') + '?search=' + escape(search)).then(res => {
        res.json().then(data => (vm.categories = data));
        loading(false);
      });
    }, 350),
    showReviewModal(review_id) {
      this.review = this.reviews.find(item => item.id === review_id)
      this.viewReview = true
    },
    showCommentModal(comment_id) {
      this.comment = this.comments.find(item => item.id === comment_id)
      console.log(this.comment);
      this.viewComment = true
    }
  },
}
</script>
