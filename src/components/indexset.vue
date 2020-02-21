<template>
  <div class="iframe_body">
    <el-tabs v-model="activeName" type="card" @tab-click="handleClick">
      <el-tab-pane label="首页管理" name="first">
        <!--基础信息-->
        <div>
          <div class="title-bar" style="margin:5px 0 0;">基础信息</div>
          <div style="padding: 0 0 0 20px;">
            <el-form :model="formIndex" label-width="70px" class="formIndex" style="width:420px;">
              <div>
                <div class="big-title">首页标题</div>
                <el-form-item label="首页标题" style="margin:10px 0 0;">
                  <el-input
                    v-model.trim="formIndex.title"
                    placeholder="最多4个字，不填默认为“XX优选”"
                    size="medium"
                  ></el-input>
                </el-form-item>
              </div>
              <div>
                <div class="big-title">首页分享</div>
                <el-form-item label="分享标题" style="margin:10px 0 0;" class="formIndex">
                  <el-input
                    v-model.trim="formIndex.shareTitle"
                    placeholder="最多15个字，不填默认为“XX优选-好吃好玩特划算”"
                    size="medium"
                  ></el-input>
                </el-form-item>
                <el-form-item label="分享图片" style="margin:10px 0 0;">
                  <el-upload
                    class="avatar-uploader"
                    action="https://jsonplaceholder.typicode.com/posts/"
                    :show-file-list="false"
                    :on-success="handleAvatarSuccess"
                    :before-upload="beforeAvatarUpload"
                  >
                    <img v-if="formIndex.imageUrl" :src="formIndex.imageUrl" class="avatar" />
                    <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                  </el-upload>
                  <p class="alert-f">推荐尺寸200*200，不更改默认为页面截图</p>
                </el-form-item>
              </div>
              <div>
                <div class="big-title">客服二维码</div>
                <el-form-item label style="margin:10px 0 0;">
                  <el-upload
                    class="avatar-uploader"
                    action="https://jsonplaceholder.typicode.com/posts/"
                    :show-file-list="false"
                    :on-success="handleAvatarSuccess"
                    :before-upload="beforeAvatarUpload"
                  >
                    <img v-if="formIndex.imageQr" :src="formIndex.imageQr" class="avatar" />
                    <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                  </el-upload>
                  <p class="alert-f">上传个人二维码，作为用户联系城主的方式</p>
                </el-form-item>
              </div>
              <el-button type="primary" style="margin:20px 0 0 70px;padding:12px 50px;">保存</el-button>
            </el-form>
          </div>
        </div>
        <!--首页轮播图-->
        <div>
          <div class="title-bar" style="margin:40px 0 0;">首页轮播图</div>
          <div style="margin:20px 0 10px;">
            <el-button type="primary" size="medium" @click="dialogAdFormVisible=true">新增轮播图</el-button>
            <div class="alert-f" style="margin: 5px 0;">最多上传5张轮播图，不添加则展示默认宣传图片</div>
          </div>
          <!--表单-->
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
              :data="tableDataIndexIcon"
              tooltip-effect="dark"
              border
              style="width:800px;"
              @selection-change="handleSelectionChange"
            >
              <el-table-column prop="name" label="名称" width="120"></el-table-column>
              <el-table-column prop="icon" label="图标" show-overflow-tooltip>
                <template slot-scope="scope">
                  <img :src="scope.row.icon" style="display:block;width:100%;" />
                </template>
              </el-table-column>
              <el-table-column prop="url" label="关联地址" width="200"></el-table-column>
              <el-table-column prop="sort" label="排序" width="120"></el-table-column>
              <el-table-column prop="state" label="状态" width="120"></el-table-column>
              <el-table-column label="操作" width="150">
                <template slot-scope="scope">
                  <router-link to="/indexicon">
                    <el-button type="primary" plain size="mini">编辑</el-button>
                  </router-link>
                  <el-button type="danger" plain size="mini">关闭</el-button>
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
              :data="tableDataBottomNav"
              tooltip-effect="dark"
              border
              style="width:800px;"
              @selection-change="handleSelectionChange"
            >
              <el-table-column prop="name" label="名称" width="120"></el-table-column>
              <el-table-column prop="icon" label="图标" show-overflow-tooltip>
                <template slot-scope="scope">
                  <img :src="scope.row.icon" style="display:block;width:100%;" />
                </template>
              </el-table-column>
              <el-table-column prop="url" label="关联地址" width="200"></el-table-column>
              <el-table-column label="操作" width="150">
                <template slot-scope="scope">
                  <el-button type="primary" plain size="mini">编辑</el-button>
                </template>
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
            <el-switch v-model="adValue"></el-switch>
          </div>
          <div style="margin:20px 0 10px;">
            <el-button type="primary" size="medium" @click="dialogAdFormVisible=true">添加广告</el-button>
            <el-button size="medium">批量删除广告</el-button>
            <div class="alert-f" style="margin: 5px 0;">最多添加8张轮播图，不添加则展示默认宣传图片</div>
          </div>
          <!--表单-->
          <template>
            <el-table
              ref="multipleTable"
              :data="tableData"
              tooltip-effect="dark"
              border
              style="width: 100%;"
              @selection-change="handleSelectionChange"
            >
              <el-table-column type="selection" width="55"></el-table-column>
              <el-table-column prop="img" label="图片" show-overflow-tooltip>
                <template slot-scope="scope">
                  <img :src="scope.row.img" style="display:block;width:100%;" />
                </template>
              </el-table-column>
              <el-table-column prop="url" label="url" width="120"></el-table-column>
              <el-table-column prop="type" label="类型" width="100"></el-table-column>
              <el-table-column prop="imgType" label="图片类型" width="120"></el-table-column>
              <el-table-column prop="addDate" label="添加日期" width="140"></el-table-column>
              <el-table-column prop="outdate" label="过期日期" width="140"></el-table-column>
              <el-table-column prop="sort" label="排序" width="60"></el-table-column>
              <el-table-column label="操作" width="150">
                <template slot-scope="scope">
                  <el-button type="primary" plain size="mini">编辑</el-button>
                  <el-button type="danger" plain size="mini">删除</el-button>
                </template>
              </el-table-column>
            </el-table>
          </template>
        </div>
        <!--好店评价模块-->
        <div class="title-bar">好店评价模块</div>
        <div style="padding: 0 0 0 20px;">
          <div class="d-flex d-flex-center" style="margin:20px 0 0;">
            <div style="margin-right: 12px;">功能开关</div>
            <el-switch v-model="goodShopEvaluate.value"></el-switch>
          </div>
          <div class="d-flex" style="margin:10px 0;">
            <div style="margin-right: 12px;">显示规则</div>
            <div class="flex">
              <el-radio-group v-model="goodShopEvaluate.radio">
                <el-radio :label="1">优先显示最新好评（四星以上评价）</el-radio>
                <el-radio :label="2">优先显示置顶评价</el-radio>
              </el-radio-group>
            </div>
          </div>
        </div>
        <!--推荐好店模块-->
        <div class="title-bar">推荐好店模块</div>
        <div style="padding: 0 0 0 20px;">
          <div class="d-flex d-flex-center" style="margin:20px 0 0;">
            <div style="margin-right: 12px;">功能开关</div>
            <el-switch v-model="goodShopRecommend.value"></el-switch>
          </div>
          <div class="d-flex" style="margin:10px 0;">
            <div style="margin-right: 12px;">显示规则</div>
            <div class="flex">
              <el-radio-group v-model="goodShopRecommend.radio">
                <el-radio :label="1">优先显示最新入驻店铺</el-radio>
                <el-radio :label="2">优先显示置顶店铺</el-radio>
              </el-radio-group>
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
          action="https://jsonplaceholder.typicode.com/posts/"
          :show-file-list="false"
          :on-success="handleAvatarSuccess"
          :before-upload="beforeAvatarUpload"
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
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="submitForm('ruleForm')">确 定</el-button>
      </div>
    </el-dialog>

    <!--底部导航入口配置-->
    <el-dialog title="入口配置" :visible.sync="dialogNavSeen" center width="350px">
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
    </el-dialog>

    <!--店铺聚合页 上传首页轮播图-->
    <el-dialog
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
      activeName: 'first',
      adValue: false,
      dialogIndexAdSeen: false,
      dialogNavSeen: false,
      dialogShopAdSeen: false,
      radio: 1,
      formIndex: {// 首页上传轮播图
        title: '',
        shareTitle: '',
        imageUrl: '',
        imageQr: ''
      },
      formIndexAd: {
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
      list01: [],
      tableDataIndexIcon: [
        {
          name: '分类1',
          icon: '',
          url: '/admini/activity/12',
          sort: '23',
          state: '关闭'
        }
      ],
      tableDataBottomNav: [
        {
          name: '分类1',
          icon: '',
          url: '/admini/activity/12'
        }
      ],
      tableData: [
        {
          date: '2016-05-03',
          img:
            'https://i.vzan.cc/image/jpg/2017/12/18/1913525ddfba50b89a435fa0bacf1f5971c368.jpg@!640x210',
          url:
            'https://i.vzan.cc/image/jpg/2017/12/18/1913525ddfba50b89a435fa0bacf1f5971c368.jpg@!640x210',
          type: '管理员添加',
          imgType: '好店首页轮播图',
          addDate: '2019-12-05 12:00',
          outdate: '无限制',
          sort: '999'
        }
      ],
      formShop: {
        imageUrl: '',
        url: '',
        sort: '',
        outdate: ''
      },
      goodShopEvaluate: { value: false, radio: 1 },
      goodShopRecommend: { value: false, radio: 1 }
    }
  }
}
</script>
