import { v4 as uuidv4 } from 'uuid';

const mixin = {
  computed: {
    $user() {
      return this.$page.props.user;
    },
    $languages() {
      return this.$page.props.languages;
    },
    $super() {
      return this.$page.props.user.roles.find(r => r.name == 'Super Admin') ? true : false;
    },
    $settings() {
      return { ...this.$page.props.settings, track_weight: this.$page.props?.settings?.track_weight == 1 };
    },
  },
  methods: {
    $uuid() {
      return uuidv4();
    },
    $capitalize(string) {
      return string ? string.charAt(0).toUpperCase() + string.slice(1) : '';
    },
    $number(amount, locale, options) {
      let formatted = parseFloat(amount);
      if (isNaN(formatted)) {
        return '';
      }
      if (!locale || (locale.length != 2 && locale.length != 5)) {
        locale =
          this.$page.props?.settings?.default_locale ||
          this.$page.props?.settings?.language ||
          this.$page.props?.order?.account.default_locale ||
          this.$page.props?.order?.account.language ||
          'en-US';
      }
      if (!options) {
        options = {
          minimumFractionDigits: this.$page.props?.settings?.fraction || this.$page.props?.order?.account?.fraction || 2,
          maximumFractionDigits: this.$page.props?.settings?.fraction || this.$page.props?.order?.account?.fraction || 2,
        };
      }
      return new Intl.NumberFormat(locale, options).format(formatted);
    },
    $reference(str) {
      return str.substring(12, str.length);
    },
    $decimals(amount, fraction = 0, locale, options) {
      let formatted = parseFloat(amount);
      if (!locale || (locale.length != 2 && locale.length != 5)) {
        locale =
          this.$page.props?.settings?.default_locale ||
          this.$page.props?.settings?.language ||
          this.$page.props?.order?.account.default_locale ||
          this.$page.props?.order?.account.language ||
          'en-US';
      }
      if (!fraction && !options) {
        options = {
          minimumFractionDigits: this.$page.props?.settings?.fraction || this.$page.props?.order?.account.fraction || 2,
          maximumFractionDigits: this.$page.props?.settings?.fraction || this.$page.props?.order?.account.fraction || 2,
        };
      }
      return Number(Number(amount).toFixed(fraction));
    },
    $currency(amount, locale, options) {
      let formatted = parseFloat(amount);
      if (!locale || (locale.length != 2 && locale.length != 5)) {
        locale = this.$page.props?.settings?.default_locale || this.$page.props?.settings?.language || 'en-US';
      }
      if (options.currency && options.currency.length != 3) {
        options.currency = this.$page.props?.settings?.currency_code || this.$page.props?.order?.account.currency_code;
      }
      if (!options) {
        options = {
          style: 'currency',
          signDisplay: 'always',
          currencyDisplay: 'symbol',
          // currencySign: 'accounting',
          currency: this.$page.props?.settings?.currency_code || this.$page.props?.order?.account.currency_code,
          minimumFractionDigits: this.$page.props?.settings?.fraction || this.$page.props?.order?.account.fraction || 2,
        };
      }
      return new Intl.NumberFormat(locale, options).format(formatted);
    },
    $parseNumber(amount, locale) {
      if (!locale || (locale.length != 2 && locale.length != 5)) {
        locale = this.$page.props?.settings?.default_locale || this.$page.props?.settings?.language || 'en-US';
      }
      var thousandSeparator = Intl.NumberFormat(locale)
        .format(11111)
        .replace(/\p{Number}/gu, '');
      var decimalSeparator = Intl.NumberFormat(locale)
        .format(1.1)
        .replace(/\p{Number}/gu, '');
      return parseFloat(amount.replace(new RegExp('\\' + thousandSeparator, 'g'), '').replace(new RegExp('\\' + decimalSeparator), '.'));
    },
    $date(date, locale, style) {
      let formatted = new Date(Date.parse(date));
      if (!locale || (locale.length != 2 && locale.length != 5)) {
        locale =
          this.$page.props?.settings?.default_locale ||
          this.$page.props?.settings?.language ||
          this.$page.props?.order?.account.default_locale ||
          this.$page.props?.order?.account.language ||
          'en-US';
      }
      return formatted.toLocaleString(locale, { dateStyle: style ? style : 'medium' });
    },
    $formatJSDate(date) {
      var d = new Date(date),
        month = '' + (d.getMonth() + 1),
        day = '' + d.getDate(),
        year = d.getFullYear();
      if (month.length < 2) month = '0' + month;
      if (day.length < 2) day = '0' + day;
      return [year, month, day].join('-');
    },
    $dateDay(date, locale) {
      let formatted = new Date(Date.parse(date));
      if (!locale || (locale.length != 2 && locale.length != 5)) {
        locale = this.$page.props?.settings?.default_locale || this.$page.props?.settings?.language || 'en-US';
      }
      return formatted.toLocaleString(locale, { day: 'numeric', weekday: 'short' });
    },
    $month(month, locale, style = 'short') {
      let formatted = new Date(Date.parse(month));
      if (!locale || (locale.length != 2 && locale.length != 5)) {
        locale = this.$page.props?.settings?.default_locale || this.$page.props?.settings?.language || 'en-US';
      }
      return formatted.toLocaleString(locale, { month: style, year: '2-digit' });
    },
    $monthName(month, locale, style = 'long') {
      let formatted = new Date(Date.parse(month));
      if (!locale || (locale.length != 2 && locale.length != 5)) {
        locale = this.$page.props?.settings?.default_locale || this.$page.props?.settings?.language || 'en-US';
      }
      return formatted.toLocaleString(locale, { month: style });
    },
    $time(date, locale, style) {
      let formatted = new Date(Date.parse(date));
      if (!locale || (locale.length != 2 && locale.length != 5)) {
        locale = this.$page.props?.settings?.default_locale || this.$page.props?.settings?.language || 'en-US';
      }
      return formatted.toLocaleString(locale, { timeStyle: 'short', hour12: true });
    },
    $datetime(datetime, locale, style) {
      let formatted = new Date(Date.parse(datetime));
      if (!locale || (locale.length != 2 && locale.length != 5)) {
        locale =
          this.$page.props?.settings?.default_locale ||
          this.$page.props?.settings?.language ||
          this.$page.props?.order?.account.default_locale ||
          this.$page.props?.order?.account.language ||
          'en-US';
      }
      return formatted.toLocaleString(locale, { dateStyle: style ? style : 'medium', timeStyle: 'short', hour12: true });
    },
    $shortNumber(num = 0, digits = 1) {
      let si = [
        { value: 1, symbol: '' },
        { value: 1e3, symbol: 'k' },
        { value: 1e6, symbol: 'M' },
        { value: 1e9, symbol: 'G' },
        { value: 1e12, symbol: 'T' },
        { value: 1e15, symbol: 'P' },
        { value: 1e18, symbol: 'E' },
      ];
      let i;
      let rx = /\.0+$|(\.[0-9]*[1-9])0+$/;
      for (i = si.length - 1; i > 0; i--) {
        if (num >= si[i].value) {
          break;
        }
      }
      return (num / si[i].value).toFixed(digits).replace(rx, '$1') + si[i].symbol;
    },
    $can(permissions) {
      if (this.$page.props.user && this.$page.props.user.roles.find(r => r.name == 'Super Admin')) {
        return true;
      }
      let allow = false;
      if (!Array.isArray(permissions)) {
        permissions = [permissions];
      }
      if (permissions && permissions.length > 0) {
        if (permissions.includes('all')) {
          allow = true;
        } else {
          permissions.map(p => {
            if (this.$page.props.user && this.$page.props.user.all_permissions && this.$page.props.user.all_permissions.includes(p)) {
              allow = true;
            }
          });
        }
      }
      return allow;
    },
    $meta(meta, noHtml = false, join = false) {
      let str = [];
      for (const [key, value] of Object.entries(meta)) {
        noHtml ? str.push(key + ': ' + value) : str.push(key + ': <strong>' + value + '</strong>');
      }
      return str.join(join ? '\n ' : ', ');
    },
  },
};

export default mixin;
