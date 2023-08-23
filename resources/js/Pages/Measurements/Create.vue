<template>
  <div>
    <h1 class="mb-6 mt-2 font-bold text-lg md:text-2xl">
      <Link class="text-gray-600 hover:text-gray-800 inline-flex items-center" :href="route('measurements')">
        <Icons name="back" class="flex-shrink-0 w-3 h-3 md:w-5 md:h-5 fill-current ltr:mr-2 rtl:ml-2 rtl:rotate" />
        {{ $tc('Measurement', 2) }}
      </Link>
      <span class="text-gray-400 font-medium mx-2">/</span> {{ $t('Create') }}
    </h1>
    <div class="bg-white rounded shadow overflow-hidden max-w-3xl">
      <m-form :modal="false" :iservices="iservices" :icustomers="icustomers" />
    </div>
  </div>
</template>

<script>
import Layout from '@/Shared/Layout.vue';
import MForm from '@/Pages/Measurements/Form.vue';

export default {
  layout: Layout,
  components: { MForm },
  props: { iservices: Array, icustomers: Array },
  metaInfo() {
    return { title: this.$t('create_x', { x: this.$tc('Measurement') }) };
  },
};
</script>
