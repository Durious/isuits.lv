<template>
  <div>
    <h1 class="mb-6 mt-2 font-bold text-lg md:text-2xl">
      <Link class="text-gray-600 hover:text-gray-800 inline-flex items-center" :href="route('measurement_fields')">
        <Icons name="back" class="flex-shrink-0 w-3 h-3 md:w-5 md:h-5 fill-current ltr:mr-2 rtl:ml-2 rtl:rotate" />
        {{ $tc('Measurement Field', 2) }}
      </Link>
      <span class="text-gray-400 font-medium mx-2">/</span>
      {{ form.name }}
    </h1>
    <trashed-message v-if="field.deleted_at" class="mb-6" @restore="() => (restore = true)">
      <span>{{ $t('already_deleted_x', { x: $tc('Measurement Field') }) }}</span>
    </trashed-message>
    <div class="bg-white rounded shadow overflow-hidden max-w-3xl">
      <form @submit.prevent="submit" autocomplete="off">
        <div class="p-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap">
          <text-input
            v-model="form.name"
            :errors="$page.props.errors?.name"
            class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"
            :label="$t('Name')"
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
              transition=""
              input-id="type"
              :options="types"
              :filterable="false"
              :searchable="false"
              v-model="form.type"
              :dir="$page.props.user.account.direction"
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
              class="ltr:pr-6 rtl:pl-6 pb-8 w-full"
              :errors="$page.props.errors['options.' + i + '.value']"
            />
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
            :label="$t('Description')"
            v-model="form.description"
            class="ltr:pr-6 rtl:pl-6 pb-8 w-full"
            :errors="$page.props.errors?.description"
          />
          {{ form.required }}
          <checkbox-input
            class="mb-8"
            id="required"
            :checked="form.required"
            v-model:checked="form.required"
            :label="$t('This field is required')"
          ></checkbox-input>
        </div>

        <div class="px-8 py-4 bg-gray-100 border-t border-gray-200 flex items-center">
          <DeleteRestoreComponent
            :restore="restore"
            :data="field"
            model="Measurement Field"
            routeM="measurement_fields"
            @close-restore="() => (restore = false)"
          />
          <loading-button type="submit" :loading="sending" class="btn-gray ltr:ml-auto rtl:mr-auto">
            {{ $t('update_x', { x: $tc('Measurement Field') }) }}
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
import CheckboxInput from '@/Shared/CheckboxInput.vue';
import LoadingButton from '@/Shared/LoadingButton.vue';
import TextareaInput from '@/Shared/TextareaInput.vue';
import TrashedMessage from '@/Shared/TrashedMessage.vue';
import DeleteRestoreComponent from '@/Shared/DeleteRestoreComponent.vue';

export default {
  layout: Layout,
  remember: 'form',
  props: { field: Object, iservices: Array },
  mixins: [DeleteMixin('measurement_field', 'field')],
  components: {
    CheckboxInput,
    LoadingButton,
    TextInput,
    TextareaInput,
    TrashedMessage,
    DeleteRestoreComponent,
  },
  metaInfo() {
    return {
      title: this.$t('edit_x', { x: this.form.name }),
    };
  },
  data() {
    return {
      form: {
        name: this.field.name,
        type: this.field.type,
        order: this.field.order,
        options: this.field.options,
        services: this.field.services,
        description: this.field.description,
        required: this.field.required == 1 ? true : false,
      },
      services: [],
      restore: false,
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
      if (!data.options[data.options.length - 1].value) {
        data.options.pop();
      }
      this.$inertia.put(this.route('measurement_fields.update', this.field.id), data, {
        onFinish: () => (this.sending = false),
      });
    },
    checkOptions(i) {
      const ol = this.form.options.length;
      if (i == ol) {
        this.form.options.push({ value: '' });
      }
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
