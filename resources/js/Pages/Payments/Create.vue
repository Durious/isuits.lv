<template>
  <div>
    <h1 class="mb-6 mt-2 font-bold text-lg md:text-2xl">
      <Link class="text-gray-600 hover:text-gray-800 inline-flex items-center" :href="route('payments')">
        <Icons name="back" class="flex-shrink-0 w-3 h-3 md:w-5 md:h-5 fill-current ltr:mr-2 rtl:ml-2 rtl:rotate" /> {{ $tc('Payment', 2) }}
      </Link>
      <span class="text-gray-400 font-medium mx-2">/</span> {{ $t('Create') }}
    </h1>
    <div class="bg-white rounded shadow overflow-hidden max-w-3xl">
      <p-form :modal="false" :icustomers="icustomers" />
    </div>
  </div>
</template>

<script>
import Layout from '@/Shared/Layout.vue';
import PForm from '@/Pages/Payments/Form.vue';

export default {
  layout: Layout,
  components: { PForm },
  props: { icustomers: Array },
  metaInfo() {
    return { title: this.$t('create_x', { x: this.$tc('Payment') }) };
  },
};
</script>
