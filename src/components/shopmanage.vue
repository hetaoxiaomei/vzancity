<template>
  <div class="iframe_body">
    <el-tabs v-model="activeName" type="card" @tab-click="handleClick">
      <el-tab-pane label="商家管理" name="first">
        <el-form :inline="true" class="demo-form-inline table-serch">
          <el-form-item label="商家ID：" size="small" style="margin:0">
            <el-input v-model="queryPara.storeId" placeholder="请输入商家ID" style="width:180px;"></el-input>
          </el-form-item>
          <el-form-item label="商家名称：" size="small" style="margin:0 0 0 10px">
            <el-input v-model="queryPara.name" placeholder="请输入商家名称" style="width:180px;"></el-input>
          </el-form-item>
          <el-form-item label="商家分类：" size="small" style="margin:0 0 0 10px">
            <el-select v-model="queryPara.type" style="width:100%">
              <el-option
                v-for="(item,index) in list02"
                :label="item.TypeName"
                :value="item.Id"
                :key="index"
              ></el-option>
            </el-select>
          </el-form-item>
          <div style="margin:10px 0 0 0;">
            <div style="display:inline-block;color:#606266">
              <span class="el-form-item__label">入驻时间：</span>
              <el-date-picker size="small" style="width:180px"
                v-model="queryPara.entryStartDate"
                type="date">
              </el-date-picker>
              <span>至</span>
              <el-date-picker size="small" style="width:180px"
                v-model="queryPara.entryEndDate"
                type="date">
              </el-date-picker>
            </div>
            <div style="display:inline-block;margin:0 0 0 10px">
              <span class="el-form-item__label">过期时间：</span>
              <el-date-picker size="small" style="width:180px"
                v-model="queryPara.expireStartDate"
                type="date">
              </el-date-picker>
              <span>至</span>
              <el-date-picker size="small" style="width:180px"
                v-model="queryPara.expireEndDate"
                type="date">
              </el-date-picker>
            </div>
            <el-row style="display:inline-block;margin:0 0 0 10px">
              <el-button size="small" @click="clean()">清空条件</el-button>
              <el-button type="primary" @click="search()" size="small" style="padding:9px 30px;">搜索</el-button>
            </el-row>
          </div>
        </el-form>
        <div style="margin:20px 0 10px;">
            <el-button type="primary" size="medium" @click="activeName = 'third'">新增商家</el-button>
        </div>
        <!--表单-->
        <template>
          <el-table
            ref="multipleTable"
            tooltip-effect="dark"
            border
            style="width:100%;border-bottom: 0;border-right:0;"
            @selection-change="handleSelectionChange"
          >
            <el-table-column prop="Id" label="商家ID" width="80"></el-table-column>
            <el-table-column prop="StoreName" label="商家名称"></el-table-column>
            <el-table-column prop=" " label="店主信息">
              <template slot-scope="scope">
                <div class="d-flex d-flex-center">
                  <img
                    :src="scope.row.ownerInfor.head"
                    style="display:block;width:50px;height:50px;margin:0 10px 0 0;"
                  />
                  <div class="flex">{{scope.row.ownerInfor.name}}</div>
                </div>
              </template>
            </el-table-column>
            <el-table-column prop label="所属区域" width="100"></el-table-column>
            <el-table-column prop="StoreType" label="商家分类" width="100"></el-table-column>
            <el-table-column prop="EntryTime" label="入驻时间" width="100"></el-table-column>
            <el-table-column prop="ExpireTime" label="过期时间" width="100"></el-table-column>
            <el-table-column prop="PayRate" label="店铺流水分成" width="80"></el-table-column>
            <el-table-column label="置顶状态" width="80">
              <template slot-scope="scope">
                <span v-if="scope.row.TopStatus==1">是</span>
                <span v-else>否</span>
              </template>
            </el-table-column>
            <el-table-column label="操作" width="130">
              <a>
                <el-button type="primary" plain size="mini" style="margin:0 0 5px;">进入管理</el-button>
              </a>
              <a>
                <el-button type="primary" plain size="mini" style="margin:0 0 5px;">修改过期</el-button>
              </a>
              <a>
                <el-button type="primary" plain size="mini" style="margin:0 0 5px;">修改店主</el-button>
              </a>
              <a>
                <el-button type="primary" plain size="mini" style="margin:0 0 5px;">修改置顶状态</el-button>
              </a>
              <a>
                <el-button type="danger" plain size="mini" style="margin:0 0 5px;">删除</el-button>
              </a>
            </el-table-column>
          </el-table>
          <!--分页栏-->
          <div style="margin-top:20px;display:none;" v-show="count>0">
            <el-pagination
              @size-change="handleSizeChange"
              @current-change="handleCurrentChange"
              :current-page="queryPara.pageIndex"
              :page-sizes="[10, 20, 30, 40, 50]"
              :page-size="10"
              layout="total, sizes, prev, pager, next, jumper"
              background
              :total="count"
            ></el-pagination>
          </div>
        </template>
      </el-tab-pane>

      <el-tab-pane label="商家分类" name="second">
        <div style="margin:0 0 10px;">
          <el-button type="primary" size="medium" @click="dialogShopTypeSeen = true">新增分类</el-button>
        </div>
        <!--表单-->
        <template>
          <el-table
            ref="multipleTable"
            :data="list02"
            tooltip-effect="dark"
            border
            style="width:700px;"
          >
            <el-table-column prop="Id" label="分类ID" width="120"></el-table-column>
            <el-table-column prop="TypeName" label="分类名称" width="120"></el-table-column>
            <el-table-column prop="Url" label="商家分类列表地址" show-overflow-tooltip></el-table-column>
            <el-table-column prop="Sort" label="排序" width="80"></el-table-column>
            <el-table-column label="操作" width="150">
              <template slot-scope="scope">
                <el-button type="primary" plain size="mini" @click="showEditShopType(scope.$index, scope.row)">编辑</el-button>
                <el-button type="danger" plain size="mini" @click="delShopType(scope.$index, scope.row)">删除</el-button>
              </template>
            </el-table-column>
          </el-table>
        </template>
      </el-tab-pane>

      <el-tab-pane label="录入商家" name="third">
        <el-form :model="form02" label-width="90px">
          <el-form-item label="商家名称" style="margin:10px 0 0;" size="medium">
            <el-input v-model.trim="form02.StoreName" placeholder="最多20个字" maxlength="20" style="width:340px;"></el-input>
          </el-form-item>
          <el-form-item label="商家分类" size="medium" style="margin:10px 0 0;">
            <el-select v-model="form02.StoreType" style="width:200px">
              <el-option
                v-for="(item,index) in list02"
                :label="item.TypeName"
                :value="item.Id"
                :key="index"
              ></el-option>
            </el-select>
            <el-link class="blue-text-bt" @click="activeName='second'">添加分类</el-link>
          </el-form-item>
          <el-form-item label="商家区域" size="medium" style="margin:10px 0 0;">
            <el-select v-model="form02.ProvinceId" style="width:200px;display:inline-block;">
              <el-option
                v-for="(item,index) in form02.areaOption01"
                :label="item.option"
                :value="item.value"
                :key="index"
              ></el-option>
            </el-select>
            <el-select v-model="form02.CityId" style="width:200px;display:inline-block;">
              <el-option
                v-for="(item,index) in form02.areaOption02"
                :label="item.option"
                :value="item.value"
                :key="index"
              ></el-option>
            </el-select>
            <el-select v-model="form02.AreaId" style="width:200px;display:inline-block;">
              <el-option
                v-for="(item,index) in form02.areaOption03"
                :label="item.option"
                :value="item.value"
                :key="index"
              ></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="商家地址" size="medium" style="margin:10px 0 0;">
            <el-input v-model.trim="form02.Address" style="width:340px;"></el-input>
            <el-link class="blue-text-bt">请选择经纬度</el-link>
          </el-form-item>
          <el-form-item label="商家电话" size="medium" style="margin:10px 0 0;">
            <el-input v-model.trim="form02.Phone" style="width:200px;"></el-input>
          </el-form-item>
          <el-form-item label="商家轮播图" style="margin:10px 0 0;">
            <el-upload
              class="swiper-banner"
              action="https://jsonplaceholder.typicode.com/posts/"
              list-type="picture-card"
              :limit="5"
              :on-preview="handlePreview"
              :on-remove="handleRemove"
              :file-list="form02.NewAlbums"
            >
              <i class="el-icon-plus" style="line-height:98px;"></i>
            </el-upload>
            <!-- <el-upload
              action="#"
              list-type="picture-card"
              class="swiper-banner"
              :auto-upload="false"
              :limit="5">
                <i slot="default" class="el-icon-plus" style="line-height:98px;"></i>
                <div slot="file" v-for="(item,index) form02.NewAlbums" :key="index">
                  <img
                    class="el-upload-list__item-thumbnail"
                    :src="item.url" alt=""
                  >
                  <span class="el-upload-list__item-actions">
                    <span
                      v-if="!disabled"
                      class="el-upload-list__item-delete"
                      @click="handleRemove(file)"
                    >
                      <i class="el-icon-delete"></i>
                    </span>
                  </span>
                </div>
            </el-upload> -->

            <p class="alert-f">最多5张，推荐尺寸 640*390</p>
          </el-form-item>
          <el-form-item label="营业时间" size="medium" style="margin:10px 0 0;">
            <el-input v-model.trim="form02.ServiceTimeDesc" placeholder="请输入营业时间" style="width:200px;"></el-input>
          </el-form-item>
          <el-row style="margin:20px 0 0 90px;">
            <el-button type="primary" @click="saveShopSetData()">保存</el-button>
            <el-button plain @click="cancelShopSet()">取消</el-button>
          </el-row>
        </el-form>
      </el-tab-pane>

      <el-tab-pane label="入驻意向登记" name="forth">
        <div style="font-size:14px;margin:0 0 10px;">页面地址：/admini/insetstore/2</div>
        <template>
          <el-table
            ref="multipleTable"
            tooltip-effect="dark"
            :data="list03"
            border
            style="width:800px;"
          >
            <el-table-column prop="UserId" label="用户ID" width="80"></el-table-column>
            <el-table-column prop="Name" label="用户昵称" width="120"></el-table-column>
            <el-table-column prop="Name" label="提交姓名" width="120"></el-table-column>
            <el-table-column prop="Phone" label="提交电话" width="120"></el-table-column>
            <el-table-column prop="Reason" label="提交理由"></el-table-column>
            <el-table-column prop="Status" label="状态" width="80"></el-table-column>
            <el-table-column label="操作" width="110">
              <template slot-scope="scope">
                <el-button
                  v-if="scope.row.Status==1||scope.row.Status==0"
                  type="primary"
                  plain
                  size="mini"
                  style="margin:0 0 5px;"
                >设为忽略</el-button>
                <el-button
                  v-if="scope.row.Status==2||scope.row.Status==0"
                  type="primary"
                  plain
                  size="mini"
                  style="margin:0 0 5px;"
                >设为处理</el-button>
              </template>
            </el-table-column>
          </el-table>
        </template>
      </el-tab-pane>
    </el-tabs>

    <!--商家管理修改过期弹框-->
    <el-dialog
      title="修改过期"
      :visible.sync="dialogModifyOutdateSeen"
      :show-close="false"
      center
      width="350px"
      class="formUploadIndexAd"
    >
      <el-form :model="formModifyOutdate" label-width="70px">
        <el-form-item label="开始时间" style="margin:20px 0 5px;" size="medium">
          <el-date-picker v-model="formModifyOutdate.startTime" type="datetime"></el-date-picker>
        </el-form-item>
        <el-form-item label="结束时间" style="margin:0 0 5px;" size="medium">
          <el-date-picker v-model="formModifyOutdate.endeTime" type="datetime"></el-date-picker>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogShopTypeSeen = false">取 消</el-button>
        <el-button type="primary">确 定</el-button>
      </div>
    </el-dialog>

    <!--商家管理修改店主弹框-->
    <el-dialog
      title="修改店主"
      :visible.sync="dialogModifyOwnerSeen"
      :show-close="false"
      center
      width="350px"
      class="formUploadIndexAd"
    >
      <el-form :model="formModifyOwner" label-width="70px">
        <el-form-item label="店主用户" style="margin:20px 0 5px;" size="medium">
          <el-input
            v-model.trim="formModifyOwner.ID"
            oninput="value=value.replace(/[^\d]/g,'')"
            placeholder="请输入用户ID"
            size="medium"
          ></el-input>
        </el-form-item>
        <el-form-item label="流水分成" style="margin:0 0 5px;position:relative" size="medium">
          <el-input
            v-model.number="formModifyOwner.percentage"
            type="tel"
            oninput="value=value.replace(/[^\d]/g,'')"
          ></el-input>
          <div
            style="position:absolute;top:0;right:0;border-radius:4px;text-align:center;width:36px;height:36px;background:#DCDFE6;"
          >%</div>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogShopTypeSeen = false">取 消</el-button>
        <el-button type="primary">确 定</el-button>
      </div>
    </el-dialog>

    <!--商家分类编辑弹框-->
    <el-dialog
      title="分类编辑"
      :visible.sync="dialogShopTypeSeen"
      :show-close="false"
      center
      width="350px"
      class="formUploadIndexAd"
    >
      <el-form label-width="70px">
        <el-form-item label="分类名称" style="margin:20px 0 5px;" size="medium">
          <el-input v-model.trim="form03.TypeName" placeholder="至多4个字" maxlength="4"></el-input>
        </el-form-item>
        <el-form-item label="分类排序" style="margin:0 0 5px;" size="medium">
          <el-input
            v-model.number="form03.Sort"
            type="tel"
            oninput="value=value.replace(/[^\d]/g,'')"
            placeholder="数值越大越靠前"
          ></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogShopTypeSeen = false">取 消</el-button>
        <el-button type="primary" @click="saveShopTypeData()">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>
