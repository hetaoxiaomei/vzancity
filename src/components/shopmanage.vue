<template>
  <div class="iframe_body">
    <el-tabs v-model="activeName" type="card" @tab-click="handleClick">
      <el-tab-pane label="商家管理" name="first">
        <el-form :inline="true" :model="formInline" class="demo-form-inline table-serch">
          <el-form-item label="商家ID：" size="small" style="margin:0">
            <el-input v-model="formInline.userID" placeholder="请输入商家ID" style="width:180px;"></el-input>
          </el-form-item>
          <el-form-item label="商家名称：" size="small" style="margin:0 0 0 10px">
            <el-input v-model="formInline.Name" placeholder="请输入商家名称" style="width:180px;"></el-input>
          </el-form-item>
          <el-form-item label="商家分类：" size="small" style="margin:0 0 0 10px">
            <el-select v-model="formInline.url" style="width:100%">
              <el-option
                v-for="(item,index) in formInline.urlOptions"
                :label="item.option"
                :value="item.value"
                :key="index"
              ></el-option>
            </el-select>
          </el-form-item>
          <div style="margin:10px 0 0 0;">
            <div style="display:inline-block;">
              <span class="demonstration">入驻时间：</span>
              <el-date-picker
                unlink-panels="false"
                v-model="formInline.value1"
                type="daterange"
                range-separator="至"
                size="small"
              ></el-date-picker>
            </div>
            <div style="display:inline-block;margin:0 0 0 10px">
              <span class="demonstration">过期时间：</span>
              <el-date-picker
                unlink-panels="false"
                v-model="formInline.value2"
                type="daterange"
                range-separator="至"
                size="small"
              ></el-date-picker>
            </div>
            <el-row style="display:inline-block;margin:0 0 0 10px">
              <el-button size="small">清空条件</el-button>
              <el-button type="primary" size="small" style="padding:9px 30px;">筛选</el-button>
            </el-row>
          </div>
        </el-form>
        <div style="margin:20px 0 10px;">
          <el-button type="primary" size="medium" @click="dialogAdFormVisible=true">新增商家</el-button>
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
          <el-button type="primary" size="medium">新增商家</el-button>
        </div>
        <!--表单-->
        <template>
          <el-table
            ref="multipleTable"
            tooltip-effect="dark"
            border
            style="width:700px;border-bottom: 0;border-right:0;"
            @selection-change="handleSelectionChange"
          >
            <el-table-column prop="Id" label="分类ID" width="120"></el-table-column>
            <el-table-column prop="TypeName" label="分类名称" width="120"></el-table-column>
            <el-table-column prop="Url" label="商家分类列表地址" show-overflow-tooltip></el-table-column>
            <el-table-column prop="Sort" label="排序" width="80"></el-table-column>
            <el-table-column label="操作" width="150">
              <template slot-scope="scope">
                <a>
                  <el-button type="primary" plain size="mini">编辑</el-button>
                </a>
                <a>
                  <el-button type="danger" plain size="mini">删除</el-button>
                </a>
              </template>
            </el-table-column>
          </el-table>
        </template>
      </el-tab-pane>

      <el-tab-pane label="录入商家" name="third">
        <el-form :model="formInputshop" label-width="90px">
          <el-form-item label="商家名称" style="margin:10px 0 0;" size="medium">
            <el-input v-model.trim="formInputshop.name" placeholder="最多20个字" style="width:340px;"></el-input>
          </el-form-item>
          <el-form-item label="商家分类" size="medium" style="margin:10px 0 0;">
            <el-select v-model="formInputshop.types" style="width:200px">
              <el-option
                v-for="(item,index) in formInputshop.typeOptions"
                :label="item.option"
                :value="item.value"
                :key="index"
              ></el-option>
            </el-select>
            <el-link style="position:relative;line-height:1;margin:0 0 0 5px;color:#409EFF;">添加分类</el-link>
          </el-form-item>
          <el-form-item label="商家区域" size="medium" style="margin:10px 0 0;">
            <el-select v-model="formInputshop.area" style="width:200px;display:inline-block;">
              <el-option
                v-for="(item,index) in formInputshop.areaOption01"
                :label="item.option"
                :value="item.value"
                :key="index"
              ></el-option>
            </el-select>
            <el-select v-model="formInputshop.area" style="width:200px;display:inline-block;">
              <el-option
                v-for="(item,index) in formInputshop.areaOption02"
                :label="item.option"
                :value="item.value"
                :key="index"
              ></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="商家地址" size="medium" style="margin:10px 0 0;">
            <el-input v-model.trim="formInputshop.address" style="width:340px;"></el-input>
            <el-link style="position:relative;line-height:1;margin:0 0 0 5px;color:#409EFF;">请选择经纬度</el-link>
          </el-form-item>
          <el-form-item label="商家电话" size="medium" style="margin:10px 0 0;">
            <el-input v-model.trim="formInputshop.tel" style="width:200px;"></el-input>
          </el-form-item>
          <el-form-item label="商家轮播图" style="margin:10px 0 0;">
            <el-upload
              class="swiper-banner"
              :on-preview="handlePictureCardPreview"
              action="https://jsonplaceholder.typicode.com/posts/"
              list-type="picture-card"
              :limit="5"
            >
              <i class="el-icon-plus" style="line-height:98px;"></i>
            </el-upload>
            <el-dialog :visible.sync="dialogVisible">
              <img width="100%" :src="formInputshop.dialogImageUrl" alt />
            </el-dialog>
            <p style="color:#909399;font-size:12px;line-height:1;margin:10px 0 0;">最多5张，推荐尺寸 640*390</p>
          </el-form-item>
          <el-form-item label="营业时间" size="medium" style="margin:10px 0 0;">
            <el-input v-model.trim="formInputshop.businessHours" style="width:200px;"></el-input>
          </el-form-item>
          <el-row style="margin:20px 0 0 90px;">
            <el-button type="primary">保存</el-button>
            <el-button plain>取消</el-button>
          </el-row>
        </el-form>
      </el-tab-pane>

      <el-tab-pane label="入驻意向登记" name="forth">
        <div style="font-size:14px;margin:0 0 10px;">页面地址：/admini/insetstore/2</div>
        <template>
          <el-table
            ref="multipleTable"
            tooltip-effect="dark"
            border
            style="width:800px;border-bottom: 0;border-right:0;"
            @selection-change="handleSelectionChange"
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
        <el-button type="primary" @click="submitForm('ruleForm')">确 定</el-button>
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
        <el-button type="primary" @click="submitForm('ruleForm')">确 定</el-button>
      </div>
    </el-dialog>

    <!--商家管理状态变更弹框-->
    <el-dialog
      title="状态变更"
      :visible.sync="dialogModifyTopSeen"
      :show-close="false"
      width="250px"
      center
    >
      <p style="text-align:center;padding:10px 0;">{{dialogModifyTopSeenContent?'状态已修改为置顶':'已取消置顶'}}</p>
      <span slot="footer" class="dialog-footer">
        <el-button type="primary" @click="OKBtn()">确 定</el-button>
      </span>
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
      <el-form :model="formShopType" label-width="70px">
        <el-form-item label="分类名称" style="margin:20px 0 5px;" size="medium">
          <el-input v-model.trim="formShopType.name" placeholder="请输入分类名称"></el-input>
        </el-form-item>
        <el-form-item label="分类排序" style="margin:0 0 5px;" size="medium">
          <el-input
            v-model.number="formShopType.sort"
            type="tel"
            oninput="value=value.replace(/[^\d]/g,'')"
            placeholder="数值越大越靠前"
          ></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogShopTypeSeen = false">取 消</el-button>
        <el-button type="primary" @click="submitForm('ruleForm')">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>
