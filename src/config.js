export default {
  install(Vue, options) {
    Vue.prototype.config = {
      apiUrl: 'http://ms-city.vzan.com'
    }
  }
}
