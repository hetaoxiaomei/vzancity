import Vue from 'vue'
import Router from 'vue-router'
import Situation from '@/components/Situation'
import indexset from '@/components/indexset'
import indexicon from '@/components/indexicon'
import ordermanage from '@/components/ordermanage'
import commoditymanage from '@/components/commoditymanage'
import commoditytype from '@/components/commoditytype'
import shopmanage from '@/components/shopmanage'
import evaluatemanage from '@/components/evaluatemanage'
import usermanage from '@/components/usermanage'
import propertymanage from '@/components/propertymanage'
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
      path: '/indexset',
      name: '首页管理',
      component: indexset
    },
    {
      path: '/indexicon',
      name: '入口设置',
      component: indexicon
    },
    {
      path: '/ordermanage',
      name: '订单管理',
      component: ordermanage
    },
    {
      path: '/commoditymanage',
      name: '商品管理',
      component: commoditymanage
    },
    {
      path: '/commoditytype',
      name: '商品类别',
      component: commoditytype
    },
    {
      path: '/shopmanage',
      name: '商户管理',
      component: shopmanage
    },
    {
      path: '/evaluatemanage',
      name: '评论管理',
      component: evaluatemanage
    },
    {
      path: '/usermanage',
      name: '用户管理',
      component: usermanage
    },
    {
      path: '/propertymanage',
      name: '用户管理',
      component: propertymanage
    }
  ]
})
