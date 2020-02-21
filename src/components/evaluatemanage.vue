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
            <el-table ref="multipleTable" :data="table" tooltip-effect="dark" border style="width:100%;border-bottom: 0;border-right:0;" @selection-change="handleSelectionChange">
                <el-table-column prop="evaluateID" label="评论ID" width="80"></el-table-column>
                <el-table-column prop="content" label="评论内容" show-overflow-tooltip></el-table-column>
                <el-table-column prop="imgs" label="缩略图">
                    <template slot-scope="scope">
                        <img :src="item.src"  v-for="(item,index) in scope.row.imgs" :key="index" style="float:left; display:block;width:50px;margin:0 0 5px 5px;">
                    </template>
                </el-table-column>
                <el-table-column prop="star" label="评星" width="150">
                    <template slot-scope="scope">
                        <el-rate v-model="scope.row.star" disabled disabled-void-color="#99A9BF"></el-rate>
                    </template>
                </el-table-column>
                <el-table-column prop="userID" label="评论人" width="120">
                    <template slot-scope="scope">
                        <img :src="scope.row.userID.head" style="display:block;width:50px;height:50px;">
                        <div style="display:block;">{{scope.row.userID.name}}</div>
                    </template>
                </el-table-column>
                <el-table-column prop="activityTitle" label="活动标题" width="120"></el-table-column>
                <el-table-column prop="evaluateTime" label="评论时间" width="100"></el-table-column>
                <el-table-column prop="reply" label="最新回复" width="120"></el-table-column>
                <el-table-column prop="recommend" label="操作" width="120" >
                    <template slot-scope="scope">
                        <el-button type="primary" plain size="mini">{{scope.row.recommend?'设为推荐':'取消推荐'}}</el-button>
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
      table: [
        {
          evaluateID: '1752',
          content: '真的好好吃',
          imgs: [
            {src: 'https://j.vzan.cc/content/city/img/skin_peeler/skin_nav01.png'},
            {src: 'https://j.vzan.cc/content/city/img/skin_peeler/skin_nav01.png'},
            {src: 'https://j.vzan.cc/content/city/img/skin_peeler/skin_nav01.png'}
          ],
          userID: {
            head: 'https://j.vzan.cc/content/city/img/skin_peeler/skin_nav01.png',
            name: '风有力（123123456）'
          },
          star: 4,
          tel: '12345678912（已验证）',
          userTitle: '普通用户',
          activityTitle: '欢度春节重庆鸡公煲新春大酬宾原899元年夜饭套餐现价仅需499',
          evaluateTime: '2019-12-12 18:00:21',
          reply: '谢谢你的评论',
          recommend: true
        },
        {
          evaluateID: '1752',
          content: '真的好好吃',
          imgs: [
            {src: 'https://j.vzan.cc/content/city/img/skin_peeler/skin_nav01.png'},
            {src: 'https://j.vzan.cc/content/city/img/skin_peeler/skin_nav01.png'},
            {src: 'https://j.vzan.cc/content/city/img/skin_peeler/skin_nav01.png'}
          ],
          userID: {
            head: 'https://j.vzan.cc/content/city/img/skin_peeler/skin_nav01.png',
            name: '风有力（123123456）'
          },
          star: 4,
          tel: '12345678912（已验证）',
          userTitle: '普通用户',
          activityTitle: '欢度春节重庆鸡公煲新春大酬宾原899元年夜饭套餐现价仅需499',
          evaluateTime: '2019-12-12 18:00:21',
          reply: '谢谢你的评论',
          recommend: false
        }
      ]
    }
  }
}
</script>
