<template>
  <title>Isuits - Admin</title>
  <div class="w-full">
    <Head :title="title" />
    <!-- <portal-target name="dropdown" slim /> -->
    <div class="flex flex-col">
      <div class="h-screen flex flex-col" @click="hideDropdownMenus">
        <div class="md:flex np" style="min-height: 56px">
          <div class="titlebar bg-gray-900 md:flex-shrink-0 md:w-64 px-4 py-3 flex items-center justify-center md:justify-start">
            <Link :href="route('dashboard')">
              <div class="h-8 text-white fill-white text-lg py-1 flex items-center">
                <Icons name="logo" class="w-6 h-6 ltr:mr-2 rtl:ml-2 fill-gray-300 group-hover:text-white fill-white" />
                <span class="hidden md:inline-block font-extrabold">{{ $page.props.app_name }}</span>
                <span class="inline-block md:hidden font-extrabold">{{ $page.props.app_name | short_form }}</span>
              </div>
            </Link>
            <div class="flex items-center md:hidden ltr:ml-auto rtl:mr-auto">
              <dropdown class="mt-1 ltr:mr-4 rtl:ml-4" placement="bottom-end">
                <div class="flex items-center cursor-pointer select-none group">
                  <div
                    class="inline-flex items-center text-gray-700 group-hover:text-gray-600 focus:text-gray-600 ltr:mr-1 rtl:ml-1 whitespace-no-wrap"
                  >
                    <span
                      class="w-6 h-5 inline-block"
                      v-html="
                        $languages
                          .find(l => l.value == $page.props.language)
                          .flag.replace(/./g, char => String.fromCodePoint(char.charCodeAt(0) + 127397))
                      "
                    />
                  </div>
                </div>
                <template v-slot:dropdown>
                  <div class="mt-3 py-4 pl-0 pr-0 md:pr-4 shadow-lg bg-gray-800 rounded text-sm">
                    <button
                      :key="lang.value"
                      v-for="lang in $languages"
                      @click="changeLocale(lang.value)"
                      :class="{ 'bg-gray-900': $page.props.language == lang.value }"
                      class="block w-full text-left px-6 py-3 text-white fill-white hover:bg-gray-900 hover:text-white fill-white"
                    >
                      <span
                        class="w-6 h-5 ltr:mr-2 rtl:ml-2"
                        v-html="lang.flag.replace(/./g, char => String.fromCodePoint(char.charCodeAt(0) + 127397))"
                      />
                      {{ lang.label }}
                    </button>
                  </div>
                </template>
              </dropdown>
              <dropdown placement="bottom-end" class="ltr:mr-4 rtl:ml-4">
                <Icons name="bars" class="text-white fill-white w-4 h-4 m-1 sm:m-2" />
                <template v-slot:dropdown>
                  <div class="mt-3 py-4 pl-0 pr-0 md:pr-4 shadow-lg bg-gray-800 rounded text-sm">
                    <main-menu :url="url()" :mobile="true" />
                  </div>
                </template>
              </dropdown>
              <dropdown placement="bottom-end" class="ltr:mr-4 rtl:ml-4">
                <Icons name="add" class="text-white fill-white w-4 h-4 m-1 sm:m-2" />
                <template v-slot:dropdown>
                  <div class="mt-3 py-2 shadow-lg bg-gray-800 rounded text-sm">
                    <create-menu :url="url()" />
                  </div>
                </template>
              </dropdown>
              <dropdown placement="bottom-end" class="ltr:mr-2 rtl:ml-2">
                <Icons name="users" className="text-white fill-white w-5 h-5 m-1 sm:m-2" />
                <template v-slot:dropdown>
                  <div class="mt-3 py-2 shadow-lg bg-gray-800 rounded text-sm">
                    <user-menu :url="url()" />
                  </div>
                </template>
              </dropdown>
            </div>
          </div>
          <div class="hidden titlebar bg-white border-b w-full p-4 md:py-0 md:px-6 text-sm md:text-md md:flex justify-between items-center">
            <div>
              <span class="hidden lg:inline mt-1 ltr:mr-4 rtl:ml-4 font-extrabold">{{ $user.account?.name }}</span>
              <dropdown class="mt-1 ltr:mr-4 rtl:ml-4" placement="bottom-start">
                <div class="flex items-center cursor-pointer select-none group">
                  <div
                    class="inline-flex items-center text-gray-700 group-hover:text-gray-600 focus:text-gray-600 ltr:mr-1 rtl:ml-1 whitespace-no-wrap"
                  >
                    <span
                      class="w-6 h-5 inline-block ltr:mr-2 rtl:ml-2"
                      v-html="
                        $languages
                          .find(l => l.value == $page.props.language)
                          .flag.replace(/./g, char => String.fromCodePoint(char.charCodeAt(0) + 127397))
                      "
                    />
                  </div>
                </div>
                <template v-slot:dropdown>
                  <div class="mt-4 py-2 shadow-lg bg-gray-800 rounded text-sm">
                    <button
                      :key="lang.value"
                      v-for="lang in $languages"
                      @click="changeLocale(lang.value)"
                      :class="{ 'bg-gray-900': $page.props.language == lang.value }"
                      class="block w-full text-left px-6 py-3 text-white fill-white hover:bg-gray-900 hover:text-white fill-white"
                    >
                      <span
                        class="w-6 h-5 ltr:mr-2 rtl:ml-2"
                        v-html="lang.flag.replace(/./g, char => String.fromCodePoint(char.charCodeAt(0) + 127397))"
                      />
                      {{ lang.label }}
                    </button>
                  </div>
                </template>
              </dropdown>
              <dropdown class="mt-1 ltr:mr-4 rtl:ml-4" placement="bottom-start">
                <div class="flex items-center cursor-pointer select-none group">
                  <div
                    class="inline-flex items-center text-gray-700 group-hover:text-gray-600 focus:text-gray-600 ltr:mr-1 rtl:ml-1 whitespace-no-wrap"
                  >
                    <Icons name="add" class="fill-current w-3 h-3 ltr:mr-2 rtl:ml-2" />
                    <span>{{ $t('Add') }}</span>
                  </div>
                  <Icons class="w-5 h-5 group-hover:fill-gray-600 fill-gray-700 focus:fill-gray-600" name="cheveron-down" />
                </div>
                <template v-slot:dropdown>
                  <div class="mt-4 py-2 shadow-lg bg-gray-800 rounded text-sm">
                    <create-menu :url="url()" />
                  </div>
                </template>
              </dropdown>
            </div>
            <div class="flex items-center gap-3">
              <button @click="print()" class="hover:bg-gray-200 rounded-full">
                <Icons name="printer" class="fill-gray-700 w-4 h-4 m-1 sm:m-2" />
              </button>
              <dropdown class="mt-1" placement="bottom-end">
                <div class="flex items-center cursor-pointer select-none group">
                  <div
                    class="inline-flex items-center text-gray-700 group-hover:text-gray-600 focus:text-gray-600 ltr:mr-1 rtl:ml-1 whitespace-no-wrap"
                  >
                    <img v-if="$user.photo" class="block w-5 h-5 rounded-full ltr:mr-2 rtl:ml-2 -my-2" :src="'/storage/' + $user.photo" />
                    <span>{{ $user.name }}</span>
                  </div>
                  <Icons class="w-5 h-5 group-hover:fill-gray-600 fill-gray-700 focus:fill-gray-600" name="cheveron-down" />
                </div>
                <template v-slot:dropdown>
                  <div class="mt-4 py-2 shadow-xl bg-gray-800 rounded text-sm">
                    <user-menu :url="url()" />
                  </div>
                </template>
              </dropdown>
            </div>
          </div>
        </div>
        <div class="main flex flex-grow overflow-hidden">
          <main-menu :url="url()" class="np bg-gradient-gray flex-shrink-0 w-64 p-4 hidden md:block overflow-y-auto scroll-on-dark" />
          <div class="flex-1 overflow-hidden p-4 md:p-6 overflow-y-auto main-scroll" id="page-contents" scroll-region>
            <flash-messages class="np" />
            <div class="print pb-20 md:pb-6">
              <transition mode="out-in" name="slide-fade" appear>
                <slot />
              </transition>
            </div>
          </div>
        </div>
      </div>
    </div>
    <mobile-menu :url="url()" class="np z-20 fixed bottom-0 w-full px-2"></mobile-menu>
    <v-dialog />
    <loading v-if="loading" class="z-10" />
  </div>
