const { environment } = require('@rails/webpacker')

environment.loaders.add({
  key: 'opusRecorder', 
  value: {
    test: /(en|de)coderWorker\.min\.(js|wasm)$/,
    use: [{ loader: 'file-loader' }]
  }
})

module.exports = environment
