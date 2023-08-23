<template>
  <div>
    <h1 class="mb-6 mt-2 font-bold text-lg md:text-2xl">
      <Link class="text-gray-600 hover:text-gray-800 inline-flex items-center" :href="route('products')">
      <Icons name="back" class="flex-shrink-0 w-3 h-3 md:w-5 md:h-5 fill-current ltr:mr-2 rtl:ml-2 rtl:rotate" />
      {{ $tc('Product', 2) }}
      </Link>
      <span class="text-gray-400 font-medium mx-2">/</span> {{ $t('Create') }}
    </h1>
    <div class="bg-white rounded shadow overflow-hidden max-w-3xl">
      <form @submit.prevent="submit" autocomplete="off">
        <div class="p-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap">
          <text-input v-model="form.name" :errors="errors?.name"
            class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-full" :label="$t('Name')" />
        </div>
        <div class="px-8 pb-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap">
          <div class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-full">
            <label class="form-label" for="category_id">{{ $tc('Category') }}</label>
            <v-select
              v-model="category"
              :options="categories"
              input-id="category_id"
              @search="searchCategories"
              :dir="$page.props.user.account.direction"
              :placeholder="$t('search_x', { x: $tc('Category', 2) })"
              :class="{
                error: errors?.category_id && errors?.category_id.length,
              }"
            ></v-select>
            <div v-if="errors?.category_id" class="form-error">
              {{ errors?.category_id }}
            </div>
          </div>
        </div>
        <div class="px-8 pb-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap">
          <div class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-full">
            <label class="form-label" for="type">{{ $tc('Type') }}</label>
            <v-select
              v-model="type"
              :options="types"
              input-id="type"
              :dir="$page.props.user.account.direction"
              :placeholder="$t('select_x', { x: $tc('Type', 1) })"
              :class="{
                error: errors?.type && errors?.type.length,
              }"
            ></v-select>
            <div v-if="errors?.type" class="form-error">
              {{ errors?.type }}
            </div>
          </div>
        </div>
        <div class="px-8 pb-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap">
          <text-input
            type="number"
            :label="$t('Price')"
            :enableFloat="true"
            v-model="form.price"
            :errors="errors?.price"
            class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-full"
          />
        </div>
        <div class="px-8 pb-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap">
          <file-input type="file" accept="image/*" :label="$t('Main Photo')" v-model="form.main_photo"
            :error="errors?.main_photo" class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-full" />
        </div>
        <div v-for="(item, index) in form.sub_photos" :key="index" class="px-8 pb-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap">
          <file-input
            type="file" 
            accept="image/*" 
            :label="$t('Sub Photo') + ' ' + (index + 1)" 
            v-model="item.file"
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
          <textarea-input
            :label="$t('Description')"
            v-model="form.description"
            :errors="errors?.description"
            class="ltr:pr-6 rtl:pl-6 pb-8 w-full"
          />
        </div>
        <div class="px-8 py-4 bg-gray-100 border-t border-gray-200 flex justify-end items-center">
          <loading-button :loading="sending" class="btn-gray" type="submit">
            {{ $t('create_x', { x: $tc('Product') }) }}
          </loading-button>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import debounce from 'lodash/debounce';
import Layout from '@/Shared/Layout.vue';
import TextInput from '@/Shared/TextInput.vue';
import FileInput from '@/Shared/FileInput.vue';
import TextareaInput from '@/Shared/TextareaInput.vue';
import LoadingButton from '@/Shared/LoadingButton.vue';

export default {
  layout: Layout,
  props: { icategories: Object },
  components: { LoadingButton, TextInput, FileInput, TextareaInput },
  data() {
    return {
      errors: {},
      sending: false,
      form: {
        name: null,
        price: 0,
        main_photo: null,
        description: null,
        category_id: null,
        type: null,
        sub_photos: []
      },
      categories: [],
      category: null,
      types: [
        { label: "Men", value: "men" },
        { label: "Women", value: "women" }
      ],
      type: null
    };
  },
  watch: {
    category: function (cv) {
      this.form.category_id = cv ? cv.value : null;
    },
    type: function (cv) {
      this.form.type = cv ? cv.value : null;
    },
  },
  mounted() {
    this.categories = this.icategories
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
      data.append('main_photo', this.form.main_photo || '');
      data.append('name', this.form.name || '');
      data.append('price', this.form.price || 0);
      data.append('type', this.form.type || '');
      data.append('category_id', this.form.category_id || '');
      data.append('description', this.form.description || '');
      this.form.sub_photos.forEach((item, index) => {
        data.append(`sub_photos[${index}]`, item.file || '')
      });

      this.$inertia.post(this.route('products.store'), data, {
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
  },
}
</script>