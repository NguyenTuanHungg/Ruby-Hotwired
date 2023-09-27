const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
    function ({ addUtilities }) {
      addUtilities({
        '.hover-color': {
          backgroundColor: '#F3D9D9',
        },
        '.t-head-color':{
          backgroundColor:'#B5013E',
        },
        '.show-button-color':{
          backgroundColor:'#B5013E',
          boxShadow: '0px 3px 8px 0px #B5013E'
        },
        '.input-color':{
          backgroundColor:'#BDBDBD'
        },
        '.color-edit': {
          color: '#B5013E',
          borderColor: '#B5013E',

        },
        '.color-delete': {
          color: '#2F2F2F',
          borderColor: '#2F2F2F',

        },
        '.color-number': {
          backgroundColor:' #4F4B4B'

        },
        '.hover-button':{
          backgroundColor:'#B5013E',
          color:'#FFFFFF'
        },
        '.font-size':{
          fontSize:'14px'
        },
        '.font-size-button':{
          fontSize:'13px'
        }

      });
    },
  ]
}
