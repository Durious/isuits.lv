<template>
  <div>
    <h1 class="mb-6 mt-2 font-bold text-lg md:text-2xl">
      <Link class="text-gray-600 hover:text-gray-800 inline-flex items-center" :href="route('measurement_fields')">
        <Icons name="back" class="flex-shrink-0 w-3 h-3 md:w-5 md:h-5 fill-current ltr:mr-2 rtl:ml-2 rtl:rotate" />
        {{ $tc('Measurement Field', 2) }}
      </Link>
      <span class="text-gray-400 font-medium mx-2">/</span> {{ $t('Create') }}
    </h1>
    <div class="bg-white rounded shadow overflow-hidden max-w-3xl">
      <form @submit.prevent="submit" autocomplete="off">
        <div class="p-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap">
          <text-input
            :label="$t('Name')"
            v-model="form.name"
            :errors="$page.props.errors?.name"
            class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"
          />
          <text-input
            type="number"
            v-model="form.order"
            :label="$tc('Order')"
            :errors="$page.props.errors?.order"
            class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"
          />
          <div class="ltr:pr-6 rtl:pl-6 pb-8 w-full">
            <label class="form-label" for="type">{{ $tc('Type') }}</label>
            <v-select
              :dir="$page.props.user.account.direction"
              transition=""
              input-id="type"
              :options="types"
              :filterable="false"
              :searchable="false"
              v-model="form.type"
              :placeholder="$t('select_x', { x: $t('Type') })"
              :class="{
                error: $page.props.errors?.type && $page.props.errors?.type.length,
              }"
            ></v-select>
            <div v-if="$page.props.errors?.type" class="form-error">
              {{ $page.props.errors?.type[0] }}
            </div>
          </div>
          <template v-if="form.type == 'Select' || form.type == 'Radio' || form.type == 'Checkbox'">
            <text-input
              :key="'opt_' + i"
              v-model="o.value"
              @focus="checkOptions(i + 1)"
              :label="'Option ' + (i + 1)"
              v-for="(o, i) in form.options"
              class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"
              :errors="$page.props.errors['options.' + i + '.value']"
            />
            <div class="w-full flex items-center justify-end -mt-2 mb-6 gap-4 ltr:pr-6 rtl:pl-6">
              <button type="button" @click="addOption" class="bg-gray-700 px-3 py-1.5 rounded-md text-gray-50 hover:bg-gray-800">
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke-width="1.5"
                  stroke="currentColor"
                  class="w-6 h-6"
                >
                  <path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15" />
                </svg>
              </button>
              <button type="button" @click="removeOption" class="bg-gray-700 px-3 py-1.5 rounded-md text-gray-50 hover:bg-gray-800">
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke-width="1.5"
                  stroke="currentColor"
                  class="w-6 h-6"
                >
                  <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 12h-15" />
                </svg>
              </button>
            </div>
          </template>
          <div class="ltr:pr-6 rtl:pl-6 pb-8 w-full">
            <label class="form-label" for="services">{{ $tc('Service') }}</label>
            <v-select
              multiple
              transition=""
              :options="services"
              input-id="services"
              v-model="form.services"
              @search="searchServices"
              :dir="$page.props.user.account.direction"
              :placeholder="$t('search_x', { x: $tc('Service', 2) })"
              :class="{
                error: $page.props.errors?.services && $page.props.errors?.services.length,
              }"
            >
              <template #list-footer>
                <li
                  role="option"
                  @click="deselectAllServices()"
                  v-if="services.length == form.services.length"
                  class="vs__dropdown-option bg-gray-300 hover:bg-gray-400"
                >
                  {{ $t('Deselect all above') }}
                </li>
                <li role="option" v-else @click="selectAllServices()" class="vs__dropdown-option bg-gray-300 hover:bg-gray-400">
                  {{ $t('Select all above') }}
                </li>
              </template>
            </v-select>
            <div v-if="$page.props.errors?.services" class="form-error">
              {{ $page.props.errors?.services[0] }}
            </div>
          </div>
          <textarea-input
            ref="desc"
            :label="$t('Description')"
            class="ltr:pr-6 rtl:pl-6 pb-8 w-full"
            v-model="form.description"
            :errors="$page.props.errors?.description"
          />
          <checkbox-input
            class="mb-8"
            id="required"
            v-model:checked="form.required"
            :checked="form.required"
            :label="$t('This field is required')"
          ></checkbox-input>
        </div>
        <div class="px-8 py-4 bg-gray-100 border-t border-gray-200 flex justify-end items-center">
          <loading-button :loading="sending" class="btn-gray" type="submit">
            {{ $t('create_x', { x: $tc('Measurement Field') }) }}
          </loading-button>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import Layout from '@/Shared/Layout.vue';
import debounce from 'lodash/debounce';
import TextInput from '@/Shared/TextInput.vue';
import CheckboxInput from '@/Shared/CheckboxInput.vue';
import LoadingButton from '@/Shared/LoadingButton.vue';
import TextareaInput from '@/Shared/TextareaInput.vue';

export default {
  layout: Layout,
  remember: 'form',
  props: { iservices: Array },
  components: { CheckboxInput, LoadingButton, TextInput, TextareaInput },
  metaInfo() {
    return { title: this.$t('create_x', { x: this.$tc('Measurement Field') }) };
  },
  data() {
    return {
      form: {
        name: null,
        type: null,
        order: null,
        services: [],
        required: false,
        description: null,
        options: [{ value: '' }, { value: '' }],
      },
      services: [],
      sending: false,
      types: ['Text', 'Select', 'Textarea', 'Checkbox', 'Radio'],
    };
  },
  mounted() {
    this.services = this.iservices;
  },
  methods: {
    submit() {
      this.sending = true;
      let data = {
        ...this.form,
        options: [...this.form.options],
        services: this.form.services.map(s => s.value),
      };
      data.options.pop();
      this.$inertia.post(this.route('measurement_fields.store'), data, {
        onFinish: () => (this.sending = false),
      });
    },
    selectAllServices() {
      this.form.services = [];
      this.services.map(s => {
        this.form.services.push(s);
      });
      this.$refs.desc.focus();
    },
    deselectAllServices() {
      this.form.services = [];
      this.$refs.desc.focus();
    },
    optionChanged(v, si) {
      this.form.options = this.form.options.map((o, i) => (si == i ? v : o));
    },
    checkOptions(i) {
      const ol = this.form.options.length;
      if (i == ol) {
        this.form.options.push({ value: '' });
      }
    },
    addOption() {
      this.form.options.push({ value: '' });
    },
    removeOption() {
      this.form.options.pop();
    },
    searchServices(search, loading) {
      if (search) {
        loading(true);
        this.searchingServices(loading, search, this);
      }
    },
    searchingServices: debounce((loading, search, vm) => {
      fetch(vm.route('ajax.services') + '?search=' + escape(search)).then(res => {
        res.json().then(data => (vm.services = data));
        loading(false);
      });
    }, 350),
  },
};
</script>