<script>
import { vueMixins } from '../assets/js/mixins.js'
import '../assets/css/city_backstage.css'
export default {
  name: 'shopManage',
  mixins: [vueMixins], // 注册mixins
  data() {
    return {
      activeName: 'first',
      count: 0, // 数据条数，用来分页
      queryPara: {
        // 用来请求
        cityInfoId: this.$cookie.get('cityInfoId'),
        pageIndex: 1,
        pageSize: 10,
        storeId: '',
        name: '',
        type: '',
        entryStartDate: '',
        entryEndDate: '',
        expireStartDate: '',
        expireEndDate: ''
      },
      list01: [],
      list02: [],
      list03: [],
      form02: {
        StoreName: '',
        StoreType: '',
        typeOptions: [
          { value: '1', option: '好' },
          { value: '2', option: '好2' }
        ],
        ProvinceId: '',
        CityId: '',
        AreaId: '',
        areaOption01: [
          { value: '选项一', option: '广州' },
          { value: '选项二', option: '佛山' },
          { value: '选项三', option: '深圳' }
        ],
        areaOption02: [
          { value: '选项一', option: '广州' },
          { value: '选项二', option: '佛山' },
          { value: '选项三', option: '深圳' }
        ],
        areaOption03: [
          { value: '选项一', option: '广州' },
          { value: '选项二', option: '佛山' },
          { value: '选项三', option: '深圳' }
        ],
        Address: '',
        Phone: '',
        NewAlbums: [],
        ServiceTimeDesc: ''
      },
      form03: {
        Id: 0,
        CityInfoId: 61165,
        TypeName: '',
        Sort: ''
      },
      dialogShopTypeSeen: false,
      dialogModifyOutdateSeen: false,
      dialogModifyOwnerSeen: false,
      dialogModifyTopSeen: false,
      dialogDeleteSeen: false,
      dialogRecommendSeen: false,
      dialogContent: false,
      dialogIndex: '',
      formModifyOutdate: {
        // 修改过期
        startTime: '',
        endeTime: ''
      },
      formModifyOwner: {
        // 修改店主
        ID: '',
        percentage: '10'
      }
    }
  },
  methods: {
    loadData01() {
      // 加载数据
      var self = this
      self.loading = true // 显示加载动画
      self
        .$axios({
          method: 'GET',
          url: '/city/GetStoreList',
          params: self.queryPara
        })
        .then(function(res) {
          if (res.data.code === 1) {
            // 获取数据成功
          } else {
            // 获取数据失败
          }
          console.log(res)
        })
        .catch(function(error) {
          console.log(error)
        })
    },
    loadData02() {
      // 加载数据
      var self = this
      self.loading = true // 显示加载动画
      self
        .$axios({
          method: 'GET',
          url: '/city/GetStoreTypeList',
          params: self.queryPara
        })
        .then(function(res) {
          if (res.data.code === 1) {
            // 获取数据成功
            self.list02 = res.data.obj
          } else {
            // 获取数据失败
          }
          console.log(res)
        })
        .catch(function(error) {
          console.log(error)
        })
    },
    loadData03() {
      // 加载数据
      var self = this
      self.loading = true // 显示加载动画
      self
        .$axios({
          method: 'GET',
          url: '/city/GetIntentionList',
          params: self.queryPara
        })
        .then(function(res) {
          if (res.data.code === 1) {
            // 获取数据成功
          } else {
            // 获取数据失败
          }
          console.log(res)
        })
        .catch(function(error) {
          console.log(error)
        })
    },
    clean() { // 清空条件
      this.queryPara.pageIndex = 1
      this.queryPara.pageSize = 10
      this.queryPara.storeId = ''
      this.queryPara.name = ''
      this.queryPara.type = ''
      this.queryPara.entryStartDate = ''
      this.queryPara.entryEndDate = ''
      this.queryPara.expireStartDate = ''
      this.queryPara.expireEndDate = ''
      this.loadData01()
    },
    search () { // 搜索商家数据
      var self = this
      self.loading = true // 显示加载动画
      self
        .$axios({
          method: 'GET',
          url: '/city/GetStoreList',
          params: self.queryPara
        })
        .then(function(res) {
          if (res.data.code === 1) {
            // 获取数据成功
          } else {
            // 获取数据失败
          }
          console.log(res)
        })
        .catch(function(error) {
          console.log(error)
        })
    },
    showEditShopType(index, row) { // 打开编辑店铺类别弹框
      var self = this
      self.form03.TypeName = row.TypeName
      self.form03.Sort = row.Sort
      self.dialogShopTypeSeen = true// 显示窗口
    },
    saveShopTypeData() { // 保存店铺类别
      var self = this
      if (self.isNullOrEmpty(self.form03.TypeName)) {
        self.$message('分类名称不能为空')
        return
      }
      // 请求数据
      self.$axios({
        method: 'POST',
        url: '/city/AddOrEditStoreType?cityInfoId=' + self.queryPara.cityInfoId,
        data: self.form03
      })
        .then(function (res) {
          if (res.data.code === 1) { // 获取数据成功
            self.$message(res.data.msg)// 弹出提示
            self.loadData02()
          } else { // 获取数据失败
            self.$message(res.data.msg) // 弹出删除失败提示
          }
          console.log(res)
        })
        .catch(function (error) {
          console.log(error)
        })
      self.dialogShopTypeSeen = false
    },
    delShopType(index, row) {
      // 商家类别
      var self = this
      var str = '删除该分类后，该分类相关的店铺会归为无分类?'
      this.$confirm(str, '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        self.$axios({
          method: 'GET',
          url: '/city/UpdateStoreTypeStatus',
          params: { cityInfoId: self.queryPara.cityInfoId, id: row.Id, status: -1 }// 对象
        })
          .then(function (res) {
            if (res.data.code === 1) { // 获取数据成功
              self.list02.splice(index, 1) // 接口返回删除成功后，在删除本地的数据
            } else { // 获取数据失败
              self.$message(res.data.msg) // 弹出删除失败提示
            }
            console.log(res)
          })
      }).catch(() => {
      })
    },
    saveShopSetData() { // 保存录入商家

    },
    // handlePictureCardPreview(file) {
    //   this.form02.dialogImageUrl = file.url
    //   this.dialogVisible = true
    // },
    // handleDownload(file) {
    //   console.log(file)
    // },
    handleRemove(file, NewAlbums) {
      console.log(file, NewAlbums)
    },
    handlePreview(file) {
      console.log(file)
    },
    handleClick: function(event) {
      if (event.index === '1') {
        this.loadData02()
      }
    },
    OKBtn: function(index) {
      var self = this
      self.dialogRecommendSeen = false
      index = self.dialogContent
      self.table[self.dialogIndex].recommend = true
    }
  },
  mounted: function() {},
  created: function() {
    this.loadData01()
    this.loadData02()
    this.loadData03()
  }
}
</script>
