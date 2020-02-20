<template>
  <div class="iframe_body">
    <el-tabs v-model="activeName" type="card" @tab-click="handleClick">
      <el-tab-pane label="全部" name="first">
        <el-form :inline="true" :model="formInline" class="demo-form-inline table-serch">
          <el-form-item label="商品名称：" size="small" placeholder="请输入商品名称">
            <el-input v-model="formInline.content" size="small" style="width:180px;"></el-input>
          </el-form-item>
          <el-form-item label="商品类别：" size="small" placeholder="请选择商品标签" style="margin:0 0 0 10px">
            <el-select v-model="formInline.stars" style="width:180px;">
              <el-option v-for="(item,index) in formInline.starOptions" :label="item.option" :value="item.value" :key="index"></el-option>
            </el-select>
          </el-form-item>
          <el-button type="primary" size="small" style="margin:0 0 0 10px;padding:9px 30px;">搜索</el-button>
          <el-button size="small" style="padding:9px 30px;">导出</el-button>
        </el-form>
        <div style="margin:0 0 10px;">
          <a>
            <el-button type="primary" size="medium">批量通过</el-button>
          </a>
          <a href="commodity-type.html">
            <el-button type="primary" size="medium" style="margin:0 0 0 10px;">商品类别编辑</el-button>
          </a>
        </div>

        <!--表单-->
        <template>
          <el-table
            ref="multipleTable"
            :data="list"
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
            <el-table-column prop="Name" label="商品名称"></el-table-column>
            <el-table-column prop="Price" label="价格" width="80"></el-table-column>
            <el-table-column prop="Stock" label="剩余库存" width="80"></el-table-column>
            <el-table-column prop="SalesNum" label="销量" width="80"></el-table-column>
            <el-table-column prop="BrowseNum" label="浏览量" width="80"></el-table-column>
            <el-table-column prop="AddTime" label="创建时间" width="100"></el-table-column>
            <el-table-column label="状态" width="80">
              <template slot-scope="scope">
                <div
                  size="mini"
                  style="color:#F56C6C;"
                  v-if="scope.row.Status==0 && scope.row.IsSell!=1"
                >待审核</div>
                <div
                  size="mini"
                  style="color:#67C23A;;"
                  v-else-if="scope.row.Status==1 && scope.row.IsSell!=1"
                >审核通过</div>
                <div size="mini" style="color:#67C23A;" v-if="scope.row.IsSell==1">上架</div>
                <div size="mini" style="color:#F56C6C;" v-else>下架</div>
              </template>
            </el-table-column>
            <el-table-column prop="Sort" label="排序" width="80"></el-table-column>
            <el-table-column label="操作" width="150">
              <template slot-scope="scope">
                <a :href="'/evaluatemanage.html?id='+scope.row.Id">
                  <el-button type="primary" plain size="mini" style="margin:0 0 5px;">编辑</el-button>
                </a>
                <el-button
                  type="primary"
                  plain
                  size="mini"
                  style="margin:0 0 5px;"
                  @click="Sort(scope.row)"
                >排序</el-button>
                <el-button
                  type="danger"
                  plain
                  size="mini"
                  style="margin:0 0 5px;"
                  v-if="scope.row.IsSell==0"
                >上架</el-button>
                <el-button
                  type="danger"
                  plain
                  size="mini"
                  style="margin:0 0 5px;"
                  v-else
                  @click="offShelves(scope.row)"
                >下架</el-button>
                <el-button
                  type="success"
                  plain
                  size="mini"
                  style="margin:0 0 5px;"
                  v-show="scope.row.Status==0"
                >审核通过</el-button>
                <el-button type="primary" plain size="mini" style="margin:0 0 5px;">查看商品</el-button>
                <a v-show="scope.row.Status==1" :href="'/evaluatemanage.html?id='+scope.row.Id">
                  <el-button type="primary" plain size="mini" style="margin:0 0 5px;">用户评价</el-button>
                </a>
              </template>
            </el-table-column>
          </el-table>
        </template>
      </el-tab-pane>
      <el-tab-pane label="审核中" name="second"></el-tab-pane>
      <el-tab-pane label="已上架" name="third"></el-tab-pane>
      <el-tab-pane label="已下架" name="forth"></el-tab-pane>
    </el-tabs>

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

    <!--商品排序弹框-->
    <el-dialog
      title="排序设置"
      :visible.sync="dialogSortSeen"
      :show-close="false"
      center
      width="350px"
      class="formUploadIndexAd"
    >
      <el-form label-width="40px">
        <el-form-item label="排序" style="margin:0 0 5px;" size="medium">
          <el-input
            v-model.number="editRow.Sort"
            type="tel"
            oninput="value=value.replace(/[^\d]/g,'')"
            placeholder="数值越大越靠前"
          ></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogSortSeen=false">取 消</el-button>
        <el-button type="primary" @click="saveSortData()">确 定</el-button>
      </div>
    </el-dialog>

    <!--小程序二维码弹框-->
    <el-dialog title :visible.sync="dialogScanQr" width="250px" center>
      <p style="font-size:16px;font-weight:bold;text-align:center">
        微信扫一扫
        <br />打开小程序
      </p>
      <img src class style="width:120px;display:block;margin:0 auto;padding:20px 0 30px;" />
    </el-dialog>
  </div>
