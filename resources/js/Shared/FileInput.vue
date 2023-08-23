<template>
  <div>
    <div class="flex mt-1 items-center">
      <div :class="previewUrl && previewImageUrl ? 'w-5/6' : 'w-full'">
        <tec-label v-if="label" :for="id" :value="label" />
        <div class="relative rounded-md mt-1">
          <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
            <icons name="link" class="text-gray-500" />
          </div>
          <tec-input type="text" @click="browse" id="file-input" readonly="true" :value="selected"
            :placeholder="$t('Select File')" class="form-input block w-full pl-10 pr-12" />
          <div class="absolute inset-y-0 right-0 flex items-stretch">
            <button type="button" @click="remove" v-if="modelValue"
              class="px-4 py-2 bg-red-500 hover:bg-red-700 focus:outline-none rounded-r-md font-medium text-white fill-white flex items-center">
              <icons name="cross" class="w-6 h-6 sm:mr-2" />&nbsp;
              <span class="hidden sm:inline-block">{{ $t('Remove') }}</span>
            </button>
            <button v-else type="button" @click="browse"
              class="px-4 py-2 bg-gray-600 hover:bg-gray-800 focus:outline-none rounded-r-md font-medium text-white fill-white flex items-center">
              <icons name="folder" class="w-6 h-6 sm:mr-2" />&nbsp;
              <span class="hidden sm:inline-block">{{ $t('Browse') }}</span>
            </button>
          </div>
          <input :id="id" ref="file" type="file" :accept="accept" class="hidden" @change="change" />
        </div>
      </div>
      <div v-if="previewUrl && previewImageUrl" class="w-1/6">
        <img :src="previewImageUrl" class="w-3/4 ml-auto rounded-full border-2 object-cover" :style="{aspectRatio: 1/1}" />
      </div>
    </div>
    <tec-input-error v-if="error" :message="error" />
  </div>
</template>

<script>
import { v4 as uuidv4 } from 'uuid';
import TecLabel from '@/Jetstream/Label.vue';
import TecInput from '@/Jetstream/Input.vue';
import TecInputError from '@/Jetstream/InputError.vue';
export default {
  emits: ['update:modelValue'],

  components: { TecLabel, TecInput, TecInputError },

  props: {
    label: String,
    error: String,
    accept: String,
    modelValue: File | String,
    previewUrl: {
      type: String,
      default: null
    },
    id: {
      type: String,
      default() {
        return uuidv4();
      },
    },
  },

  data() {
    return {
      previewImageUrl: (this.previewUrl && this.modelValue) ? this.previewUrl + this.modelValue : null
    }
  },

  watch: {
    modelValue(value) {
      if (!value) {
        this.previewImageUrl = null;
        this.$refs.file.value = '';
      } else if(typeof value === 'object') {
        this.previewImage(value)
      }
    },
  },

  computed: {
    selected() {
      if (typeof this.modelValue === 'string')
        return this.modelValue;
      return this.modelValue ? this.modelValue.name + ' (' + this.filesize(this.modelValue.size) + ')' : '';
    },
  },

  methods: {
    filesize(size) {
      var i = Math.floor(Math.log(size) / Math.log(1024));
      return (size / Math.pow(1024, i)).toFixed(2) * 1 + ' ' + ['B', 'kB', 'MB', 'GB', 'TB'][i];
    },
    browse() {
      this.$refs.file.click();
    },
    change(e) {
      this.$emit('update:modelValue', e.target.files[0]);
    },
    remove() {
      this.$emit('update:modelValue', null);
    },
    previewImage(file) {
      const reader = new FileReader();
      reader.onload = (event) => {
        this.previewImageUrl = event.target.result;
      };
      reader.readAsDataURL(file);
    }
  },
};
</script>
