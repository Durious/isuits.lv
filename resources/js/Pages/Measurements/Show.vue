<template>
  <div v-if="measurement && measurement.id" class="w-full ltr:text-left rtl:text-right">
    <div v-if="modal" class="np flex justify-between items-center px-6 py-4 mb-4 bg-gray-100 border-b rounded-t">
      <p class="font-bold">{{ $t('Measurement No', { x: measurement.id }) }}</p>
      <div class="flex items-center">
        <a class="modal-close mx-2 cursor-pointer text-gray-700 hover:text-gray-800" @click="editMeasurement(measurement.id)">
          <Icons name="pencil" class="h-5 w-5 fill-current" />
        </a>
        <a class="modal-close mx-2 cursor-pointer text-gray-700 hover:text-gray-800" @click="printMeasurement()">
          <Icons name="printer" class="h-5 w-5 fill-current" />
        </a>
        <a class="modal-close ml-2 cursor-pointer" @click="$emit('close')">
          <svg class="fill-current text-black" xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 18 18">
            <path
              d="M14.53 4.53l-1.06-1.06L9 7.94 4.53 3.47 3.47 4.53 7.94 9l-4.47 4.47 1.06 1.06L9 10.06l4.47 4.47 1.06-1.06L10.06 9z"
            ></path>
          </svg>
        </a>
      </div>
    </div>

    <!--Body-->
    <div class="print">
      <div class="max-w-2xl h-full py-4 px-6 leading-normal">
        <div class="flex flex-wrap xs:flex-no-wrap justify-around w-full items-start">
          <div class="text-gray-900 mx-auto xs:mx-0" style="width: 180px">
            <img :alt="$page.props.user.account.name" v-if="$page.props.user.account.logo_path" :src="$page.props.user.account.logo_path" />
            <logo v-else />
          </div>
          <div class="text-sm px-4 py-4 xs:py-0 text-center xs:text-left">
            <div class="font-extrabold">{{ measurement.account.name }}</div>
            <div class="font-bold">{{ measurement.account.phone }}</div>
            {{ measurement.account.email }}
          </div>
          <div class="text-sm">
            <div class="flex">
              <span class="text-right ltr:mr-2 rtl:ml-2" style="width: 90px">No:</span>
              <span class="font-bold">{{ measurement.id }}</span>
            </div>
            <div class="flex">
              <span class="text-right ltr:mr-2 rtl:ml-2" style="width: 90px">Date:</span>
              <span class="font-bold">
                <span class="inline-block">{{ $datetime(measurement.created_at) }}</span>
              </span>
            </div>
          </div>
        </div>

        <div v-if="notify" class="mt-6 px-4 py-3 bg-red-500 text-white fill-white rounded">
          {{ $t('This measurement does not belong to the order customer.') }}
        </div>

        <div id="customer" class="mt-6 w-full">
          <div class="px-2 py-2 border rounded-t font-bold">
            {{ $t('Customer Details') }}
          </div>

          <div class="border rounded-b border-t-0 px-2 py-2">
            <div class="flex">
              <span class="text-right ltr:mr-2 rtl:ml-2" style="min-width: 70px">{{ $t('Name') }}:</span>
              <span>
                <strong>{{ measurement.customer.name }}</strong>
              </span>
            </div>
            <div v-if="measurement.customer.address" class="flex">
              <span class="text-right ltr:mr-2 rtl:ml-2" style="min-width: 70px">{{ $t('Address') }}:</span>
              <span>{{ measurement.customer.address }}</span>
            </div>
            <div class="flex">
              <span class="text-right ltr:mr-2 rtl:ml-2" style="min-width: 70px">{{ $t('Phone') }}:</span>
              <span>{{ measurement.customer.phone }}</span>
            </div>
            <div v-if="measurement.customer.email" class="flex">
              <span class="text-right ltr:mr-2 rtl:ml-2" style="min-width: 70px">{{ $t('Email') }}:</span>
              <span>{{ measurement.customer.email }}</span>
            </div>
          </div>
        </div>

        <div v-if="measurement.extra_attributes && measurement.extra_attributes.length" class="mt-6 border rounded leading-tight">
          <div class="rounded overflow-x-auto scroll-on-light">
            <table class="table w-full all max-w-full min-w-0" v-html="displayExtra(measurement.extra_attributes)"></table>
          </div>
        </div>

        <div class="pt-6" v-if="measurement.measurement">
          <h4 class="font-bold">{{ $t('Description') }}</h4>
          <p>{{ measurement.measurement }}</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Logo from '@/Shared/Logo.vue';
import Dropdown from '@/Shared/Dropdown.vue';

export default {
  components: { Logo, Dropdown },
  props: {
    measurement: Object,
    modal: { default: true },
    notify: { type: Boolean, default: false },
  },
  metaInfo() {
    return {
      title: this.$t('Measurement Number', { x: this.measurement.id }),
    };
  },
  methods: {
    printMeasurement() {
      window.print();
    },
    editMeasurement() {
      this.$inertia.visit(this.route('measurements.edit', this.measurement.id));
      this.$emit('close');
    },
    displayExtra(attr) {
      let extra = '';
      if (Array.isArray(attr)) {
        attr.map((a, i) => {
          for (let [key, value] of Object.entries(a)) {
            extra += `</tr>`;
            if (value.includes('{') && value.includes('}') && value.includes(':')) {
              extra += `<td class="w-32 border-b px-4 py-2"><strong>${key}</strong>:</td><td class="border-b px-4 py-2">`;
              const cbv = JSON.parse(value);
              for (let [k, v] of Object.entries(cbv)) {
                if (v) {
                  extra += k + ' ';
                  //   extra += `<span class="inline-block text-green-600 ltr:mr-2 rtl:ml-2">&#10003; ${k} </span> `;
                  // } else {
                  //   extra += `<span class="inline-block text-red-500 ltr:mr-2 rtl:ml-2">&#10005; ${k},</span> `;
                }
              }
              extra += `</td>`;
            } else {
              extra += `<td class="w-32 border-b px-4 py-2"><strong>${key}</strong>:</td><td class="border-b px-4 py-2">${value}</td> `;
            }
            extra += `</tr>`;
          }
        });
      }
      return extra;
    },
  },
};
</script>
