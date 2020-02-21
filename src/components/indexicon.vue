<template>
    <div class="iframe_body">
        <div style="padding: 0 0 0 20px;">
            <el-form :model="formIndexIcon" :rules="rules" label-width="90px"  style="width:420px;" >
                <el-form-item label="入口图标" style="margin:10px 0 0;">
                    <el-upload
                    class="avatar-uploader"
                    action="https://jsonplaceholder.typicode.com/posts/"
                    :show-file-list="false"
                    :on-success="handleAvatarSuccess"
                    :before-upload="beforeAvatarUpload">
                    <img v-if="formIndexIcon.imageUrl" :src="formIndexIcon.imageUrl" class="avatar">
                    <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                    </el-upload>
                    <div @click="dialogIconSeen=true" style="position:absolute;top:56px;left:85px;padding:0 5px;background:#66b1ff;color:#fff;font-size:12px;line-height:20px;display:inline-block;border-radius:2px;">从图标库中选</div>
                    <p style="color:#909399;font-size:12px;line-height:1;margin:10px 0 0;">点击图标更换，推荐尺寸75*75</p>
                </el-form-item>
                <el-form-item label="入口名称" prop="name" style="margin:10px 0 0;">
                    <el-input v-model.trim="formIndexIcon.name" placeholder="最多4个字" size="medium"></el-input>
                </el-form-item>
                <el-form-item label="入口排序" style="margin:10px 0 0;">
                    <el-input v-model.number="formIndexIcon.sort" type='tel' oninput="value=value.replace(/[^\d]/g,'')" size="medium" placeholder="数值越大越靠前"></el-input>
                </el-form-item>
                <el-form-item label="入口链接" style="margin:10px 0 0;">
                    <el-select v-model="formIndexIcon.url"  size="medium" style="width:100%" @change="change">
                        <el-option v-for="(item,index) in formIndexIcon.urlOptions" :key="index" :label="item.option" :value="item.value">
                        </el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="自定义链接" style="margin:10px 0 0;">
                    <el-input v-model.trim="formIndexIcon.customUrl" size="medium"></el-input>
                </el-form-item>

                <el-row style="margin:20px 0 0 90px;">
                    <el-button type="primary">保存</el-button>
                    <router-link to="/indexset">
                        <el-button plain style="margin:0 0 0 10px">取消</el-button>
                    </router-link>
                </el-row>
            </el-form>
        </div>

        <!--从图标库选取弹框-->
        <el-dialog
        title="从图标库选取"
        :visible.sync="dialogIconSeen"
        width="30%"
        :before-close="handleClose">
            <ul class="icon-ul" style="margin:-20px 0 -30px;">
                <li v-for="(item,index) in icons" :key="index" :class="{active:selectIndex==index}" @click="selectIcon(index)">
                    <img :src="item.img">
                    <i class="el-icon-success"></i>
                </li>
            </ul>
            <span slot="footer" class="dialog-footer">
            <el-button type="primary" @click="dialogIconSeen= false">确 定</el-button>
            </span>
        </el-dialog>
    </div>
</template>
<script>
import { vueMixins } from '../assets/js/mixins.js'
import '../assets/css/city_backstage.css'
export default {
  name: 'indexSet',
  mixins: [vueMixins], // 注册mixins
  data() {
    return {
      selectIndex: null,
      dialogIconSeen: false,
      formIndexIcon: {
        imageUrl: '',
        name: '',
        sort: '',
        src: '',
        urlOptions: [
          {value: '选项1', option: '首页'},
          {value: '选项2', option: '好店'},
          {value: '选项3', option: '精选'},
          {value: '选项4', option: '我的'}
        ],
        shareTitle: '',
        customUrl: ''
      },
      rules: {
        name: [
          { required: true, message: '请输入活动名称', trigger: 'blur' },
          { min: 3, max: 5, message: '长度在 3 到 5 个字符', trigger: 'blur' }
        ]
      },
      icons: [
        {img: 'https://j.vzan.cc/content/city/img/skin_peeler/skin_nav01.png'},
        {img: 'https://j.vzan.cc/content/city/img/skin_peeler/skin_nav01.png'},
        {img: 'https://j.vzan.cc/content/city/img/skin_peeler/skin_nav01.png'},
        {img: 'https://j.vzan.cc/content/city/img/skin_peeler/skin_nav01.png'},
        {img: 'https://j.vzan.cc/content/city/img/skin_peeler/skin_nav01.png'},
        {img: 'https://j.vzan.cc/content/city/img/skin_peeler/skin_nav01.png'},
        {img: 'https://j.vzan.cc/content/city/img/skin_peeler/skin_nav01.png'},
        {img: 'https://j.vzan.cc/content/city/img/skin_peeler/skin_nav01.png'},
        {img: 'https://j.vzan.cc/content/city/img/skin_peeler/skin_nav01.png'},
        {img: 'https://j.vzan.cc/content/city/img/skin_peeler/skin_nav01.png'}
      ]
    }
  },
  methods: {
    selectIcon: function(index) {
      this.selectIndex = index
    }
  },
  mounted: function() {},
  created: function () {}
}
</script>
