import Vue from 'vue'
import Router from 'vue-router'
import situation from '@/components/situation'
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
      component: situation,
      meta: {
        requireAuth: true // 添加该字段 ( 字段名可以自定义 )，表示进入这个路由是需要登录的
      }
    },
    {
      path: '/indexset',
      name: '首页管理',
      component: indexset,
      meta: {
        requireAuth: true // 添加该字段 ( 字段名可以自定义 )，表示进入这个路由是需要登录的
      }
    },
    {
      path: '/indexicon',
      name: '入口设置',
      component: indexicon,
      meta: {
        requireAuth: true // 添加该字段 ( 字段名可以自定义 )，表示进入这个路由是需要登录的
      }
    },
    {
      path: '/ordermanage',
      name: '订单管理',
      component: ordermanage,
      meta: {
        requireAuth: true // 添加该字段 ( 字段名可以自定义 )，表示进入这个路由是需要登录的
      }
    },
    {
      path: '/commoditymanage',
      name: '商品管理',
      component: commoditymanage,
      meta: {
        requireAuth: true // 添加该字段 ( 字段名可以自定义 )，表示进入这个路由是需要登录的
      }
    },
    {
      path: '/commoditytype',
      name: '商品类别',
      component: commoditytype,
      meta: {
        requireAuth: true // 添加该字段 ( 字段名可以自定义 )，表示进入这个路由是需要登录的
      }
    },
    {
      path: '/shopmanage',
      name: '商户管理',
      component: shopmanage,
      meta: {
        requireAuth: true // 添加该字段 ( 字段名可以自定义 )，表示进入这个路由是需要登录的
      }
    },
    {
      path: '/evaluatemanage',
      name: '评论管理',
      component: evaluatemanage,
      meta: {
        requireAuth: true // 添加该字段 ( 字段名可以自定义 )，表示进入这个路由是需要登录的
      }
    },
    {
      path: '/usermanage',
      name: '用户管理',
      component: usermanage,
      meta: {
        requireAuth: true // 添加该字段 ( 字段名可以自定义 )，表示进入这个路由是需要登录的
      }
    },
    {
      path: '/propertymanage',
      name: '资产管理',
      component: propertymanage,
      meta: {
        requireAuth: true // 添加该字段 ( 字段名可以自定义 )，表示进入这个路由是需要登录的
      }
    }
  ]
})
