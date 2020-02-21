<template>
    <div class="iframe_body">
        <div style="margin:0 0 10px;">
            <el-button type="primary" size="medium" @click="showAddDialog()">添加自定义商品类别</el-button>
            <router-link to="/commoditymanage">
                <el-button size="medium" plain style="padding:10px 40px;margin:0 0 0 10px;">取消</el-button>
                <div class="alert-f" style="margin: 5px 0px;">自定义商品类别最多创建10个</div>
            </router-link>
        </div>

        <!--表单-->
        <template>
            <el-table ref="multipleTable" :data="list" tooltip-effect="dark" border style="width:1000px;" @selection-change="handleSelectionChange">
                <el-table-column prop="GoodsType" label="商品类别"></el-table-column>
                <el-table-column prop="Name" label="名称"></el-table-column>
                <el-table-column prop="Type" label="类型" width="120">
                    <template slot-scope="scope">
                        <span v-if="scope.row.Type==0">默认类别</span>
                        <span v-else>自定义类别</span>
                    </template>
                </el-table-column>
                <el-table-column prop="sale" label="商品数" width="120"></el-table-column>
                <el-table-column prop="AddTime" label="创建时间" width="160"></el-table-column>
                <el-table-column prop="SortNum" label="排序" width="120"></el-table-column>
                <el-table-column label="操作" width="200">
                    <template slot-scope="scope">
                        <el-button type="primary" plain size="mini" style="margin:0 0 5px;" @click="showEditDialog(scope.row)">编辑</el-button>
                        <el-button type="primary" plain size="mini" style="margin:0 0 5px;" @click="showSortDialog(scope.row)">排序</el-button>
                        <el-button type="danger" plain size="mini" style="margin:0 0 5px;" v-show="scope.row.Type==1" @click="delType(scope.$index, scope.row)">删除</el-button>
                    </template>
                </el-table-column>
            </el-table>
        </template>

        <!--类别编辑-->
        <el-dialog title="类别编辑" :visible.sync="dialogCommodityTypeSeen" :show-close="false" center width="350px" class="formUploadIndexAd">
            <el-form :model="addItem" label-width="70px">
                <el-form-item label="商品类别" style="margin:20px 0 5px;" size="medium">
                    <el-input v-model.trim="addItem.GoodsType" :disabled="addItem.Type==0" placeholder="最多输入5字"></el-input>
                </el-form-item>
                <el-form-item label="名称" style="margin:0 0 5px;" size="medium">
                    <el-input v-model.number="addItem.Name" placeholder="最多输入5字"></el-input>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="dialogCommodityTypeSeen= false">取 消</el-button>
                <el-button type="primary" @click="saveAddTypeData()">确 定</el-button>
            </div>
        </el-dialog>

        <!--排序弹框-->
        <el-dialog title="排序设置" :visible.sync="dialogSortSeen" :show-close="false" center width="350px" class="formUploadIndexAd">
            <el-form label-width="40px">
                <el-form-item label="排序" style="margin:0 0 5px;" size="medium">
                    <el-input v-model.number="editRow.Sort" type='tel' oninput="value=value.replace(/[^\d]/g,'')" placeholder="数值越大越靠前"></el-input>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="dialogSortSeen = false">取 消</el-button>
                <el-button type="primary"  @click="saveSortData()">确 定</el-button>
            </div>
        </el-dialog>

    </div>
</template>
<script>
import { vueMixins } from '../assets/js/mixins.js'
import '../assets/css/city_backstage.css'
export default{
  name: 'commodityType',
  mixins: [vueMixins], // 注册mixins
  data() {
    return {
      dialogCommodityTypeSeen: false,
      dialogSortSeen: false,
      list: [],
      addItem: {},
      editRow: {
        Sort: '',
        Id: 0
      }
    }
  },
  methods: {
    loadData() { // 加载数据
      var self = this
      self.loading = true// 显示加载动画
      // 请求数据
      // $.post(self.webconfig.domain+"/city/GetGoodsList", this.queryPara, function (res) {
      //    if (res.code === 1) {//获取数据成功
      //        vm.list = [];
      //        vm.list = res.data || [];
      //        vm.count = res.count;
      //    } else {//获取数据失败
      //        vm.count = 0;
      //    }
      //    vm.loading = false;
      // });

      // 此处模拟上面的根据接口成功获取数据
      var list = [
        {
          Id: 10,
          GoodsType: '美食',
          Name: '开心厨房',
          Type: 0,
          sale: '12',
          AddTime: '2020-02-08 08:30:00',
          SortNum: '53',
          Status: 1
        },
        {
          Id: 11,
          GoodsType: '美食',
          Name: '开心厨房',
          Type: 0,
          sale: '12',
          AddTime: '2020-02-08 08:30:00',
          SortNum: '52',
          Status: 1
        },
        {
          Id: 12,
          GoodsType: '美食',
          Name: '开心厨房',
          Type: 1,
          sale: '12',
          AddTime: '2020-02-08 08:30:00',
          SortNum: '51',
          Status: -1
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

    choiceEvent(val) { // 下拉框选择事件
      console.log(val)
    },
    saveEditData() { // 保存修改数据
      var self = this
      // 请求数据
      // $.post("此处请输入接口链接，请询问后端开发", self.addItem, function (res) {
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

    showAddDialog() { // 添加自定义商品类别
      var self = this
      // 初始化addItem数据
      self.addItem = {
        GoodsType: '',
        Name: '',
        Type: 1
      }
      self.dialogCommodityTypeSeen = true
    },

    saveAddTypeData() { // 保存添加自定义商品类别
      var self = this
      // 请求数据
      // $.post(self.webconfig.domain+/city/UpdateGoodsTypeName, self.addItem, function (res) {
      //    if (res.code === 1) {//添加数据成功
      //        setTimeout(function () {
      //            location.reload();//刷新页面
      //        }, 2000)
      //    } else {//修改数据失败
      //        self.$message(res.msg);//弹出删除失败提示
      //    }
      //    self.dialogCommodityTypeSeen = false;//关闭窗口
      // });

      // 此处模拟上面的根据接口添加数据成功
      // self.addItem.Type= 1;
      self.list.push(self.addItem)
      self.$message('添加成功！')// 弹出提示
      self.dialogCommodityTypeSeen = false// 关闭窗口
    },

    showEditDialog(row) { // 编辑添加自定义商品类别
      var self = this
      self.addItem = row
      self.dialogCommodityTypeSeen = true
    },

    showSortDialog(row) { // 编辑排序
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
    delType(index, row) { // 删除自定义类别
      var self = this
      var str = '你确定要删除该商品类别?'
      this.$confirm(str, '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        // 请求数据
        // $.post(self.webconfig.domain+/city/DelGoodsType,{}, function (res) {
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
    }

  },
  mounted: function() {},
  created: function () {
    this.loadData()
  }

}
</script>