</template>

<script>
import Logo from '@/Shared/Logo.vue';
import Filters from '@/Misc/Filters';
import Dropdown from '@/Shared/Dropdown.vue';
import MainMenu from '@/Shared/MainMenu.vue';
import UserMenu from '@/Shared/UserMenu.vue';
import CreateMenu from '@/Shared/CreateMenu.vue';
import MobileMenu from '@/Shared/MobileMenu.vue';
import FlashMessages from '@/Shared/FlashMessages.vue';

export default {
  props: ['title'],
  components: { Dropdown, FlashMessages, Logo, MainMenu, MobileMenu, CreateMenu, UserMenu },
  data() {
    return {
      accounts: null,
      language: null,
      loading: false,
      showUserMenu: false,
    };
  },
  created() {
    // this.$event.listen('loading', loading => (this.loading = loading));
  },
  mounted() {
    // this.language = localStorage.getItem('language');
    // if (!this.language) {
    //   this.language = this.$user.account.language || 'en';
    //   localStorage.setItem('language', this.language);
    // }
    // this.$i18n.locale = this.language;
    // let lang = this.$languages[this.language];
    // lang.lang = this.language;
    // this.$root.$data.setLang(lang);
    // if (localStorage.getItem('language') && this.language != this.$user.account.language) {
    //   this.$axios.get('/language/' + this.language).then();
    // }

    this.$nextTick(() => {
      if (window) {
        document.body.dir = this.$user.account.direction;
        // document.body.setAttribute('dir', this.$user.account.direction);
      }
    });
  },
  methods: {
    ...Filters,
    print() {
      window.print();
    },
    changeLocale(locale) {
      this.$i18n.locale = locale;
      this.$page.props.language = locale;
      localStorage.setItem('language', locale);
      this.$inertia.get(route('language', { locale }), {
        onSuccess: async () => {},
      });
    },
    url() {
      return location.pathname.substr(1);
    },
    hideDropdownMenus() {
      this.showUserMenu = false;
    },
  },
};
</script>
