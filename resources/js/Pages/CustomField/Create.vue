<template>
  <div>
    <h1 class="mb-6 mt-2 font-bold text-lg md:text-2xl">
      <Link class="text-gray-600 hover:text-gray-800 inline-flex items-center" :href="route('customfields')">
      <Icons name="back" class="flex-shrink-0 w-3 h-3 md:w-5 md:h-5 fill-current ltr:mr-2 rtl:ml-2 rtl:rotate" />
      {{ $tc('custom_field', 2) }}
      </Link>
      <span class="text-gray-400 font-medium mx-2">/</span> {{ $t('Create') }}
    </h1>
    <div class="bg-white rounded shadow overflow-hidden max-w-3xl">
      <form @submit.prevent="submit" autocomplete="off">
        <div class="p-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap">
          <text-input v-model="form.name" :errors="errors?.name" class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-full"
            :label="$t('Name')" />
        </div>
        <div class="px-8 pb-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap">
          <div class="ltr:pr-6 rtl:pl-6 pb-8 w-full">
            <label class="form-label" for="type">{{ $tc('Type') }}</label>
            <v-select :dir="$page.props.user.account.direction" transition="" input-id="type" :options="types"
              :filterable="false" :searchable="false" v-model="form.type" :placeholder="$t('select_x', { x: $t('Type') })"
              :class="{ error: errors?.type && errors?.type.length, }"></v-select>
            <div v-if="errors?.type" class="form-error">
              {{ errors?.type }}
            </div>
          </div>
          <template v-if="form.type === 'Radio' || form.type === 'ImageRadio'">
            <div class="w-full">
              <div v-for="(item, index) in form.options" :key="index" class="py-5" :class="index !== 0 ? 'border-t' : ''">
                <div class="mb-3">
                  {{ $tc('Option') + ' ' + (index + 1) }}
                </div>
                <div class="flex w-full">
                  <text-input v-model="item.name" class="ltr:pr-6 rtl:pl-6 w-full lg:w-1/2" :label="$t('Name')"
                  :errors="errors['options.' + index + '.name']" />
                  <text-input v-model="item.description" class="ltr:pr-6 rtl:pl-6 w-full lg:w-1/2"
                    :label="$t('Description')" :errors="errors['options.' + index + '.description']" />
                </div>
                <file-input v-if="form.type === 'ImageRadio'" type="file" accept="image/*" :label="$t('Photo')"
                  v-model="item.file" :error="errors['options.' + index + '.file']" class="ltr:pr-6 rtl:pl-6 w-full lg:w-full" />
                <file-input v-if="form.type === 'ImageRadio'" type="file" accept="image/*" :label="$t('Preview')"
                    v-model="item.preview" :error="errors['options.' + index + '.preview']"
                    class="ltr:pr-6 rtl:pl-6 w-full lg:w-full" />
              </div>
            </div>
            <div class="w-full flex items-center justify-end mt-5 mb-6 gap-4 ltr:pr-6 rtl:pl-6">
              <button type="button" @click="addOption"
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
          </template>
        </div>
        <div class="px-8 pb-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap">
          <text-input v-model="form.tag" :errors="errors?.tag" class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-full"
            :label="$t('Tag')" />
        </div>
        <div class="px-8 pb-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap">
          <textarea-input :label="$t('Description')" v-model="form.description" :error="errors?.description"
            class="ltr:pr-6 rtl:pl-6 pb-8 w-full" />
        </div>
        <div class="px-8 py-4 bg-gray-100 border-t border-gray-200 flex justify-end items-center">
          <loading-button :loading="sending" class="btn-gray" type="submit">
            {{ $t('create_x', { x: $tc('custom_field') }) }}
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
import LoadingButton from '@/Shared/LoadingButton.vue';
import TextareaInput from '@/Shared/TextareaInput.vue';

export default {
  layout: Layout,
  components: { LoadingButton, TextInput, FileInput, TextareaInput },
  metaInfo() {
    return { title: this.$tc('custom_field', 2) };
  },
  data() {
    return {
      errors: {},
      form: {
        name: '',
        type: '',
        tag: '',
        options: [{
          name: '',
          description: '',
          file: '',
          preview: ''
        }, {
          name: '',
          description: '',
          file: '',
          preview: ''
        }],
        description: ''
      },
      sending: false,
      types: ['Text', 'Number', 'ImageRadio', 'Radio', 'TextArea']
    }
  },
  methods: {
    addOption() {
      this.form.options.push({
        name: '',
        description: '',
        file: '',
        preview: ''
      });
    },
    removeOption() {
      this.form.options.pop();
    },
    submit() {
      this.sending = true;

      const data = new FormData();
      data.append('name', this.form.name);
      data.append('type', this.form.type);
      data.append('description', this.form.description);
      data.append('tag', this.form.tag);

      if (this.form.type === 'Radio' || this.form.type === 'ImageRadio')
        this.form.options.forEach((option, index) => {
          for (let key in option) {
            (key === 'file' || key === 'preview')
              ? this.form.type === 'ImageRadio' && data.append(`options[${index}][${key}]`, option[key] || '')
              : data.append(`options[${index}][${key}]`, option[key])
          }
        });

      this.$inertia.post(this.route('customfields.store'), data, {
        onError: (response) => {
          this.errors = response
        },
        onFinish: () => {
          this.sending = false
        },
      });
    }
  }
};
</script>