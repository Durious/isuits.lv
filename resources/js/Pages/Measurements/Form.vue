<template>
  <div class="w-full ltr:text-left rtl:text-right">
    <div :class="modal ? 'np flex flex-col justify-between items-center px-6 py-4 mb-4 bg-gray-100 border-b rounded-t' : ''">
      <div v-if="modal" class="w-full flex items-start justify-between border-b">
        <p class="font-bold flex-1 mb-4">{{ $t('add_x', { x: $tc('Measurement') }) }}</p>
        <div class="flex items-center">
          <a class="modal-close cursor-pointer z-50" @click="$emit('close')">
            <svg class="fill-current text-black" xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 18 18">
              <path
                d="M14.53 4.53l-1.06-1.06L9 7.94 4.53 3.47 3.47 4.53 7.94 9l-4.47 4.47 1.06 1.06L9 10.06l4.47 4.47 1.06-1.06L10.06 9z"
              ></path>
            </svg>
          </a>
        </div>
      </div>

      <div :class="modal ? 'print bg-white -mx-6 -mb-8 rounded-md' : ''">
        <form @submit.prevent="submit" autocomplete="off">
          <div class="px-8 py-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap">
            <div class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2">
              <label class="form-label" for="customer_id">{{ $tc('Customer') }}</label>
              <v-select
                v-model="customer"
                :options="customers"
                input-id="customer_id"
                @search="searchCustomers"
                :dir="$page.props.user.account.direction"
                :placeholder="$t('search_x', { x: $tc('Customer', 2) })"
                :class="{
                  error: $page.props.errors?.customer_id && $page.props.errors?.customer_id.length,
                }"
              ></v-select>
              <div v-if="$page.props.errors?.customer_id" class="form-error">
                {{ $page.props.errors?.customer_id[0] }}
              </div>
            </div>
            <div class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2">
              <label class="form-label" for="service_id">{{ $tc('Service') }}</label>
              <v-select
                v-model="service"
                :options="services"
                input-id="service_id"
                @search="searchServices"
                :dir="$page.props.user.account.direction"
                :placeholder="$t('search_x', { x: $tc('Service', 2) })"
                :class="{
                  error: $page.props.errors?.service_id && $page.props.errors?.service_id.length,
                }"
              ></v-select>
              <div v-if="$page.props.errors?.service_id" class="form-error">
                {{ $page.props.errors?.service_id[0] }}
              </div>
            </div>
            <div class="mb-8 ltr:mr-6 rtl:ml-6 flex flex-wrap">
              <label class="form-label" for="name">{{ $t('Type Name') }}</label>
              <input
                id="name"
                type="text"
                v-model="form.name"
                :placeholder="$t('Type Name')"
                class="form-input block w-full mt-1 rounded-md border border-gray-300 shadow-sm focus:border-indigo-300 focus:ring-2 focus:ring-indigo-100"
                :class="{
                  error: $page.props.errors?.name && $page.props.errors?.name.length,
                }"
              />
              <div>
                <div class="text-sm mt-1">
                  {{ $t("Person name with services name i.e, John's Son Blazer, Mike Kurta or Shalini Blouse etc") }}
                </div>
                <div v-if="$page.props.errors?.name && $page.props.errors?.name.length" class="form-error">
                  {{ $page.props.errors?.name[0] }}
                </div>
              </div>
            </div>
            <div
              class="ltr:pr-6 rtl:pl-6 ltr:-mr-12 rtl:-ml-12 w-full"
              v-if="service && service.measurement_fields && service.measurement_fields.length"
            >
              <h1 class="font-bold mb-2">{{ $tc('Measurement Field', 2) }}</h1>
              <hr class="mb-8" />
              <div class="ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 col-span-full grid grid-cols-1 sm:grid-cols-2">
                <template v-for="(f, i) in service.measurement_fields">
                  <template v-if="f.type == 'Text'">
                    <div :key="'in_' + i">
                      <text-input
                        :label="f.name"
                        v-model="form[f.name]"
                        :errors="$page.props.errors[f.name]"
                        class="ltr:pr-6 rtl:pl-6 pb-8"
                      />
                    </div>
                  </template>
                  <template v-else-if="f.type == 'Select'">
                    <div :key="'in_' + i">
                      <select-input :label="f.name" v-model="form[f.name]" :errors="$page.props.errors[f.name]" class="ltr:pr-6 rtl:pl-6">
                        <option v-for="(o, oi) in f.options" :key="'o_' + oi" :value="o.value">{{ o.value }}</option>
                      </select-input>
                    </div>
                  </template>
                  <template v-else-if="f.type == 'Textarea'">
                    <div :key="'in_' + i" class="col-span-full">
                      <textarea-input
                        :label="f.name"
                        :key="'in_' + i"
                        v-model="form[f.name]"
                        :errors="$page.props.errors[f.name]"
                        class="ltr:pr-6 rtl:pl-6 pb-8 w-full"
                      />
                    </div>
                  </template>
                  <template v-else-if="f.type == 'Checkbox'">
                    <div :key="'in_' + i">
                      <div class="ltr:text-left rtl:text-right ltr:pr-6 rtl:pl-6 mb-8" :key="'in_' + i">
                        <label class="form-label mr-6" :key="'in_' + i">{{ f.name }}</label>
                        <div class="py-2"></div>
                        <checkbox-input
                          :label="o.value"
                          class="mb-2 w-full"
                          :id="'cb_' + oi + '_' + i"
                          :key="'cb_' + oi + '_' + i"
                          v-for="(o, oi) in f.options"
                          :errors="$page.props.errors[f.name]"
                          :value="form[f.name][o.value]"
                          @input="updateFormValue($event, f.name, o.value)"
                        />
                        <!-- v-model="form[f.name][o.value]" -->
                        <div v-if="$page.props.errors[f.name] && $page.props.errors[f.name].length" class="form-error">
                          {{ $page.props.errors[f.name][0] }}
                        </div>
                      </div>
                    </div>
                  </template>
                  <template v-else-if="f.type == 'Radio'">
                    <div :key="'in_' + i">
                      <div class="ltr:text-left rtl:text-right ltr:pr-6 rtl:pl-6 mb-8" :key="'in_' + i">
                        <label class="form-label mr-6" :key="'in_' + i">{{ f.name }}</label>
                        <div class="py-2"></div>
                        <radio-input
                          :name="f.name"
                          :label="o.value"
                          :value="o.value"
                          class="mb-2 w-full mr-6"
                          :id="'r_' + oi + '_' + i"
                          :key="'r_' + oi + '_' + i"
                          v-for="(o, oi) in f.options"
                          :errors="$page.props.errors[f.name]"
                          @input="updateFormValue($event, f.name)"
                        />
                        <div v-if="$page.props.errors[f.name] && $page.props.errors[f.name].length" class="form-error">
                          {{ $page.props.errors[f.name][0] }}
                        </div>
                      </div>
                    </div>
                  </template>
                </template>
              </div>
            </div>
            <textarea-input
              high
              :resize="!modal"
              :label="$t('Description')"
              v-model="form.measurement"
              :errors="$page.props.errors?.measurement"
              class="ltr:pr-6 rtl:pl-6 pb-8 w-full"
            />
          </div>
          <div :class="modal ? 'rounded-b' : ''" class="px-8 py-4 bg-gray-100 border-t border-gray-200 flex justify-end items-center">
            <loading-button type="submit" class="btn-gray" :loading="sending" :disabled="loading || sending">
              {{ $t('create_x', { x: $tc('Measurement') }) }}
            </loading-button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script>
