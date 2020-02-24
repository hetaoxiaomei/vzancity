import axios from 'axios'
import cookie from 'vue-cookie'
// import router from './router'

export default {
  install(Vue, options) {
    Vue.prototype.webconfig = {
      apiUrl: 'http://ms-city.vzan.com/city'
    }

    axios.defaults.baseURL = 'http://ms-city.vzan.com/city'
    // axios.defaults.baseURL = 'http://192.168.30.181:58002/city'
    // axios.defaults.withCredentials = true
    axios.interceptors.request.use(
      config => {
        config.data = JSON.stringify(config.data)
        config.headers = {
          'Content-Type': 'application/json',
          'client_name': '2',
          'cityInfoId': cookie.get('cityInfoId')
        }
        return config
      },
      err => {
        return Promise.reject(err)
      }
    )
    // axios.interceptors.response.use(
    //   response => {
    //     // 判断是否登陆
    //     if (response.data.code === -100) {
    //       window.location.href = 'https://user.vzan.com/home/login'
    //     }
    //     return response
    //   },
    //   error => {
    //     return Promise.reject(error.response.data)
    //   })
    Vue.prototype.$axios = axios

    Vue.prototype.$cookie = cookie
  }
}
