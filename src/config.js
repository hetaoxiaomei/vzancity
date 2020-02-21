import axios from 'axios'
export default {
  install(Vue, options) {
    Vue.prototype.webconfig = {
      apiUrl: 'http://ms-city.vzan.com'
    }
    axios.defaults.baseURL = '/city'
    Vue.prototype.$axios = axios
  }
}
