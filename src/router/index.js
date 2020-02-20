import Vue from 'vue'
import Router from 'vue-router'
import Situation from '@/components/Situation'
import commoditymanage from '@/components/commoditymanage'
Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      name: '同城概况',
      component: Situation
    },
    {
      path: '/commoditymanage',
      name: '商品管理',
      component: commoditymanage
    }
  ]
})