</template>
<script>
import {vueMixins} from '../assets/js/mixins.js'
import '../assets/css/city_backstage.css'
export default {
  name: 'commodityManage',
  mixins: [vueMixins], // 注册mixins
  data () {
    return {
      count: 0, // 数据条数，用来分页
      dialogSortSeen: false,
      editRow: {
        Sort: '',
        Id: 0
      },
      queryPara: {// 用来请求
        cityInfoId: 1317,
        areaCode: 110107,
        pageIndex: 1,
        pageSize: 10,
        IsSell: '',
        Status: ''
      },
      activeName: 'first',
      dialogScanQr: false,
      dialogRecommendSeen: false,
      dialogContent: false,
      dialogIndex: '',
      formInline: {
        content: '',
        title: '',
        evaluateID: '',
        stars: '',
        starOptions: [
          {value: '1', option: '五星'},
          {value: '2', option: '四星'},
          {value: '3', option: '三星'},
          {value: '4', option: '二星'},
          {value: '5', option: '一星'}
        ],
        date: ''
      },
      list: [],
      formCommoditySort: {sort: ''}
    }
  },
  methods: {
    loadData() { // 加载数据
      var self = this
      self.loading = true// 显示加载动画
      // 请求数据
      // $.post(self.config.apiUrl+"/city/GetGoodsList", this.queryPara, function (res) {
      // if (res.code === 1) {//获取数据成功
      //     vm.list = [];
      //     vm.list = res.data || [];
      //     vm.count = res.count;
      // } else {//获取数据失败
      //     vm.count = 0;
      // }
      // vm.loading = false;
      // });

      // 此处模拟上面的根据接口成功获取数据
      var list = [
        {
          ImgUrl: 'https://i.vzan.cc/image/jpg/2017/12/18/1913525ddfba50b89a435fa0bacf1f5971c368.jpg@!640x210',
          Name: '小陈',
          Price: '125',
          Stock: '10',
          SalesNum: '12',
          BrowseNum: '52',
          AddTime: '2019-12-31 12:40:50',
          Status: 1,
          IsSell: 1,
          Sort: '52'
        },
        {
          ImgUrl: 'https://i.vzan.cc/image/jpg/2017/12/18/1913525ddfba50b89a435fa0bacf1f5971c368.jpg@!640x210',
          Name: '小陈',
          Price: '125',
          Stock: '10',
          SalesNum: '12',
          BrowseNum: '52',
          AddTime: '2019-12-31 12:40:50',
          Status: 0,
          IsSell: 0,
          Sort: '52'
        },
        {
          ImgUrl: 'https://i.vzan.cc/image/jpg/2017/12/18/1913525ddfba50b89a435fa0bacf1f5971c368.jpg@!640x210',
          Name: '小陈',
          Price: '125',
          Stock: '10',
          SalesNum: '12',
          BrowseNum: '52',
          AddTime: '2019-12-31 12:40:50',
          Status: 1,
          IsSell: 0,
          Sort: '52'
        }
      ]
      self.list = list
      self.loading = false// 关闭加载动画
      self.count = 11
    },
    handleClick() { // 切换导航
      var self = this
      if (self.activeName === 'first') {
        self.queryPara.IsSell = ''
        self.queryPara.Status = ''
      } else if (self.activeName === 'second') {
        self.queryPara.IsSell = 0
        self.queryPara.Status = 0
      } else if (self.activeName === 'third') {
        self.queryPara.IsSell = 1
      } else {
        self.queryPara.IsSell = 0
      }
    },
    switchPage(type, id) { // 跳转页面
      if (type === 1) {
        location.href = `http://www.baidu.com`// 跳转页面
      }
    },
    convertValue(val) { // 转换数据
      if (val === 0) {
        return '待审核'
      }
      if (val === -1) {
        return '删除'
      }
      return '正常'
    },
    delComment(index, item) { // 删除评论
      var self = this
      var str = `你确定要删除该评论?`
      this.$confirm(str, '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        // 请求数据
        // $.post("此处请输入接口链接，请询问后端开发", this.queryPara, function (res) {
        //    if (res.code === 1) {//删除数据成功
        //       self.list.splice(index, 1);//接口返回删除成功后，在删除本地的数据，splice是删除
        //    } else {//删除数据失败
        //        self.$message(res.msg);//弹出删除失败提示
        //    }
        // });

        // 此处模拟上面的根据接口删除数据
        self.list.splice(index, 1)// 删除本地数据
        self.$message('删除成功！')// 弹出提示
      }).catch(() => {

      })
    },
    showEditDialog(index, item) { // 显示修改窗口
      var self = this
      self.editItem = item// 赋值给当前修改数据
      self.dialogVisible = true// 显示窗口
    },
    choiceEvent(val) { // 下拉框选择事件
      console.log(val)
    },
    saveEditData() { // 保存修改数据
      var self = this
      // 请求数据
      // $.post("此处请输入接口链接，请询问后端开发", self.editItem, function (res) {
      //    if (res.code === 1) {//修改数据成功
      //       self.$message('修改成功！');//弹出提示
      //    } else {//修改数据失败
      //        self.$message(res.msg);//弹出删除失败提示
      //        setTimeout(function () {
      //            location.reload();//刷新页面
      //        }, 2000)
      //    }
      //    self.dialogVisible = false;//关闭窗口
      // });

      // 此处模拟上面的根据接口修改数据成功
      self.$message('修改成功！')// 弹出提示
      self.dialogVisible = false// 关闭窗口
    },
    showAddDialog() { // 显示修改窗口
      var self = this
      // 初始化addItem数据
      self.addItem = {
        Id: 0,
        Name: '',
        Content: '',
        State: 0
      }
      self.dialogVisible2 = true// 显示窗口
    },
    saveAddData() { // 保存修改数据
      var self = this
      // 请求数据
      // $.post("此处请输入接口链接，请询问后端开发", self.editItem, function (res) {
      //    if (res.code === 1) {//添加数据成功
      //        setTimeout(function () {
      //            location.reload();//刷新页面
      //        }, 2000)
      //    } else {//修改数据失败
      //        self.$message(res.msg);//弹出删除失败提示
      //    }
      //    self.dialogVisible2 = false;//关闭窗口
      // });

      // 此处模拟上面的根据接口添加数据成功
      self.addItem.Id = 11
      self.addItem.CreateDate = '2020-02-08 08:00:00'
      self.list.push(self.addItem)
      self.$message('添加成功！')// 弹出提示
      self.dialogVisible2 = false// 关闭窗口
    },

    Sort(row) { // 排序
      var self = this
      self.editRow.Id = row.Id
      self.editRow.Sort = row.Sort
      self.dialogSortSeen = true
    },
    saveSortData() { // 保存排序
      var self = this

      // 请求数据
      // $.post(self.webconfig.domain+'/city/UpdateGoodsSort', self.editRow, function (res) {
      //    if (res.code === 1) {//添加数据成功
      //        setTimeout(function () {
      //            location.reload();//刷新页面
      //        }, 2000)
      //    } else {//修改数据失败
      //        self.$message(res.msg);//弹出删除失败提示
      //    }
      //    self.dialogSortSeen = false;//关闭窗口
      // });

      // 此处模拟上面的根据接口修改数据成功
      self.$message('修改成功！')// 弹出提示
      self.dialogSortSeen = false// 关闭窗口
    },
    offShelves(row) { // 下架
      var self = this
      var str = '你确定要下架该商品?'
      this.$confirm(str, '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        // 请求数据
        // $.post(self.webconfig.domain+'/city/UpdateGoodsSell', this.queryPara, function (res) {
        //    if (res.code === 1) {//下架数据成功
        //     self.$message('下架成功！');
        //    } else {//下架数据失败
        //        self.$message(res.msg);//弹出下架失败提示
        //    }
        // });

        // 此处模拟上面的根据接口删除数据
        self.$message('下架成功！')// 弹出提示
        loadData()
      }).catch(() => {

      })
    }

  },
  mounted: function() {},
  created: function () {
    this.loadData()
  }
}
</script>
