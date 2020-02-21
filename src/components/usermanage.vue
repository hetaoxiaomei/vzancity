<template>
    <div class="iframe_body">
        <el-form :inline="true" :model="formInline" class="demo-form-inline table-serch">
            <el-form-item label="用户名(ID)：" size="small" style="margin:0">
                <el-input v-model="formInline.userID" placeholder="请输入用户名或ID" size="small" style="width:180px;"></el-input>
            </el-form-item>
            <el-form-item label="电话：" size="small" style="margin:0 0 0 10px">
                <el-input v-model="formInline.tel" placeholder="请输入电话" size="small" style="width:180px;"></el-input>
            </el-form-item>
            <el-row style="display:inline-block;margin:0 0 0 10px">
                <el-button size="small">清空条件</el-button>
                <el-button type="primary" size="small" style="padding:9px 30px;">筛选</el-button>
            </el-row>
        </el-form>

        <!--表单-->
        <template>
            <el-table ref="multipleTable" :data="tableUser" tooltip-effect="dark" style="width:640px;border: 1px solid #EBEEF5;border-bottom: 0;border-right:0;" @selection-change="handleSelectionChange">
                <el-table-column prop="img" label="头像" width="70">
                    <template slot-scope="scope">
                        <img :src="scope.row.img" style="display:block;width:50px;">
                    </template>
                </el-table-column>
                <el-table-column prop="userID" label="用户名(ID)" show-overflow-tooltip></el-table-column>
                <el-table-column prop="tel" label="电话" width="120"></el-table-column>
                <el-table-column prop="userTitle" label="用户身份" width="120"></el-table-column>
                <el-table-column label="操作" width="120" >
                    <template slot-scope="scope">
                        <el-button type="primary" plain size="mini">评论记录</el-button>
                    </template>
                </el-table-column>
            </el-table>
        </template>

        <!--分页-->
        <template>
            <div class="block" style="margin:20px 0 0;">
                <el-pagination
                    @size-change="handleSizeChange"
                    @current-change="handleCurrentChange"
                    :current-page="currentPage4"
                    :page-sizes="[100, 200, 300, 400]"
                    :page-size="100"
                    layout="total, sizes, prev, pager, next, jumper"
                    :total="400">
                </el-pagination>
            </div>
        </template>
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
      formInline: {
        userID: '',
        tel: ''
      },
      tableUser: [
        {
          img: '',
          userID: '风有力（123123456）',
          tel: '12345678912（已验证）',
          userTitle: '普通用户',
          sort: '55'
        }
      ]
    }
  }

}
</script>
