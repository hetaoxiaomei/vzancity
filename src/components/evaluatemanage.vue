<template>
    <div class="iframe_body">
        <el-form :inline="true" :model="formInline" class="demo-form-inline table-serch">
            <el-form-item label="评论内容：" size="small" style="margin:0 0 0 10px">
                <el-input v-model="formInline.content" size="small" style="width:180px;"></el-input>
            </el-form-item>
            <el-form-item label="活动标题：" size="small" style="margin:0 0 0 10px">
                <el-input v-model="formInline.title" size="small" style="width:180px;"></el-input>
            </el-form-item>
            <el-form-item label="评星：" size="small" style="margin:0 0 0 10px">
                <el-select v-model="formInline.stars" style="width:180px">
                    <el-option v-for="(item,index) in formInline.starOptions" :key="index" :label="item.option" :value="item.value">
                    </el-option>
                </el-select>
            </el-form-item>
            <div style="margin:10px 0 0;">
                <el-form-item label="评论时间：" size="small">
                    <el-date-picker unlink-panels=false
                        v-model="date"
                        type="daterange"
                        range-separator="至" size="small">
                    </el-date-picker>
                </el-form-item>
                <el-row style="display:inline-block;margin:0 0 0 10px">
                    <el-button size="small">清空条件</el-button>
                    <el-button type="primary" size="small" style="padding:9px 30px;">搜索</el-button>
                </el-row>
            </div>
        </el-form>

        <!--表单-->
        <template>
            <el-table ref="multipleTable" :data="list" tooltip-effect="dark" border style="width:100%;border-bottom: 0;border-right:0;" @selection-change="handleSelectionChange">
                <el-table-column prop="Id" label="评论ID" width="80"></el-table-column>
                <el-table-column prop="Content" label="评论内容" show-overflow-tooltip></el-table-column>
                <el-table-column prop="AttachmentList" label="缩略图">
                    <template slot-scope="scope">
                        <img :src="item.src" v-for="(item,index) in scope.row.AttachmentList" :key="index" class="thumbnail">
                    </template>
                </el-table-column>
                <el-table-column prop="Star" label="评星" width="150">
                    <template slot-scope="scope">
                        <el-rate v-model="scope.row.Star" disabled disabled-void-color="#99A9BF"></el-rate>
                    </template>
                </el-table-column>
                <el-table-column label="评论人" width="120">
                    <template slot-scope="scope">
                        <img :src="scope.row.AvatarUrl" class="head-pic">
                        <div style="display:block;">{{scope.row.NickName}}</div>
                    </template>
                </el-table-column>
                <el-table-column prop="Title" label="活动标题" width="120"></el-table-column>
                <el-table-column prop="AddTime" label="评论时间" width="100"></el-table-column>
                <el-table-column prop="SubCommentList[0]" label="最新回复" width="120"></el-table-column>
                <el-table-column label="操作" width="120" >
                    <template slot-scope="scope">
                        <el-button type="primary" plain size="mini" v-if="isRecommend===1">设为推荐</el-button>
                        <el-button type="danger" plain size="mini" v-else>取消推荐</el-button>
                    </template>
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

      <el-dialog title="状态变更" :visible.sync="dialogRecommendSeen" :show-close="false" width="250px" center>
            <p style="text-align:center;padding:10px 0;">{{dialogContent?'状态已修改为推荐':'已取消推荐'}}</p>
            <span slot="footer" class="dialog-footer">
            <el-button type="primary">确 定</el-button>
            </span>
      </el-dialog>
    </div>
</template>

<script>
import { vueMixins } from '../assets/js/mixins.js'
import '../assets/css/city_backstage.css'
export default{
  name: 'evaluateManage',
  mixins: [vueMixins], // 注册mixins
  data() {
    return {
      dialogRecommendSeen: false,
      dialogContent: false,
      dialogIndex: '',
      formInline: {
        content: '',
        title: '',
        evaluateID: '',
        stars: '',
        starOptions: [
          {value: '选项一', option: '五星'},
          {value: '选项二', option: '四星'},
          {value: '选项三', option: '三星'},
          {value: '选项四', option: '二星'},
          {value: '选项五', option: '一星'}
        ],
        date: ''
      },
      table: []
    }
  }
}
</script>
<style>
  .thumbnail{float:left;display:block;width:50px;margin:0 0 5px 5px;}
  .head-pic{display:block;width:50px;height:50px;}
</style>