<script>
import { vueMixins } from '../assets/js/mixins.js'
import '../assets/css/city_backstage.css'
export default {
  name: 'commodityManage',
  mixins: [vueMixins], // 注册mixins
  data: function() {
    return {
      activeName: 'first',
      count: 0, // 数据条数，用来分页
      queryPara: {
        // 用来请求
        cityInfoId: 0,
        pageIndex: 1,
        pageSize: 10
      },
      list01: [],
      list02: [],
      list03: [],
      dialogVisible: false,
      dialogModifyOutdateSeen: false,
      dialogModifyOwnerSeen: false,
      dialogModifyTopSeen: false,
      dialogShopTypeSeen: false,
      dialogDeleteSeen: false,
      dialogModifyTopSeenContent: '',
      dialogRecommendSeen: false,
      dialogContent: false,
      dialogIndex: '',
      formInline: {
        // 搜索筛选
        userID: '',
        Name: '',
        url: '',
        urlOptions: [
          {
            value: '1',
            option: '好'
          }
        ],
        value1: '',
        value2: ''
      },
      formModifyOutdate: {
        // 修改过期
        startTime: '',
        endeTime: ''
      },
      formModifyOwner: {
        // 修改店主
        ID: '',
        percentage: '10'
      },
      formShopType: {
        // 商家分类编辑
        name: '',
        sort: ''
      },
      formInputshop: {
        // 录入商家
        name: '',
        type: '美食',
        typeOptions: [
          { value: '选项一', option: '美食' },
          { value: '选项二', option: '零食' },
          { value: '选项三', option: '教育' }
        ],
        area: '',
        areaOption01: [
          { value: '选项一', option: '广州' },
          { value: '选项二', option: '佛山' },
          { value: '选项三', option: '深圳' }
        ],
        areaOption02: [
          { value: '选项一', option: '荔湾' },
          { value: '选项二', option: '天河' },
          { value: '选项三', option: '番禺' }
        ],
        address: '',
        tel: '',
        dialogImageUrl: '',
        businessHours: ''
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
    handleRemove(file) {
      console.log(file)
    },
    handlePictureCardPreview(file) {
      this.formInputshop.dialogImageUrl = file.url
      this.dialogVisible = true
    },
    handleDownload(file) {
      console.log(file)
    },
    handleClick: function(index) {
      var self = this
      if (self.table[index].recommend === true) {
        self.dialogContent = true
      } else {
        self.dialogContent = false
      }
      self.dialogRecommendSeen = true
      self.dialogIndex = index
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
    // this.loadData01()
    // this.loadData02()
    // this.loadData03()
  }
}
</script>
