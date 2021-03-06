// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
import config from './config.js'
// import cookie from 'vue-cookie'

Vue.use(config)
Vue.config.productionTip = false
Vue.use(ElementUI)

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  components: { App },
  template: '<App/>'
})

// router.beforeEach((to, from, next) => {
//   if (to.matched.some(record => record.meta.requireAuth)) { // 判断该路由是否需要登录权限
//     var key = cookie.get('UserCookieNew')
//     if (key && key !== '') { // 判断当前的token是否存在
//       next()
//     } else {
//       next('/login')
//     }
//   } else {
//     next()
//   }
// })
