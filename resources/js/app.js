import './bootstrap';
import '../css/app.css';
import axios from 'axios';
import vSelect from 'vue-select';
import { createApp, h } from 'vue';
import 'vue-select/dist/vue-select.css';
import { InertiaProgress } from '@inertiajs/progress';
import { ZiggyVue } from '../../vendor/tightenco/ziggy/dist/vue.m';
import { createInertiaApp, Head, Link } from '@inertiajs/inertia-vue3';
import { resolvePageComponent } from 'laravel-vite-plugin/inertia-helpers';

window.axios = axios;
window.i18nOptions = {
  locale: 'en',
  missingWarn: false,
  fallbackWarn: false,
  fallbackLocale: 'en',
  warnHtmlMessage: false,
  messages: {},
};

import mixin from '@/Core/mixin';
import Icons from '@/Shared/Icons.vue';
import Boolean from '@/Shared/Boolean.vue';
import Loading from '@/Shared/Loading.vue';
import { allLanguages, setupI18n } from '@/Core/i18n';
const appName = window.document.getElementsByTagName('title')[0]?.innerText || 'TSMS';

createInertiaApp({
  title: title => `${title} - ${appName}`,
  resolve: name => resolvePageComponent(`./Pages/${name}.vue`, import.meta.glob('./Pages/**/*.vue')),
  async setup({ el, app, props, plugin }) {
    for await (const lang of allLanguages.available) {
      i18nOptions.messages[lang.value] = (await import(`../../lang/${lang.value}.json`)).default;
    }
    i18nOptions.locale = window.Locale;
    const iapp = createApp({
      render: () => h(app, props),
      mounted: async () => {
        document.getElementById('app-loading').style.display = 'none';
      },
    })
      .use(plugin)
      .mixin(mixin)
      .use(ZiggyVue, Ziggy)
      .component('Head', Head)
      .component('Link', Link)
      .component('Icons', Icons)
      .component('Boolean', Boolean)
      .component('Loading', Loading)
      .use(setupI18n(i18nOptions))
      .component('v-select', vSelect);
    iapp.config.globalProperties.$axios = axios;
    iapp.config.globalProperties.$route = route;
    return iapp.mount(el);
  },
});

InertiaProgress.init({ color: '#2563EB', showSpinner: true });