<template>
    <div class="iframe_body">
        <el-form :inline="true" :model="form" class="demo-form-inline table-serch">
            <el-form-item label="用户名(ID)：" size="small" style="margin:0">
                <el-input v-model="form.userID" placeholder="请输入用户名或ID" style="width:180px;"></el-input>
            </el-form-item>
            <el-form-item label="电话：" size="small" style="margin:0 0 0 10px">
                <el-input v-model="form.tel" placeholder="请输入电话" style="width:180px;"></el-input>
            </el-form-item>
            <el-button size="small">清空条件</el-button>
            <el-button type="primary" size="small" style="padding:9px 30px;">搜索</el-button>
        </el-form>

        <!--表单-->
        <template>
            <el-table ref="multipleTable" :data="list" tooltip-effect="dark" border style="width:640px;margin:10px 0 0;">
                <el-table-column prop="img" label="头像" width="70">
                    <template slot-scope="scope">
                        <img :src="scope.row.img" style="display:block;width:50px;">
                    </template>
                </el-table-column>
                <el-table-column prop="userID" label="用户名(ID)" show-overflow-tooltip></el-table-column>
                <el-table-column prop="tel" label="电话" width="120"></el-table-column>
                <el-table-column prop="userTitle" label="用户身份" width="120"></el-table-column>
                <el-table-column label="操作" width="120" >
                    <el-button type="primary" plain size="mini">评论记录</el-button>
                </el-table-column>
            </el-table>
        </template>

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
    </div>
</template>

<script>
import { vueMixins } from '../assets/js/mixins.js'
import '../assets/css/city_backstage.css'
export default{
  name: 'userManage',
  mixins: [vueMixins], // 注册mixins
  data() {
    return {
      count: 0, // 数据条数，用来分页
      queryPara: {
        // 用来请求
        cityInfoId: this.$cookie.get('cityInfoId'),
        pageIndex: 1,
        pageSize: 10
      },
      form: {
        userID: '',
        tel: ''
      },
      list: []
    }
  }

}
</script>
