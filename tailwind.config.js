const defaultTheme = require('tailwindcss/defaultTheme');

module.exports = {
  content: ['./resources/**/*.blade.php', './resources/**/*.js', './resources/**/*.vue'],
  theme: {
    screens: {
      xs: '540px',
      sm: '640px',
      md: '768px',
      lg: '1024px',
      xl: '1280px',
    },
    extend: {
      fontFamily: {
        sans: ['Cerebri Sans', ...defaultTheme.fontFamily.sans],
      },
      boxShadow: theme => ({
        outline: '0 0 0 2px ' + theme('colors.indigo.500'),
      }),
      // fill: theme => theme('colors'),
      // minWidth: {
      //   '1/2': '50%',
      // },
      // maxWidth: {
      //   '1/4': '25%',
      //   '1/2': '50%',
      //   '3/4': '75%',
      // },
      // screens: {
      //   print: { raw: 'print' },
      // },
    },
    // gradients: theme => ({
    //   'red-to-orange': ['30deg', theme('colors.red.700'), theme('colors.orange.500')],
    //   'blue-to-purple': ['30deg', theme('colors.blue.700'), theme('colors.purple.700')],
    //   'green-to-teal': ['30deg', theme('colors.green.800'), theme('colors.teal.600')],
    //   'blue-to-teal': ['30deg', theme('colors.blue.800'), theme('colors.teal.600')],
    //   'gradient-gray': ['120deg', theme('colors.gray.800'), theme('colors.gray.800'), theme('colors.gray.700')],
    //   'month-chart': ['30deg', theme('colors.gray.700'), theme('colors.gray.900')],
    //   'year-chart': ['30deg', theme('colors.blue.700'), theme('colors.indigo.800')],

    //   'mono-circle': {
    //     type: 'radial',
    //     colors: ['circle', theme('colors.gray.200'), theme('colors.gray.400')],
    //   },
    // }),
  },
  variants: {
    // fill: ['responsive', 'hover', 'focus', 'group-hover'],
    // textColor: ['responsive', 'hover', 'focus', 'group-hover'],
    // zIndex: ['responsive', 'focus'],
    // gradients: ['responsive', 'hover'],
    // margin: ['responsive', 'direction'],
    // padding: ['responsive', 'direction'],
    // borderRadius: ['responsive', 'direction'],
    // borderWidth: ['responsive', 'direction'],
    // flexDirection: ['responsive', 'direction'],
    // textAlign: ['responsive', 'direction'],
  },
  plugins: [
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/forms'),
    require('@tailwindcss/line-clamp'),
    require('@tailwindcss/typography'),
  ],
};
