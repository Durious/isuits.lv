<template>
  <div v-if="cart && cart.id" class="w-full ltr:text-left rtl:text-right">
    <div v-if="modal" class="np flex justify-between items-center px-6 py-4 mb-4 bg-gray-100 border-b rounded-t">
      <p class="font-bold">{{ $t('Customization') }}</p>
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
    <div class="w-full h-full ltr:pl-8 rtl:pr-8 py-5 leading-normal flex flex-wrap">
      <div v-for="(f, i) in icustom_fields" :key="'custom_field_' + i" class="w-1/2">
        <template v-if="f.type == 'Text'">
          <div :key="'in_' + i">
            <text-input 
              :label="f.name" 
              v-model="form[f.name]" 
              class="ltr:pr-6 rtl:pl-6 pb-4"
              :errors="errors[f.name]"/>
          </div>
        </template>
        <template v-if="f.type == 'Number'">
          <div :key="'in_' + i">
            <text-input 
              :label="f.name" 
              type="Number" 
              v-model="form[f.name]" 
              :errors="errors[f.name]"
              class="ltr:pr-6 rtl:pl-6 pb-4" />
          </div>
        </template>
        <template v-if="f.type == 'TextArea'">
          <div :key="'in_' + i">
            <textarea-input 
              :rows="5" 
              :label="f.name" 
              v-model="form[f.name]" 
              class="ltr:pr-6 rtl:pl-6 pb-4"
              :error="errors[f.name]"/>
          </div>
        </template>
        <template v-else-if="f.type == 'Radio' || f.type == 'ImageRadio'">
          <div :key="'in_' + i">
            <div class="ltr:text-left rtl:text-right ltr:pr-6 rtl:pl-6 mb-8" :key="'in_' + i">
              <label class="form-label mr-6 font-medium text-gray-700" :key="'in_' + i">{{ f.name }}</label>
              <radio-input :name="f.name" :label="o.name" :value="o.name" class="mb-2 w-full mr-6"
                :id="'r_' + oi + '_' + i" :key="'r_' + oi + '_' + i" v-for="(o, oi) in JSON.parse(f.options)"
                :checked="o.name == form[f.name]" @input="updateFormValue(o.name, f.name)" />
              <div v-if="errors[f.name]" class="form-error">
                {{ errors[f.name] }}
              </div>
            </div>
          </div>
        </template>
      </div>
    </div>
    <div class="np block xs:flex px-6 py-4 mt-4 bg-gray-100 border-t rounded-b">
      <button @click="submit()" class="btn-gray ml-auto">
        {{ $t('Update') }}
      </button>
      <button @click="$emit('close')" class="btn-gray ml-5">
        {{ $t('Close') }}
      </button>
    </div>
  </div>
</template>

<script>
import TextInput from '@/Shared/TextInput.vue';
import RadioInput from '@/Shared/RadioInput.vue';
import TextareaInput from '@/Shared/TextareaInput.vue';

export default {
  components: { TextInput, TextareaInput, RadioInput },
  props: {
    cart: Object,
    icustom_fields: Array,
    opened: Boolean,
    modal: {
      type: Boolean,
      default: true
    }
  },
  data() {
    return {
      form: {},
      errors: {}
    }
  },
  watch: {
    opened: function (nV, oV) {
      const tmp = {}
      this.icustom_fields.forEach(item => {
        tmp[item.name] = ''
      })
      this.form = {
        ...tmp,
        ...this.cart.customization
      }
      this.errors = {}
    }
  },
  methods: {
    submit() {
      let errors = {}
      let error_count = 0
      Object.keys(this.form)
        .filter(item => this.form[item] === '')
        .forEach(item => {
          error_count++;
          errors[item] = item + ' is required.'
        })
      this.errors = errors
      if(error_count > 0) return
      this.$emit('submit', {
        id: this.cart.id,
        data: this.form
      })
    },
    updateFormValue(v, f) {
      this.form[f] = v;
    },
  }
}
</script>