/** @type {import('tailwindcss').Config} */
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
  plugins: [],
}


