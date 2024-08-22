/** @type {import('tailwindcss').Config} */

const plugin = require('tailwindcss/plugin')
module.exports = {
  content: [
    "./cmd/web/**/*.html", "./cmd/web/**/*.templ",
  ],
  theme: {
    extend: {
      colors: {
        background: "#000000",
        linesDark: "#52525B",
        textInput: "#CBD5E1",
        dark: "#0F172A",
      },
      boxShadow: {
        'glow': '0px 4px 100px #64748B;',
      },
    },
  },
  plugins: [
    plugin(function ({ addVariant }) {
      addVariant('htmx-settling', ['&.htmx-settling', '.htmx-settling &'])
      addVariant('htmx-request', ['&.htmx-request', '.htmx-request &'])
      addVariant('htmx-swapping', ['&.htmx-swapping', '.htmx-swapping &'])
      addVariant('htmx-added', ['&.htmx-added', '.htmx-added &'])
    }),
  ],
}


