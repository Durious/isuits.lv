<template>
  <div>
    <h1 class="mb-6 mt-2 font-bold text-lg md:text-2xl">
      <Link class="text-gray-600 hover:text-gray-800 inline-flex items-center" :href="route('salaries')">
        <Icons name="back" class="flex-shrink-0 w-3 h-3 md:w-5 md:h-5 fill-current ltr:mr-2 rtl:ml-2 rtl:rotate" /> {{ $t('Salaries') }}
      </Link>
      <span class="text-gray-400 font-medium mx-2">/</span>
      {{ salary.staff.name }}
    </h1>
    <trashed-message v-if="salary.deleted_at" class="mb-6" @restore="() => (restore = true)">
      {{ $t('This salary has been deleted.') }}
    </trashed-message>
    <div class="transition-all bg-white rounded shadow overflow-hidden max-w-3xl">
      <form @submit.prevent="submit" autocomplete="off">
        <div class="p-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap">
          <text-input
            type="date"
            :label="$t('Date')"
            v-model="form.date"
            pattern="\d{4}-\d{2}-\d{2}"
            :errors="$page.props.errors?.date"
            class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"
          />
          <text-input
            v-model="form.amount"
            type="number"
            :errors="$page.props.errors?.amount"
            class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-1/2"
            :label="$t('Amount')"
          />
        </div>
        <div class="px-8 pb-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap">
          <div class="ltr:pr-6 rtl:pl-6 pb-8 w-full">
            <label class="form-label" for="staff_id">{{ $t('Staff') }}</label>
            <v-select
              :dir="$page.props.user.account.direction"
              transition=""
              :value="staff"
              input-id="staff_id"
              @input="staffChanged"
              @search="searchStaff"
              :options="staff_members"
              placeholder="Search Staff"
              @option:selected="staffChanged"
              :class="{ error: $page.props.errors?.staff_id && $page.props.errors?.staff_id.length }"
            ></v-select>
            <div v-if="$page.props.errors?.staff_id" class="form-error">{{ $page.props.errors?.staff_id[0] }}</div>
          </div>
          <text-input
            v-model="form.description"
            :errors="$page.props.errors?.description"
            class="ltr:pr-6 rtl:pl-6 pb-8 w-full"
            :label="$t('Description')"
          />
        </div>
        <div class="transition-all px-8 pb-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0">
          <checkbox-input
            id="advance"
            v-model:checked="form.advance"
            :checked="form.advance"
            label="Advance payment (if not settled then deduct from next salary)"
          ></checkbox-input>
          <transition mode="out-in" name="slide-fade" appear>
            <text-input
              type="date"
              v-if="form.advance"
              :label="$t('Settled on')"
              v-model="form.settled_on"
              pattern="\d{4}-\d{2}-\d{2}"
              class="ltr:pr-6 rtl:pl-6 pt-8 w-full"
              :errors="$page.props.errors?.settled_on"
            />
          </transition>
        </div>
        <div class="px-8 py-4 bg-gray-100 border-t border-gray-200 flex items-center">
          <DeleteRestoreComponent
            :restore="restore"
            :data="salary"
            model="Salary"
            routeM="salaries"
            @close-restore="() => (restore = false)"
          />
          <loading-button :loading="sending" class="btn-gray ltr:ml-auto rtl:mr-auto" type="submit">{{
            $t('Update Salary')
          }}</loading-button>
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
import TrashedMessage from '@/Shared/TrashedMessage.vue';
import DeleteRestoreComponent from '@/Shared/DeleteRestoreComponent.vue';

export default {
  metaInfo() {
    return {
      title: this.salary.staff.name,
    };
  },
  layout: Layout,
  components: { LoadingButton, TextInput, TrashedMessage, CheckboxInput, DeleteRestoreComponent },
  props: {
    salary: Object,
    members: Array,
  },
  remember: 'form',
  data() {
    return {
      restore: false,
      sending: false,
      form: {
        date: this.salary.date,
        amount: this.salary.amount,
        staff_id: this.salary.staff.id,
        settled_on: this.salary.settled_on,
        description: this.salary.description,
        advance: this.salary.advance ? true : false,
      },
      staff: { label: this.salary.staff.name, value: this.salary.staff.id },
      staff_members: [],
    };
  },
  mounted() {
    this.staff_members = this.members.map(m => ({
      value: m.value,
      label: m.label + (m.salary ? ' (' + parseFloat(m.salary).toFixed(2) + ')' : ''),
    }));
    this.staff_members.push(this.staff);
  },
  methods: {
    staffChanged(s) {
      this.staff = s ? s : null;
      this.form.staff_id = s ? s.value : null;
    },
    submit() {
      this.sending = true;
      this.$inertia.put(this.route('salaries.update', this.salary.id), this.form, {
        onFinish: () => (this.sending = false),
      });
    },
    destroy() {
      this.$modal.show('dialog', {
        title: 'Delete Salary!',
        text: 'Are you sure you want to delete this salary?',
        buttons: [
          {
            title: 'Yes',
            handler: () => {
              this.$modal.hide('dialog');
              this.$inertia.delete(this.route('salaries.destroy', this.salary.id));
            },
          },
          {
            title: 'No',
          },
        ],
      });
      // if (confirm('Are you sure you want to delete this salary?')) {
      //   this.$inertia.delete(this.route('salaries.destroy', this.salary.id));
      // }
    },
    destroyPermanently() {
      this.$modal.show('dialog', {
        title: 'Delete Permanently!',
        text: 'Are you sure you want to permanently delete this salary?',
        buttons: [
          {
            title: 'Yes',
            class: 'px-6 py-3 bg-gray-200 hover:bg-gray-400',
            handler: () => {
              this.$modal.hide('dialog');
              this.$inertia.delete(this.route('salaries.delete', this.salary.id));
            },
          },
          {
            title: 'No',
            class: 'px-6 py-3 border-l bg-gray-200 hover:bg-gray-400',
          },
        ],
      });
    },
    restore() {
      this.$modal.show('dialog', {
        title: 'Restore Salary!',
        text: 'Are you sure you want to restore this salary?',
        buttons: [
          {
            title: 'Yes',
            class: 'px-6 py-3 bg-gray-200 hover:bg-gray-400',
            handler: () => {
              this.$modal.hide('dialog');
              this.$inertia.put(this.route('salaries.restore', this.salary.id));
            },
          },
          {
            title: 'No',
            class: 'px-6 py-3 border-l bg-gray-200 hover:bg-gray-400',
          },
        ],
      });
      // if (confirm('Are you sure you want to restore this salary?')) {
      //   this.$inertia.put(this.route('salaries.restore', this.salary.id));
      // }
    },
    searchStaff(search, loading) {
      if (search) {
        loading(true);
        this.searchingStaff(loading, search, this);
      }
    },
    searchingStaff: debounce((loading, search, vm) => {
      fetch(vm.route('ajax.staff') + '?search=' + escape(search)).then(res => {
        res.json().then(
          data =>
            (vm.staff_members = data.map(m => ({
              value: m.value,
              label: m.label + (m.salary ? ' (' + parseFloat(m.salary).toFixed(2) + ')' : ''),
            })))
        );
        loading(false);
      });
    }, 350),
  },
};
</script>
