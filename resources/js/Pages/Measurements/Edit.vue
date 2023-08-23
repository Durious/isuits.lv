<template>
  <div>
    <h1 class="mb-6 mt-2 font-bold text-lg md:text-2xl">
      <Link class="text-gray-600 hover:text-gray-800 inline-flex items-center" :href="route('measurements')">
        <Icons name="back" class="flex-shrink-0 w-3 h-3 md:w-5 md:h-5 fill-current ltr:mr-2 rtl:ml-2 rtl:rotate" />
        {{ $tc('Measurement', 2) }}
      </Link>
      <span class="text-gray-400 font-medium mx-2">/</span>
      {{ form.name }}
    </h1>
    <trashed-message v-if="measurement.deleted_at" class="mb-6" @restore="() => (restore = true)">
      {{ $t('already_deleted_x', { x: $tc('Measurement') }) }}
    </trashed-message>
    <div class="bg-white rounded shadow overflow-hidden max-w-3xl">
      <form @submit.prevent="submit" autocomplete="off">
        <div class="p-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap">
          <text-input
            v-model="form.name"
            :errors="$page.props.errors?.name"
            class="ltr:pr-6 rtl:pl-6 pb-8 w-full"
            :label="$t('Type Name')"
          />
        </div>
        <div class="px-8 pb-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap">
          <div class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2">
            <label class="form-label" for="customer_id">{{ $tc('Customer') }}</label>
            <v-select
              transition=""
              v-model="customer"
              :options="customers"
              input-id="customer_id"
              @search="searchCustomers"
              :dir="$page.props.user.account.direction"
              :placeholder="$t('search_x', { x: $tc('Customer', 2) })"
              :class="{ error: $page.props.errors?.customer_id && $page.props.errors?.customer_id.length }"
            ></v-select>
            <div v-if="$page.props.errors?.customer_id" class="form-error">{{ $page.props.errors?.customer_id[0] }}</div>
          </div>
          <div class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2">
            <label class="form-label" for="service_id">{{ $tc('Service') }}</label>
            <v-select
              transition=""
              v-model="service"
              :options="services"
              input-id="service_id"
              @search="searchServices"
              :dir="$page.props.user.account.direction"
              :placeholder="$t('search_x', { x: $tc('Service', 2) })"
              :class="{ error: $page.props.errors?.service_id && $page.props.errors?.service_id.length }"
            ></v-select>
            <div v-if="$page.props.errors?.service_id" class="form-error">{{ $page.props.errors?.service_id[0] }}</div>
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
                        :value="form[f.name][o.value]"
                        :errors="$page.props.errors[f.name]"
                        :checked="form[f.name][o.value] == true"
                        @update:checked="updateFormValue($event, f.name, o.value)"
                      />
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
                        :checked="o.value == form[f.name]"
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
            :label="$t('Description')"
            v-model="form.measurement"
            :errors="$page.props.errors?.measurement"
            class="ltr:pr-6 rtl:pl-6 pb-8 w-full"
          />
        </div>
        <div class="px-8 py-4 bg-gray-100 border-t border-gray-200 flex items-center">
          <DeleteRestoreComponent
            :restore="restore"
            :data="measurement"
            model="Measurement"
            routeM="measurements"
            @close-restore="() => (restore = false)"
          />
          <loading-button :loading="sending" class="btn-gray ltr:ml-auto rtl:mr-auto" type="submit"
            >{{ $t('update_x', { x: $tc('Measurement') }) }}
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
import DeleteMixin from '@/Misc/DeleteMixin';
import RadioInput from '@/Shared/RadioInput.vue';
import SelectInput from '@/Shared/SelectInput.vue';
import CheckboxInput from '@/Shared/CheckboxInput.vue';
import TextareaInput from '@/Shared/TextareaInput.vue';
import LoadingButton from '@/Shared/LoadingButton.vue';
import TrashedMessage from '@/Shared/TrashedMessage.vue';
import DeleteRestoreComponent from '@/Shared/DeleteRestoreComponent.vue';

export default {
  layout: Layout,
  remember: 'form',
  mixins: [DeleteMixin('measurement')],
  props: { measurement: Object, iservices: Array },
  components: { CheckboxInput, LoadingButton, RadioInput, SelectInput, TextInput, TextareaInput, TrashedMessage, DeleteRestoreComponent },
  metaInfo() {
    return {
      title: this.$t('edit_x', { x: this.form.name }),
    };
  },
  data() {
    return {
      restore: false,
      sending: false,
      form: {
        name: this.measurement.name,
        service_id: this.measurement.service.id,
        customer_id: this.measurement.customer.id,
        measurement: this.measurement.measurement,
      },
      service: {
        value: this.measurement.service.id,
        label: this.measurement.service.name,
        measurement_fields: this.measurement.service.measurement_fields,
      },
      customer: { label: this.measurement.customer.name, value: this.measurement.customer.id },
      services: [],
      customers: [],
    };
  },
  watch: {
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
    this.service.measurement_fields.map((f, i) => {
      if (this.measurement.extra_attributes && this.measurement.extra_attributes.length) {
        let ef_value = this.measurement.extra_attributes.find(ef => Object.keys(ef)[0] == f.name);
        if (f.type == 'Checkbox') {
          if (ef_value) {
            this.form[f.name] = JSON.parse(ef_value[f.name]);
          } else {
            this.form[f.name] = {};
            f.options.map(o => (this.form[f.name][o.value] = false));
          }
        } else {
          this.form[f.name] = ef_value ? ef_value[f.name] + '' : '';
        }
      } else {
        if (f.type == 'Checkbox') {
          this.form[f.name] = {};
          f.options.map(o => (this.form[f.name][o.value] = false));
        } else {
          this.form[f.name] = null;
        }
      }
    });
    // for (let [key, value] of Object.entries(this.measurement.extra_attributes)) {
    //   this.form[key] = value + '';
    // }
  },
  mounted() {
    this.customers = [this.customer];
    this.services = [...this.iservices, this.service];
  },
  methods: {
    submit() {
      this.sending = true;
      let data = { ...this.form };
      if (this.service.measurement_fields && this.service.measurement_fields.length > 0) {
        let extra = [];
        let extras = this.service.measurement_fields.map((f, i) => {
          delete data[f.name];
          let field = {};
          field[f.name] = f.type == 'Checkbox' ? JSON.stringify(this.form[f.name]) : this.form[f.name];
          extra[i] = { ...field };
        });
        data.extra_attributes = [...extra];
      }
      this.$inertia.put(this.route('measurements.update', this.measurement.id), data, {
        onFinish: () => (this.sending = false),
      });
    },
    updateFormValue(e, f, o) {
      if (o) {
        this.form[f][o] = e ? true : false;
      } else {
        this.form[f] = e && e.target && e.target.value ? e.target.value : e;
      }
    },
    searchCustomers(search, loading) {
      if (search) {
        loading(true);
        this.searchingCustomers(loading, search, this);
      }
    },
    searchingCustomers: debounce((loading, search, vm) => {
      fetch(vm.route('ajax.customers') + '?search=' + search).then(res => {
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
      fetch(vm.route('ajax.services') + '?with_fields=1&search=' + search).then(res => {
        res.json().then(data => (vm.services = data));
        loading(false);
      });
    }, 350),
  },
};
</script>
