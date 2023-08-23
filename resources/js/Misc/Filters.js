import accounting from 'accounting';
const Filters = {
  reference: str => str.substring(12, str.length),
  capitalize: str => str.charAt(0).toUpperCase() + str.substring(1),
  short_form: str =>
    str
      .split(' ')
      .map(w => {
        return w.charAt(0).toUpperCase() + '.';
      })
      .join(''),

  formatNumber: (value = 0, locale = 'en-US', d = 2, ts = ',', ds = '.') => {
    return parseFloat(accounting.formatNumber(value, d, '', '.')).toLocaleString(locale, {
      minimumFractionDigits: d,
      maximumFractionDigits: 4,
    });
  },

  formatDecimal: (value = 0, d = 2) => accounting.formatNumber(value, d, '', '.'),

  unformatNumber: (value = 0, ds = '.') => accounting.unformat(value, ds),

  formatDate: date => {
    var d = new Date(date),
      month = '' + (d.getMonth() + 1),
      day = '' + d.getDate(),
      year = d.getFullYear();
    if (month.length < 2) month = '0' + month;
    if (day.length < 2) day = '0' + day;
    return [year, month, day].join('-');
  },

  date: (date, locale = 'en-US', style = 'medium') => {
    let formatted = new Date(Date.parse(date));
    return formatted.toLocaleDateString(locale, { dateStyle: style });
  },

  time: (date, locale = 'en-US') => {
    let formatted = new Date(Date.parse(date));
    return formatted.toLocaleTimeString(locale, { timeStyle: 'short', hour12: true });
  },

  datetime: (datetime, locale = 'en-US', style = 'medium') => {
    let formatted = new Date(Date.parse(datetime));
    return formatted.toLocaleString(locale, {
      dateStyle: style,
      timeStyle: 'short',
      hour12: true,
    });
  },

  shortNumber: (num = 0, digits = 1) => {
    var si = [
      { value: 1, symbol: '' },
      { value: 1e3, symbol: 'k' },
      { value: 1e6, symbol: 'M' },
      { value: 1e9, symbol: 'G' },
      { value: 1e12, symbol: 'T' },
      { value: 1e15, symbol: 'P' },
      { value: 1e18, symbol: 'E' },
    ];
    var i;
    var rx = /\.0+$|(\.[0-9]*[1-9])0+$/;
    for (i = si.length - 1; i > 0; i--) {
      if (num >= si[i].value) {
        break;
      }
    }
    return (num / si[i].value).toFixed(digits).replace(rx, '$1') + si[i].symbol;
  },
};

// function isSafari() {
//   var isSafari =
//     /constructor/i.test(window.HTMLElement) ||
//     (function(p) {
//       return p.toString() === '[object SafariRemoteNotification]';
//     })(!window['safari'] || (typeof safari !== 'undefined' && safari.pushNotification));
//   return isSafari;
// }

export default Filters;
