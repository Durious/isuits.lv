<template>
  <div class="w-full ltr:text-left rtl:text-right">
    <div v-if="modal" class="np flex justify-between items-center px-6 py-4 mb-4 bg-gray-100 border-b rounded-t">
      <p class="font-bold">{{ $t('Customer Measure') }}</p>
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
    <div class="w-full h-full px-6 leading-normal">
      <div class="flex flex-wrap border-b pb-3">
        <div class="w-1/3 p-2">
          <text-input :label="$t('dob')" type="date" v-model="form.measurement.dob" :errors="errors?.dob" />
        </div>
        <div class="w-1/3 p-2">
          <text-input :label="$t('height') + ' (cm)'" type="number" v-model="form.measurement.height"
            :errors="errors?.height" />
        </div>
        <div class="w-1/3 p-2">
          <text-input :label="$t('weight') + ' (kg)'" type="number" v-model="form.measurement.weight"
            :errors="errors?.weight" />
        </div>
      </div>
      <div class="flex flex-wrap border-b py-4">
        <div class="w-1/3 p-2" v-for="number_key in number_keys">
          <text-input :label="$t(number_key) + ' (cm)'" type="number" v-model="form.measurement[number_key]"
            :errors="errors[number_key]" :placeholder="$t(number_key)"/>
        </div>
      </div>
      <div class="flex flex-wrap py-4">
        <div class="w-1/3 p-2">
          <label class="form-label font-medium text-gray-700" for="shoulder_type">{{ $tc('shoulder_type')
          }}</label>
          <v-select transition="" input-id="shoulder_type" :options="['high', 'regular', 'low']" :filterable="false"
            :searchable="false" v-model="form.measurement.shoulder_type" :dir="$page.props.user.account.direction"
            :placeholder="$t('select_x', { x: $t('shoulder_type') })" :class="{
              capitalize: true,
              error: errors?.shoulder_type && errors?.shoulder_type.length,
            }"></v-select>
          <div v-if="errors?.shoulder_type" class="form-error">
            {{ errors?.shoulder_type }}
          </div>
        </div>
        <div class="w-1/3 p-2">
          <label class="form-label font-medium text-gray-700" for="chest_type">{{ $tc('chest_type') }}</label>
          <v-select transition="" input-id="chest_type" :options="['chiselled', 'regular', 'robust']" :filterable="false"
            :searchable="false" v-model="form.measurement.chest_type" :dir="$page.props.user.account.direction"
            :placeholder="$t('select_x', { x: $t('chest_type') })" :class="{
              capitalize: true,
              error: errors?.chest_type && errors?.chest_type.length,
            }"></v-select>
          <div v-if="errors?.chest_type" class="form-error">
            {{ errors?.chest_type }}
          </div>
        </div>
        <div class="w-1/3 p-2">
          <label class="form-label font-medium text-gray-700" for="stomach_type">{{ $tc('stomach_type') }}</label>
          <v-select transition="" input-id="stomach_type" :options="['flat', 'regular', 'protruding']" :filterable="false"
            :searchable="false" v-model="form.measurement.stomach_type" :dir="$page.props.user.account.direction"
            :placeholder="$t('select_x', { x: $t('stomach_type') })" :class="{
              capitalize: true,
              error: errors?.stomach_type && errors?.stomach_type.length,
            }"></v-select>
          <div v-if="errors?.stomach_type" class="form-error">
            {{ errors?.stomach_type }}
          </div>
        </div>
        <div class="w-1/3 p-2">
          <label class="form-label font-medium text-gray-700" for="back_type">{{ $tc('back_type') }}</label>
          <v-select transition="" input-id="back_type" :options="['straight', 'regular', 'curved']" :filterable="false"
            :searchable="false" v-model="form.measurement.back_type" :dir="$page.props.user.account.direction"
            :placeholder="$t('select_x', { x: $t('back_type') })" :class="{
              capitalize: true,
              error: errors?.back_type && errors?.back_type.length,
            }"></v-select>
          <div v-if="errors?.back_type" class="form-error">
            {{ errors?.back_type }}
          </div>
        </div>
        <div class="w-1/3 p-2">
          <label class="form-label font-medium text-gray-700" for="rear_type">{{ $tc('rear_type') }}</label>
          <v-select transition="" input-id="rear_type" :options="['flat', 'regular', 'protruding']" :filterable="false"
            :searchable="false" v-model="form.measurement.rear_type" :dir="$page.props.user.account.direction"
            :placeholder="$t('select_x', { x: $t('rear_type') })" :class="{
              capitalize: true,
              error: errors?.rear_type && errors?.rear_type.length,
            }"></v-select>
          <div v-if="errors?.rear_type" class="form-error">
            {{ errors?.rear_type }}
          </div>
        </div>
        <div class="w-1/3 p-2">
          <label class="form-label font-medium text-gray-700" for="fit">{{ $tc('fit') }}</label>
          <v-select transition="" input-id="fit" :options="['comfort', 'regular', 'slim']" :filterable="false"
            :searchable="false" v-model="form.measurement.fit" :dir="$page.props.user.account.direction"
            :placeholder="$t('select_x', { x: $t('fit') })" :class="{
              capitalize: true,
              error: errors?.fit && errors?.fit.length,
            }"></v-select>
          <div v-if="errors?.fit" class="form-error">
            {{ errors?.fit }}
          </div>
        </div>
      </div>
    </div>
    <div class="np block xs:flex px-6 py-4 mt-4 bg-gray-100 border-t rounded-b">
      <loading-button :loading="sending" class="btn-gray ml-auto" @click="submit()">
        {{ $t('Update') }}
      </loading-button>
      <button @click="$emit('close')" class="btn-gray ml-5">
        {{ $t('Close') }}
      </button>
    </div>
  </div>
</template>

<script>
import TextInput from '@/Shared/TextInput.vue';
import TextareaInput from '@/Shared/TextareaInput.vue';
import LoadingButton from '@/Shared/LoadingButton.vue';

const default_measurement = {
  dob: '',
  height: '',
  weight: '',
  chest: '',
  neck: '',
  shoulder: '',
  back_length: '',
  arm_length: '',
  biceps: '',
  wrist: '',
  stomach: '',
  waistline: '',
  hip: '',
  inside_length: '',
  thigh: '',
  shoulder_type: '',
  chest_type: '',
  stomach_type: '',
  back_type: '',
  rear_type: '',
  fit: '',
}
export default {
  props: {
    measurement: Object,
    modal: {
      type: Boolean,
      default: true
    },
    customer_id: Number
  },
  components: { TextInput, TextareaInput, LoadingButton },
  data() {
    return {
      errors: {},
      sending: false,
      form: {
        measurement: this.measurement ?? default_measurement
      },
      number_keys: ['chest', 'neck', 'shoulder', 'back_length', 'arm_length', 'biceps', 'wrist', 'stomach', 'waistline', 'hip', 'inside_length', 'thigh']
    }
  },
  watch: {
    customer_id: function () {
      this.form.measurement = this.measurement ?? default_measurement
      this.errors = {}
    }
  },
  methods: {
    submit() {
      this.sending = true
      this.$inertia.put(
        this.route('customers.measure', this.customer_id),
        this.form.measurement,
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