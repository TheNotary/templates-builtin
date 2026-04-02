const path = require('path')
const { defineConfig } = require('vite')

module.exports = defineConfig({
  build: {
    lib: {
      entry: path.resolve(__dirname, 'lib/main.js'),
      name: 'YOUR_LIBRARY_NAME',
      fileName: (format) => `test.${format}.js`
    }
  }
});