import debounce from 'lodash/debounce';
import TextInput from '@/Shared/TextInput.vue';
import RadioInput from '@/Shared/RadioInput.vue';
import SelectInput from '@/Shared/SelectInput.vue';
import TextareaInput from '@/Shared/TextareaInput.vue';
import CheckboxInput from '@/Shared/CheckboxInput.vue';
import LoadingButton from '@/Shared/LoadingButton.vue';
import DeleteRestoreComponent from '@/Shared/DeleteRestoreComponent.vue';

export default {
  components: { CheckboxInput, LoadingButton, RadioInput, SelectInput, TextInput, TextareaInput, DeleteRestoreComponent },
  props: {
    data: Object,
    ddData: {
      type: Object,
    },
    modal: Boolean,
    action: Function,
    iservices: Array,
    icustomers: Array,
  },
  data() {
    return {
      form: {
        name: null,
        service_id: null,
        customer_id: null,
        measurement: null,
        extra_attributes: [],
      },
      fields: null,
      services: [],
      customers: [],
      service: null,
      customer: null,
      loading: false,
      sending: false,
    };
  },
  watch: {
    ddData: function (ddData) {
      if (ddData) {
        if (ddData.name) {
          this.form.name = ddData.name;
        }
        if (ddData.service) {
          this.service = ddData.service;
          this.services.push(this.service);
          this.form.service_id = this.service.value;
          this.service.measurement_fields.map(f => {
            if (f.type == 'Checkbox') {
              this.form[f.name] = {};
              f.options.map(o => (this.form[f.name][o.value] = false));
            } else {
              this.form[f.name] = null;
            }
          });
        }
        if (ddData.customer) {
          this.customer = ddData.customer;
          this.customers = [this.customer];
          this.form.customer_id = this.customer.value;
        }
      }
    },
    customer: function (cv, ov) {
      this.form.customer_id = cv ? cv.value : null;
      if (
        !this.form.name ||
        (this.service && this.form.name == this.service.label) ||
        this.form.name == (ov ? ov.label + "'s " : '') + (this.service ? this.service.label : '')
      ) {
        this.form.name = (cv ? cv.label : '') + (this.service ? "'s " + this.service.label : '');
      }
    },
    service: function (cv, ov) {
      this.form.service_id = cv ? cv.value : null;
      if (
        !this.form.name ||
        (this.customer && this.form.name == this.customer.label) ||
        this.form.name == (this.customer ? this.customer.label + "'s " : '') + (ov ? ov.label : '')
      ) {
        this.form.name = (this.customer ? this.customer.label + "'s " : '') + (cv ? cv.label : '');
      }
      if (ov) {
        ov.measurement_fields.map(f => {
          delete this.form[f.name];
        });
      }
      if (cv) {
        cv.measurement_fields.map(f => {
          if (f.type == 'Checkbox') {
            this.form[f.name] = {};
            f.options.map(o => (this.form[f.name][o.value] = false));
          } else {
            this.form[f.name] = null;
          }
        });
      }
    },
  },
  created() {
    this.services = this.iservices;
    this.customers = this.icustomers;
    if (this.data) {
      this.form = this.data;
    }
    if (this.ddData) {
      if (this.ddData.name) {
        this.form.name = this.ddData.name;
      }
      if (this.ddData.service) {
        this.service = this.ddData.service;
        this.services.push(this.service);
        this.form.service_id = this.service.value;
        this.service.measurement_fields.map(f => {
          if (f.type == 'Checkbox') {
            this.form[f.name] = {};
            f.options.map(o => (this.form[f.name][o.value] = false));
          } else {
            this.form[f.name] = null;
          }
        });
      }
      if (this.ddData.customer) {
        this.customer = this.ddData.customer;
        this.customers = [this.customer];
        this.form.customer_id = this.customer.value;
      }
    }
  },
  methods: {
    submit() {
      this.sending = true;
      let data = { ...this.form };
      if (this.service && this.service.measurement_fields && this.service.measurement_fields.length > 0) {
        let extra = [];
        let extras = this.service.measurement_fields.map((f, i) => {
          delete data[f.name];
          let field = {};
          field[f.name] = f.type == 'Checkbox' ? JSON.stringify(this.form[f.name]) : this.form[f.name];
          extra[i] = { ...field };
        });
        data.extra_attributes = [...extra];
      }

      if (this.modal) {
        data.ajax = true;
        this.$axios
          .post(this.route('measurements.store'), data)
          .then(res => {
            this.sending = false;
            this.action(res.data);
            this.errors = {};
            this.$emit('close');
            // this.$page.props.flash.error = null;
            // this.$page.props.flash.success = res.data.message;
          })
          .catch(err => {
            this.sending = false;
            if (err.response.data.errors) {
              this.errors = err.response.data.errors;
            }
          });
      } else {
        this.$inertia.post(this.route('measurements.store'), data, {
          onFinish: () => (this.sending = false),
        });
      }
    },
    updateFormValue(v, f, o) {
      if (o) {
        this.form[f][o] = v;
      } else {
        this.form[f] = v;
      }
    },
    searchCustomers(search, loading) {
      if (search) {
        loading(true);
        this.searchingCustomers(loading, search, this);
      }
    },
    searchingCustomers: debounce((loading, search, vm) => {
      fetch(vm.route('ajax.customers') + '?search=' + escape(search)).then(res => {
        res.json().then(data => (vm.customers = data));
        loading(false);
      });
    }, 350),
    searchServices(search, loading) {
      if (search) {
        loading(true);
        this.searchingServices(loading, search, this);
      }
    },
    searchingServices: debounce((loading, search, vm) => {
      fetch(vm.route('ajax.services') + '?with_fields=1&search=' + escape(search)).then(res => {
        res.json().then(data => (vm.services = data));
        loading(false);
      });
    }, 350),
  },
};
</script>
