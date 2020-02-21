<template>
  <div id="app">
    <div>
      <el-container style="height:100vh;">
        <el-container>
          <el-aside style="width:200px;">
            <el-menu
              default-active="2"
              class="el-menu-vertical-demo"
              background-color="#545c64"
              text-color="#fff"
              active-text-color="#ffd04b"
              :unique-opened=true
              router
            >
              <div v-for="(menu,i) in menulist" :key="i">
                <el-submenu :index="menu.link" v-if="menu.classTwo">
                  <template slot="title">
                    <i :class="menu.icon"></i>
                    <span>{{menu.name}}</span>
                  </template>
                  <el-menu-item :index="submenu.link" v-for="(submenu,index) in menu.classTwo" :key="index">
                    <span slot="title">{{submenu.name}}</span>
                  </el-menu-item>
                </el-submenu>
                <el-menu-item :index="menu.link" v-else>
                  <i :class="menu.icon"></i>
                  <span slot="title">{{menu.name}}</span>
                </el-menu-item>
              </div>
            </el-menu>
          </el-aside>
          <el-main style="padding: 0;">
            <router-view />
          </el-main>
        </el-container>
      </el-container>
    </div>
  </div>
</template>

<script>
export default {
  name: 'App',
  data() {
    return {
      menulist: [
        {
          icon: 'el-icon-s-home',
          name: '同城概况',
          link: '/'
        },
        {
          icon: 'el-icon-menu',
          name: '同城管理',
          link: '2',
          classTwo: [
            {
              name: '首页管理',
              link: '/indexset'
            },
            {
              name: '评价管理',
              link: '/evaluatemanage'
            },
            {
              name: '用户管理',
              link: '/usermanage'
            }
          ]
        },
        {
          icon: 'el-icon-s-shop',
          name: '好店业务',
          link: '3',
          classTwo: [
            {
              name: '商户管理',
              link: '/shopmanage'
            },
            {
              name: '商品管理',
              link: '/commoditymanage'
            },
            {
              name: '订单管理',
              link: '/ordermanage'
            }
          ]
        },
        {
          icon: 'el-icon-s-data',
          name: '资产管理',
          link: '/propertymanage'
        }
      ]
    }
  }
}
</script>

<style>
.el-submenu .el-menu-item {
  padding-left: 67px !important;
}
.el-aside {
  border-right: solid 1px #e6e6e6;
  overflow-x: hidden;
  background-color: rgb(84, 92, 100);
  color: #fff;
}
.el-aside .el-menu {
  background: transparent;
  width: 100%;
}
.el-aside .el-submenu__title,
.el-aside .el-submenu__title i,
.el-aside .el-menu-item,
.el-aside .el-menu-item i {
  color: #fff !important;
}
.el-aside .el-menu-item:focus,
.el-aside .el-menu-item:hover,
.el-aside .el-submenu__title:focus,
.el-aside .el-submenu__title:hover {
  background-color: #409eff !important;
}
</style>
