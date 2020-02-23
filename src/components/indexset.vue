<template>
  <div class="iframe_body">
    <el-tabs v-model="activeName" type="card" @tab-click="handleClick">
      <el-tab-pane label="首页管理" name="first">
        <!--基础信息-->
        <div>
          <div class="title-bar" style="margin:5px 0 0;">基础信息</div>
          <div style="padding: 0 0 0 20px;">
            <el-form label-width="70px" class="formIndex" style="width:420px;">
              <div>
                <div class="big-title">首页标题</div>
                <el-form-item label="首页标题" style="margin:10px 0 0;">
                  <el-input
                    v-model.trim="form.IndexTitle"
                    maxlength=4
                    placeholder="最多4个字，不填默认为“XX优选”"
                    size="medium"
                  ></el-input>
                </el-form-item>
              </div>
              <div>
                <div class="big-title">首页分享</div>
                <el-form-item label="分享标题" style="margin:10px 0 0;" class="formIndex">
                  <el-input
                    v-model.trim="form.SharpTitle"
                    maxlength=15
                    placeholder="最多15个字，不填默认为“XX优选-好吃好玩特划算”"
                    size="medium"
                  ></el-input>
                </el-form-item>
                <el-form-item label="分享图片" style="margin:10px 0 0;">
                  <el-upload
                    class="avatar-uploader"
                    action="https://jsonplaceholder.typicode.com/posts/"
                    :show-file-list="false"
                    :on-success="handleAvatarSuccess01"
                    :before-upload="beforeAvatarUpload01"
                  >
                    <img v-if="form.SharpImgUrl" :src="form.SharpImgUrl" class="avatar" />
                    <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                  </el-upload>
                  <p class="alert-f" style="margin:-5px 0 0;">推荐尺寸200*200，不更改默认为页面截图</p>
                </el-form-item>
              </div>
              <div>
                <div class="big-title">客服二维码</div>
                <el-form-item style="margin:10px 0 0;">
                  <el-upload
                    class="avatar-uploader"
                    action="https://jsonplaceholder.typicode.com/posts/"
                    :show-file-list="false"
                    :on-success="handleAvatarSuccess02"
                    :before-upload="beforeAvatarUpload02"
                  >
                    <img v-if="form.KfQRCode" :src="form.KfQRCode" class="avatar" />
                    <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                  </el-upload>
                  <p class="alert-f" style="margin:-5px 0 0;">上传个人二维码，作为用户联系城主的方式</p>
                </el-form-item>
              </div>
              <el-button @click="saveBaseInforData()" type="primary" style="margin:20px 0 0 70px;padding:12px 50px;">保存</el-button>
            </el-form>
          </div>
        </div>
        <!--首页轮播图-->
        <div>
          <div class="title-bar" style="margin:40px 0 0;">首页轮播图</div>
          <div style="margin:20px 0 10px;">
            <el-button type="primary" size="medium" @click="dialogIndexAdSeen=true">新增轮播图</el-button>
            <div class="alert-f" style="margin: 5px 0;">最多上传5张轮播图，不添加则展示默认宣传图片</div>
          </div>
          <!--表单list01-->
          <template>
            <el-table
              ref="multipleTable"
              :data="list01"
              tooltip-effect="dark"
              border
              style="width:800px;"
              @selection-change="handleSelectionChange"
            >
              <el-table-column prop="Id" label="ID" width="120"></el-table-column>
              <el-table-column prop="ImgUrl" label="图片" show-overflow-tooltip>
                <template slot-scope="scope">
                  <img :src="scope.row.ImgUrl" style="display:block;width:100%;" />
                </template>
              </el-table-column>
              <el-table-column prop="Link" label="关联地址" width="200"></el-table-column>
              <el-table-column prop="sort" label="排序" width="120"></el-table-column>
              <el-table-column label="操作" width="150">
                <template slot-scope="scope">
                  <el-button type="primary" plain size="mini">编辑</el-button>
                  <el-button type="danger" plain size="mini">删除</el-button>
                </template>
              </el-table-column>
            </el-table>
          </template>
        </div>
        <!--首页图标-->
        <div>
          <div class="title-bar" style="margin:40px 0 20px;">首页图标</div>
          <!--表单-->
          <template>
            <el-table
              ref="multipleTable"
              :data="list02"
              tooltip-effect="dark"
              border
              style="width:800px;"
              @selection-change="handleSelectionChange"
            >
              <el-table-column prop="Title" label="名称" width="120"></el-table-column>
              <el-table-column prop="ImgUrl" label="图标" show-overflow-tooltip>
                <template slot-scope="scope">
                  <img :src="scope.row.ImgUrl" style="display:block;width:100%;" />
                </template>
              </el-table-column>
              <el-table-column prop="Link" label="关联地址" width="200"></el-table-column>
              <el-table-column prop="sort" label="排序" width="120"></el-table-column>
              <el-table-column prop="state" label="状态" width="120"></el-table-column>
              <el-table-column label="操作" width="150">
                  <router-link to="/indexicon">
                    <el-button type="primary" plain size="mini">编辑</el-button>
                  </router-link>
                  <template slot-scope="scope">
                    <el-button type="danger" plain size="mini" v-if="scope.row.status===0">关闭</el-button>
                    <el-button type="success" plain size="mini" v-else>开启</el-button>
                  </template>
              </el-table-column>
            </el-table>
          </template>
        </div>
        <!--底部导航-->
        <div>
          <div class="title-bar" style="margin:40px 0 20px;">底部导航</div>
          <!--表单-->
          <template>
            <el-table
              ref="multipleTable"
              :data="list03"
              tooltip-effect="dark"
              border
              style="width:800px;"
              @selection-change="handleSelectionChange"
            >
              <el-table-column prop="Title" label="名称" width="120"></el-table-column>
              <el-table-column prop="ImgUrl" label="图标" show-overflow-tooltip>
                <template slot-scope="scope">
                  <img :src="scope.row.ImgUrl" style="display:block;width:100%;" />
                </template>
              </el-table-column>
              <el-table-column prop="Link" label="关联地址" width="200"></el-table-column>
              <el-table-column label="操作" width="150">
                  <el-button type="primary" plain size="mini">编辑</el-button>
              </el-table-column>
            </el-table>
          </template>
        </div>
      </el-tab-pane>

      <el-tab-pane label="店铺聚合页管理" name="second">
        <!--轮播广告模块-->
        <div class="title-bar" style="margin:5px 0 0;">轮播广告模块</div>
        <div style="padding: 0 0 0 20px;">
          <div class="d-flex d-flex-center" style="margin:20px 0;">
            <div style="margin-right: 12px;">功能开关</div>
            <el-switch v-model="form.IsAdvert" :active-value='1' :inactive-value='0' @change="operateAdvert()"></el-switch>
          </div>
          <div style="margin:20px 0 10px;">
            <el-button type="primary" size="medium" @click="dialogAdFormVisible=true">添加广告</el-button>
            <el-button size="medium">批量删除广告</el-button>
            <div class="alert-f" style="margin: 5px 0;">最多添加8张轮播图，不添加则展示默认宣传图片</div>
          </div>
          <!--表单list04-->
          <template>
            <el-table
              ref="multipleTable"
              :data="list04"
              tooltip-effect="dark"
              border
              style="width: 100%;"
              @selection-change="handleSelectionChange"
            >
              <el-table-column type="selection" width="55"></el-table-column>
              <el-table-column prop="ImgUrl" label="图片">
                <template slot-scope="scope">
                  <img :src="scope.row.ImgUrl" style="display:block;width:100%;" />
                </template>
              </el-table-column>
              <el-table-column prop="Link" label="url" width="120"></el-table-column>
              <el-table-column prop="Addtime" label="添加日期" width="140"></el-table-column>
              <el-table-column prop="ExpireTime" label="过期日期" width="140"></el-table-column>
              <el-table-column prop="Sort" label="排序" width="60"></el-table-column>
              <el-table-column label="操作" width="150">
                <template>
                  <el-button type="primary" plain size="mini">编辑</el-button>
                  <el-button type="danger" plain size="mini">删除</el-button>
                </template>
              </el-table-column>
            </el-table>
          </template>
        </div>

        <!--推荐好店模块-->
        <div class="title-bar">推荐好店模块</div>
        <div style="padding: 0 0 0 20px;">
          <div class="d-flex d-flex-center" style="margin:20px 0 0;">
            <div style="margin-right: 12px;">功能开关</div>
            <el-switch v-model="form.IsRecommend" :active-value='1' :inactive-value='0' @change="operateRecommend()"></el-switch>
          </div>
          <div class="d-flex" style="margin:10px 0;">
            <div style="margin-right: 12px;">显示规则</div>
            <div class="flex">
                <el-radio v-model="form.DisplayRule" :label="0" @change="displayRule()">优先显示最新入驻店铺</el-radio>
                <el-radio v-model="form.DisplayRule" :label="1" @change="displayRule()">优先显示置顶店铺</el-radio>
            </div>
          </div>
        </div>
      </el-tab-pane>
    </el-tabs>

    <!--上传首页轮播图-->
    <el-dialog
      title="上传轮播图"
      :visible.sync="dialogIndexAdSeen"
      center
      width="350px"
      class="formUploadIndexAd"
    >
      <el-form :model="formIndexAd" label-width="70px">
        <el-upload
          class="avatar-uploader"
          :action="webconfig.apiUrl + '/city/UploadImg?cityInfoId=' + queryPara.cityInfoId"
          :headers="{'client_name':'2'}"
          :show-file-list="false"
          :on-success="handleAvatarSuccess03"
          :before-upload="beforeAvatarUpload03"
          style="text-align:center"
        >
          <img v-if="formIndexAd.imageUrl" :src="formIndexAd.imageUrl" class="avatar" />
          <i v-else class="el-icon-plus avatar-uploader-icon"></i>
          <div class="el-upload__tip" slot="tip">点击更换图片，推荐尺寸640*390</div>
        </el-upload>
        <el-form-item label="入口链接" style="margin:20px 0 5px;">
          <el-input v-model.trim="formIndexAd.url" placeholder="输入要跳转的小程序页面" size="medium"></el-input>
        </el-form-item>
        <el-form-item label="排序" style="margin:0 0 5px;">
          <el-input
            v-model.number="formIndexAd.sort"
            type="tel"
            oninput="value=value.replace(/[^\d]/g,'')"
            size="medium"
            placeholder="数值越大越靠前"
          ></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogIndexAdSeen = false">取 消</el-button>
        <el-button type="primary" @click="saveAddIndexAdData()">确 定</el-button>
      </div>
    </el-dialog>

    <!--底部导航入口配置-->
    <!-- <el-dialog title="入口配置" :visible.sync="dialogNavSeen" center width="350px">
      <el-form :model="formNav" label-width="70px">
        <el-upload
          class="avatar-uploader"
          action="https://jsonplaceholder.typicode.com/posts/"
          :show-file-list="false"
          :on-success="handleAvatarSuccess"
          :before-upload="beforeAvatarUpload"
          style="text-align:center"
        >
          <img v-if="formNav.imageUrl" :src="formNav.imageUrl" class="avatar" />
          <i v-else class="el-icon-plus avatar-uploader-icon"></i>
          <div class="el-upload__tip" slot="tip">点击更换图片，推荐尺寸75*75</div>
        </el-upload>
        <el-form-item label="入口名称" style="margin:20px 0 5px;">
          <el-input v-model.trim="formNav.name" placeholder="最多4个字" size="medium"></el-input>
        </el-form-item>
        <el-form-item label="入口链接" style="margin:0 0 5px;">
          <el-select v-model="formNav.url" size="medium" style="width:150px;">
            <el-option
              v-for="(item,index) in formNav.urlOptions"
              :key="index"
              :label="item.option"
              :value="item.value"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="自定义" style="margin:0 0 5px;">
          <el-input v-model.trim="formNav.customUrl" size="medium"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary">确 定</el-button>
      </div>
    </el-dialog> -->

    <!--店铺聚合页 上传首页轮播图-->
    <!-- <el-dialog
      title="上传轮播图"
      :visible.sync="dialogShopAdSeen"
      center
      width="350px"
      class="formUploadIndexAd"
    >
      <el-form :model="formShop" label-width="70px">
        <el-upload
          class="avatar-uploader"
          action="https://jsonplaceholder.typicode.com/posts/"
          :show-file-list="false"
          :on-success="handleAvatarSuccess"
          :before-upload="beforeAvatarUpload"
          style="text-align:center;"
        >
          <img v-if="formShop.imageUrl" :src="formShop.imageUrl" class="avatar" />
          <i v-else class="el-icon-plus avatar-uploader-icon"></i>
          <div class="el-upload__tip" slot="tip">点击更换图片，推荐尺寸640X210</div>
        </el-upload>
        <el-form-item label="入口链接" style="margin:20px 0 5px;">
          <el-input v-model.trim="formShop.url" placeholder="请输入链接" size="medium"></el-input>
        </el-form-item>
        <el-form-item label="排序" style="margin:0 0 5px;">
          <el-input
            v-model.number="formShop.sort"
            type="tel"
            oninput="value=value.replace(/[^\d]/g,'')"
            size="medium"
            placeholder="数值越大越靠前"
          ></el-input>
        </el-form-item>
        <el-form-item label="过期时间" style="margin:0 0 5px;">
          <el-date-picker
            v-model="formShop.outdate"
            type="datetime"
            placeholder="请选择时间"
            size="medium"
            style="width:100%;"
          ></el-date-picker>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="submitForm('ruleForm')">确 定</el-button>
      </div>
    </el-dialog> -->

  </div>
