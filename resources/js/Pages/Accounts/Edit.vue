<template>
  <div>
    <h1 class="mb-6 mt-2 font-bold text-lg md:text-2xl">{{ $t('settings') }}</h1>
    <div class="np mb-6 flex items-center">
      <Button 
        type="button" 
        :active="currentTab === 'main'" 
        @click="changeTab('main')"
      >
        {{ $t('main_setting') }}
      </Button>
      <Button 
        type="button" 
        :active="currentTab === 'frontend'" 
        class="ml-3" 
        @click="changeTab('frontend')"
      >
        {{ $t('frontend') }} {{ $t('Setting') }}
      </Button>
      <Button 
        type="button" 
        :active="currentTab === 'order_status'" 
        class="ml-3" 
        @click="changeTab('order_status')"
      >
        {{ $t('order_status_setting') }}
      </Button>
      <Button 
        type="button" 
        :active="currentTab === 'language_setting'" 
        class="ml-3" 
        @click="changeTab('language_setting')"
      >
        {{ $t('Language')}} {{ $t('Setting') }}
      </Button>
    </div>
    <SettingMain :taxes="taxes" :account="account" :timezones="timezones" v-if="currentTab === 'main'" />
    <SettingFrontend :frontend_setting="frontend_setting" v-if="currentTab === 'frontend'" />
    <SettingOrderStatus :order_statuses="account.order_statuses ?? ''" v-if="currentTab === 'order_status'" />
    <SettingLanguage :order_statuses="account.order_statuses ?? ''" v-if="currentTab === 'language_setting'" />
  </div>
</template>

<script>
import Layout from '@/Shared/Layout.vue';
import Button from '@/Jetstream/Button.vue';
import SettingMain from '@/Pages/Accounts/SettingMain.vue';
import SettingFrontend from '@/Pages/Accounts/SettingFrontend.vue';
import SettingOrderStatus from '@/Pages/Accounts/SettingOrderStatus.vue';
import SettingLanguage from '@/Pages/Accounts/SettingLanguage.vue';

export default {
  layout: Layout,
  remember: 'form',
  props: {
    taxes: Array,
    account: Object,
    timezones: Array,
    frontend_setting: Object
  },
  data() {
    return {
      currentTab: "main"
    }
  },
  components: { SettingMain, SettingFrontend, SettingOrderStatus, SettingLanguage, Button },
  metaInfo() {
    return {
      title: this.$tc('Setting', 2),
    };
  },
  methods: {
    changeTab(tab) {
      this.currentTab = tab
    }
  }
};
</script>
