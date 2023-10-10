const { environment } = require('@rails/webpacker')
environment.entryPoints
  .set('application', './app/javascript/packs/application')
  .set('styles', './app/javascript/stylesheets/application')

module.exports = environment