</template>

<script>
import { vueMixins } from '../assets/js/mixins.js'
import '../assets/css/city_backstage.css'
export default {
  name: 'indexSet',
  mixins: [vueMixins], // 注册mixins
  data: function() {
    return {
      activeName: 'first',
      adValue: false,
      dialogIndexAdSeen: false,
      dialogNavSeen: false,
      dialogShopAdSeen: false,
      radio: 1,
      queryPara: {
        // 用来请求
        cityInfoId: this.$cookie.get('cityInfoId')
      },
      list01: [],
      list02: [],
      list03: [],
      list04: [],
      form: { // 首页设置
        cityInfoId: this.$cookie.get('cityInfoId'),
        IndexTitle: '',
        SharpTitle: '',
        SharpImgUrl: '',
        KfQRCode: '',
        IsAdvert: '',
        IsRecommend: '',
        DisplayRule: ''
      },
      formIndexAd: {
        id: 0,
        imageUrl: '',
        url: '',
        sort: ''
      },
      formNav: {
        imageUrl: '',
        url: '首页',
        urlOptions: [
          { value: '选项1', option: '首页' },
          { value: '选项2', option: '好店' },
          { value: '选项3', option: '精选' },
          { value: '选项4', option: '我的' }
        ],
        customUrl: ''
      },
      formShop: {
        imageUrl: '',
        url: '',
        sort: '',
        outdate: ''
      },
      goodShopRecommend: { value: false, radio: 1 }
    }
  },
  methods: {
    loadData01() {
      // 加载数据
      var self = this
      self.loading = true // 显示加载动画
      self.$axios({
        method: 'GET',
        url: '/city/GetIndexCarousel',
        params: self.queryPara
      })
        .then(function (res) {
          if (res.data.code === 1) { // 获取数据成功
          } else { // 获取数据失败
          }
          console.log(res)
        })
        .catch(function (error) {
          console.log(error)
        })
    },
    loadData02() {
      // 加载数据
      var self = this
      self.loading = true // 显示加载动画
      self.$axios({
        method: 'GET',
        url: '/city/GetIndexButtonConfig',
        params: self.queryPara
      })
        .then(function (res) {
          if (res.data.code === 1) { // 获取数据成功
          } else { // 获取数据失败
          }
          console.log(res)
        })
        .catch(function (error) {
          console.log(error)
        })
    },
    loadData03() {
      // 加载数据
      var self = this
      self.loading = true // 显示加载动画
      self.$axios({
        method: 'GET',
        url: '/city/GetBottomButtonConfig',
        params: self.queryPara
      })
        .then(function (res) {
          if (res.data.code === 1) { // 获取数据成功
          } else { // 获取数据失败
          }
          console.log(res)
        })
        .catch(function (error) {
          console.log(error)
        })
    },
    loadData04() {
      // 加载数据
      var self = this
      self.loading = true // 显示加载动画
      self.$axios({
        method: 'GET',
        url: '/city/GetStoreAdCarouse',
        params: self.queryPara
      })
        .then(function (res) {
          if (res.data.code === 1) { // 获取数据成功
          } else { // 获取数据失败
          }
          console.log(res)
        })
        .catch(function (error) {
          console.log(error)
        })
    },
    loadData05() {
      // 保存修改数据
      var self = this
      // 请求数据
      self.$axios({
        method: 'GET',
        url: '/city/GetCityConfig',
        params: self.queryPara
      })
        .then(function (res) {
          if (res.data.code === 1) { // 获取数据成功
            self.form = res.data.obj
          } else { // 获取数据失败
            this.$message(res.data.msg)
          }
          console.log(res)
        })
        .catch(function (error) {
          console.log(error)
        })
    },
    saveBaseInforData() {
      // 保存修改数据
      var self = this
      if (self.isNullOrEmpty(self.form.IndexTitle)) {
        self.$message('首页标题不能为空')
        return
      }
      if (self.isNullOrEmpty(self.form.SharpTitle)) {
        self.$message('分享标题不能为空')
        return
      }
      if (self.isNullOrEmpty(self.form.SharpImgUrl)) {
        self.$message('分享图片不能为空')
        return
      }
      if (self.isNullOrEmpty(self.form.KfQRCode)) {
        self.$message('客服二维码不能为空')
        return
      }
      // 请求数据
      self.$axios({
        method: 'POST',
        url: '/city/SaveCityConfig',
        params: self.form
      })
        .then(function (res) {
          if (res.data.code === 1) { // 获取数据成功
            self.$message('保存成功！')// 弹出提示
          } else { // 获取数据失败
            self.$message(res.data.msg) // 弹出删除失败提示
          }
          console.log(res)
        })
        .catch(function (error) {
          console.log(error)
        })
    },
    operateAdvert() {
      // 加载数据
      var self = this
      self.loading = true // 显示加载动画
      self.$axios({
        method: 'POST',
        url: '/city/OperateAdvert',
        params: { IsAdvert: self.form.IsAdvert }// 对象
      })
        .then(function (res) {
          if (res.data.code === 1) { // 获取数据成功
            self.$message(res.data.msg)// 弹出提示
          } else { // 获取数据失败
            self.$message(res.data.msg) // 弹出删除失败提示
          }
          console.log(res)
        })
        .catch(function (error) {
          console.log(error)
        })
    },
    operateRecommend() {
      // 加载数据
      var self = this
      self.loading = true // 显示加载动画
      self.$axios({
        method: 'POST',
        url: '/city/OperateRecommend',
        params: { IsRecommend: self.form.IsRecommend }// 对象
      })
        .then(function (res) {
          if (res.data.code === 1) { // 获取数据成功
            self.$message(res.data.msg)// 弹出提示
          } else { // 获取数据失败
            self.$message(res.data.msg) // 弹出删除失败提示
          }
          console.log(res)
        })
        .catch(function (error) {
          console.log(error)
        })
    },
    displayRule() {
      // 加载数据
      var self = this
      self.loading = true // 显示加载动画
      self.$axios({
        method: 'POST',
        url: '/city/OperateDisplayRule',
        params: { DisplayRule: self.form.DisplayRule }// 对象
      })
        .then(function (res) {
          if (res.data.code === 1) { // 获取数据成功
            self.$message(res.data.msg)// 弹出提示
          } else { // 获取数据失败
            self.$message(res.data.msg) // 弹出删除失败提示
          }
          console.log(res)
        })
        .catch(function (error) {
          console.log(error)
        })
    },
    saveAddIndexAdData() {
      // 保存修改数据
      var self = this
      if (self.isNullOrEmpty(self.form.imageUrl)) {
        self.$message('请上传轮播图')
        return
      }
      // 请求数据
      self.$axios({
        method: 'POST',
        url: '/city/SaveIndexCarousel',
        params: self.formIndexAd
      })
        .then(function (res) {
          if (res.data.code === 1) { // 获取数据成功
            self.$message('添加成功！')// 弹出提示
          } else { // 获取数据失败
            self.$message(res.data.msg) // 弹出删除失败提示
          }
          console.log(res)
        })
        .catch(function (error) {
          console.log(error)
        })
    },
    handleClick() {},
    handleAvatarSuccess01(res, file) {
      this.form.SharpImgUrl = URL.createObjectURL(file.raw)
    },
    beforeAvatarUpload01(file) {
      const isJPG = file.type === 'image/jpeg'
      if (!isJPG) {
        this.$message.error('上传头像图片只能是 JPG和png 格式!')
      }
      return isJPG
    },
    handleAvatarSuccess02(res, file) {
      this.form.KfQRCode = URL.createObjectURL(file.raw)
    },
    beforeAvatarUpload02(file) {
      const isJPG = file.type === 'image/jpeg'
      if (!isJPG) {
        this.$message.error('上传头像图片只能是 JPG和png 格式!')
      }
      return isJPG
    },
    handleAvatarSuccess03(res, file) {
      this.formIndexAd.KfQRCode = URL.createObjectURL(file.raw)
    },
    beforeAvatarUpload03(file) {
      const isJPG = file.type === 'image/jpeg'
      if (!isJPG) {
        this.$message.error('上传头像图片只能是 JPG和png 格式!')
      }
      return isJPG
    }

    // self.$axios.post('此处请输入接口链接，请询问后端开发', self.editItem, function (res) {
    //   if (res.code === 1) { // 修改数据成功
    //     self.$message('修改成功！')// 弹出提示
    //   } else { // 修改数据失败
    //     self.$message(res.msg)// 弹出删除失败提示
    //     setTimeout(function () {
    //       location.reload()// 刷新页面
    //     }, 2000)
    //   }
    //   self.dialogVisible = false// 关闭窗口
    // })

  },
  mounted: function() {},
  created: function() {
    this.loadData01()
    this.loadData02()
    this.loadData03()
    this.loadData04()
  }
}
</script>
<style>
.el-radio{margin: 10px 0px 0px;display: block}
.el-radio:first-child{margin: 2px 0px 0px;}
</style>
