// import { nextTick } from 'vue';
import { createI18n } from 'vue-i18n';
import languages from '@lang/languages.json';

export const allLanguages = languages;
export const SUPPORT_LOCALES = languages.available.map(l => l.value);

// const i18n = createI18n(global_options);
// export default i18n;

export function setupI18n(options) {
  const i18n = createI18n(options);
  setI18nLanguage(i18n, options.locale);
  return i18n;
}

export function setI18nLanguage(i18n, locale) {
  if (i18n.mode === 'legacy') {
    i18n.global.locale = locale;
  } else {
    i18n.global.locale.value = locale;
  }

  // axios.defaults.headers.common['Accept-Language'] = locale;
  document.querySelector('html').setAttribute('lang', locale);
}

// export async function loadLocaleMessages(i18n, locale) {
//   const messages = await import(`../../../lang/${locale}.json`);
//   i18n.global.setLocaleMessage(locale, messages.default);
//   return nextTick();
// }
