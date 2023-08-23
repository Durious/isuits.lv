<template>
  <div>
    <h1 class="mb-6 mt-2 font-bold text-lg md:text-2xl">
      <Link class="text-gray-600 hover:text-gray-800 inline-flex items-center" :href="route('categories')">
      <Icons name="back" class="flex-shrink-0 w-3 h-3 md:w-5 md:h-5 fill-current ltr:mr-2 rtl:ml-2 rtl:rotate" />
      {{ $tc('Category', 2) }}
      </Link>
      <span class="text-gray-400 font-medium mx-2">/</span> {{ $t('Create') }}
    </h1>
    <div class="bg-white rounded shadow max-w-3xl">
      <form @submit.prevent="submit" autocomplete="off">
        <div class="p-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap">
          <text-input v-model="form.name" :errors="errors?.name" class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-full"
            :label="$t('Name')" />
        </div>
        <div class="px-8 pb-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap">
          <file-input type="file" accept="image/*" :label="$t('Photo')" v-model="form.photo" :error="errors?.photo"
            class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-full" />
        </div>
        <div class="px-8 pb-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap">
          <div class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-full">
            <label class="form-label" for="custom_fields">{{ $tc('custom_field') }}</label>
            <v-select 
              multiple 
              transition="" 
              :options="customFields" 
              input-id="custom_fields" 
              v-model="form.customFields"
              :dir="$page.props.user.account.direction"
              :placeholder="$t('search_x', { x: $tc('custom_field', 2) })" 
            >
            </v-select>
          </div>
        </div>
        <div class="px-8 pb-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap">
          <textarea-input :label="$t('Description')" v-model="form.description" :error="errors?.description"
            class="ltr:pr-6 rtl:pl-6 pb-8 w-full" />
        </div>
        <div class="px-8 py-4 bg-gray-100 border-t border-gray-200 flex justify-end items-center">
          <loading-button :loading="sending" class="btn-gray" type="submit">
            {{ $t('create_x', { x: $tc('Category') }) }}
          </loading-button>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import Layout from '@/Shared/Layout.vue';
import TextInput from '@/Shared/TextInput.vue';
import FileInput from '@/Shared/FileInput.vue';
import TextareaInput from '@/Shared/TextareaInput.vue';
import LoadingButton from '@/Shared/LoadingButton.vue';

export default {
  layout: Layout,
  props: {icustomFields: Object},
  components: { LoadingButton, TextInput, FileInput, TextareaInput },
  data() {
    return {
      errors: {},
      sending: false,
      form: {
        name: null,
        photo: null,
        description: null,
        customFields: []
      },
      customFields: [],
    };
  },
  mounted() {
    this.customFields = this.icustomFields;
  },
  methods: {
    submit() {
      this.sending = true;

      var data = new FormData();
      data.append('photo', this.form.photo || '');
      data.append('name', this.form.name || '');
      data.append('description', this.form.description || '');
      data.append('custom_fields', JSON.stringify(this.form.customFields.map(s => s.value)))

      this.$inertia.post(this.route('categories.store'), data, {
        onError: (response) => {
          this.errors = response
        },
        onFinish: () => {
          this.sending = false
        },
      });
    },
  },
}
</script>