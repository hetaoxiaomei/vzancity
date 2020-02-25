<template>
    <div class="iframe_body">
        <el-tabs v-model="activeName" type="card">
            <el-tab-pane label="我的账户" name="first">
                <ul class="d-flex d-flex-center data-ul" style="margin:20px 0 0;">
                    <li class="flex" style="background:#409EFF;padding:40px 0 0;">
                        <div class="content">
                            <p style="font-size:20px;">总收入</p>
                            <p style="font-size:40px;margin:10px 0 0;">¥{{income.total}}</p>
                        </div>
                    </li>
                    <li class="flex" style="background:#F56C6C;margin:0 20px;padding:40px 0 0;">
                        <div class="content">
                            <p style="font-size:20px;">待结算金额</p>
                            <p style="font-size:40px;margin:10px 0 0;">¥{{income.settlement}}</p>
                        </div>
                    </li>
                    <li class="flex" style="background:#67C23A;padding:40px 0 0;">
                        <div class="content">
                            <p style="font-size:20px;">可提现金额</p>
                            <p style="font-size:40px;margin:10px 0 0;">¥{{income.withdraw}}</p>
                            <el-button size="small" style="padding: 12px 30px;margin:10px 0 0;">提现</el-button>
                        </div>
                    </li>
                </ul>

                <el-menu :default-active="activeIndex" class="el-menu-demo" mode="horizontal"style="margin:20px 0 0;">
                    <el-menu-item index="1" style="font-weight:bold;font-size:20px;">账单明细</el-menu-item>
                </el-menu>

                <el-form :inline="true" :model="formBill" class="demo-form-inline table-serch" style="margin:20px 0 0;">
                    <el-form-item label="支付订单号：" size="small" style="margin:0 10px 0 0">
                        <el-input v-model="formBill.order" oninput="value=value.replace(/[^\d]/g,'')" placeholder="请输入订单号" style="width:180px;"></el-input>
                    </el-form-item>
                    <div style="display:inline-block;margin:0 10px 0 0">
                        <span class="demonstration">交易时间：</span>
                        <el-date-picker unlink-panels=false v-model="formBill.date" type="daterange" range-separator="至" size="small">
                        </el-date-picker>
                    </div>
                    <el-form-item label="收益类型：" size="small" style="margin:0 10px 0 0">
                        <el-select v-model="formBill.type" style="width:100%" @change="change">
                            <el-option v-for="(item,index) in formBill.typeOptions" :key="index" :label="item.option" :value="item.value"></el-option>
                        </el-select>
                    </el-form-item>

                    <div style="margin:10px 0 0;">
                        <el-form-item label="商品/营销活动名称：" size="small" style="margin:0">
                            <el-input v-model="formBill.commodity" style="width:180px;"></el-input>
                        </el-form-item>
                        <el-form-item label="支付用户名/电话：" size="small" style="margin:0 0 0 10px">
                            <el-input v-model="formBill.user" style="width:180px;"></el-input>
                        </el-form-item>
                        <div style="display:inline-block;margin:0 0 0 10px">
                            <el-button size="small">清空条件</el-button>
                            <el-button type="primary" size="small" style="padding:9px 30px;">搜索</el-button>
                            <el-button size="small" type="primary" plain>导出Excel</el-button>
                        </div>
                    </div>
                </el-form>

                <div style="font-size:12px;color:#F56C6C;margin:10px 0 0;">支付过程中扣除的微信手续费不会在账单明细中显示</div>

                <!--表单-->
                <template>
                    <el-table ref="multipleTable" :data="tableBill" tooltip-effect="dark" border style="width:1000px;margin:10px 0 0;" @selection-change="handleSelectionChange">
                        <el-table-column prop="order" label="支付单号" width="140"></el-table-column>
                        <el-table-column prop="date" label="时间" width="140"></el-table-column>
                        <el-table-column prop="billType" label="收益类型" width="140"></el-table-column>
                        <el-table-column prop="billName" label="收益名称"></el-table-column>
                        <el-table-column prop="user" label="支付用户名（电话）" show-overflow-tooltip></el-table-column>
                        <el-table-column prop="pay" label="入账/支出（元）" width="140"></el-table-column>
                    </el-table>
                </template>

            </el-tab-pane>

            <el-tab-pane label="我的提现" name="second">
                <ul class="d-flex d-flex-center data-ul" style="margin:20px 0 0;">
                    <li class="flex" style="background:#409EFF;padding:20px 0 0;">
                        <div class="content">
                            <p style="font-size:20px;">可提现余额</p>
                            <p style="font-size:40px;margin:10px 0 0;">¥{{income.withdraw}}</p>
                            <p>已冻结金额：￥{{income.frozen}}</p>
                            <el-button size="small" style="padding: 12px 30px;margin:10px 0 0;">提现</el-button>
                        </div>
                    </li>
                    <li class="flex" style="background:#F56C6C;margin:0 20px;padding:20px 0 0;">
                        <div class="content">
                            <p style="font-size:20px;">不可提现余额</p>
                            <p style="font-size:40px;margin:10px 0 0;">¥{{income.noWithdraw}}</p>
                        </div>
                    </li>
                    <li class="flex" style="background:#67C23A;padding:10px 0 0;">
                        <div class="content"  style="font-size:13px;text-align:left">
                            <p style="text-align:left;margin:0 20px;font-weight:normal;">
                                提现说明：<br/>
                                1、每日提现金额不能超过20000元，每天只能提一次；<br/>
                                2、提现后，7个工作日内到账；<br/>
                                3、由于微信限制，每个账户收益金额必须大于1元才能提现；当单个账户收益小于1元时，收益将记录入不可提现余额，后续当收益累计大于1元时，将自动纳入可提现余额。
                            </p>
                            <el-link class="ask-question" href="https://element.eleme.io" target="_blank" style="color:#fff;margin:10px 20px 0;">提现相关问题解答</el-link>
                        </div>
                    </li>
                </ul>
                <el-menu :default-active="activeIndex" class="el-menu-demo" mode="horizontal"style="margin:20px 0 0;">
                    <el-menu-item index="1" style="font-weight:bold;font-size:20px;">提现记录</el-menu-item>
                </el-menu>

                <el-form :inline="true" :model="formWithdraw" class="demo-form-inline table-serch" style="margin:20px 0 0;">
                    <div style="display:inline-block;margin:0 10px 0 0">
                        <span class="demonstration">提现时间：</span>
                        <el-date-picker unlink-panels=false v-model="formWithdraw.date" type="daterange" range-separator="至" size="small">
                        </el-date-picker>
                    </div>
                    <el-form-item label="提现状态：" size="small" style="margin:0 10px 0 0">
                        <el-select v-model="formWithdraw.type" style="width:100%">
                            <el-option v-for="(item,index) in formWithdraw.typeOptions" :key="index" :label="item.option" :value="item.value"></el-option>
                        </el-select>
                    </el-form-item>
                    <el-button size="small">清空条件</el-button>
                    <el-button type="primary" size="small" style="padding:9px 30px;">搜索</el-button>
                    <el-button size="small" type="primary" plain>导出Excel</el-button>
                </el-form>
                <!--表单-->
                <template>
                    <el-table ref="multipleTable" :data="tableWithdraw" tooltip-effect="dark" border style="width:1000px;margin:10px 0 0;" @selection-change="handleSelectionChange">
                        <el-table-column prop="date" label="时间" width="140"></el-table-column>
                        <el-table-column prop="money" label="金额" width="140"></el-table-column>
                        <el-table-column prop="user" label="提现用户名" show-overflow-tooltip></el-table-column>
                        <el-table-column prop="state" label="提现状态" width="140"></el-table-column>
                    </el-table>
                </template>

            </el-tab-pane>

        </el-tabs>

        <!--提现弹框-->
        <el-dialog title="提现" :visible.sync="dialogWithdrawSeen" center width="350px" class="formUploadIndexAd">
            <div style="padding:10px 0;">可提现余额：¥50.00 <el-link type="primary" style="margin:0 0 0 10px;">全部提现</el-link></div>
            <el-form :model="formWithdraw" :rules="rules">
                <el-form-item label="￥" label-width="20px" style="margin:0 0 5px;" size="medium">
                    <el-input v-model.number="formWithdraw.money" type='tel' oninput="value=value.replace(/[^\d]/g,'')" placeholder="请输入提现金额"></el-input>
                </el-form-item>
            </el-form>
            <div style="font-size:12px;color:#909399;padding: 0 0 20px;">1、每日提现金额不能超过20000元，每天只能提一次；<br/> 2、提现后，7个工作日内到账，入账到微信钱包中；</div>
            <div slot="footer" class="dialog-footer">
                <el-button @click="dialogWithdrawSeen = false">取 消</el-button>
                <el-button type="primary">确 定</el-button>
            </div>
        </el-dialog>

    </div>
</template>
<script>
import { vueMixins } from '../assets/js/mixins.js'
import '../assets/css/city_backstage.css'
export default {
  name: 'propertyManage',
  mixins: [vueMixins], // 注册mixins
  data() {
    return {
      activeName: 'second',
      activeIndex: '1',
      dialogWithdrawSeen: false,
      income: {
        total: '1200',
        settlement: '500',
        withdraw: '400',
        noWithdraw: '300',
        frozen: '200'
      },
      formBill: {
        order: '',
        date: '',
        type: '',
        typeOptions: [
          {value: '选项一', option: '五星'},
          {value: '选项二', option: '四星'},
          {value: '选项三', option: '三星'},
          {value: '选项四', option: '二星'},
          {value: '选项五', option: '一星'}
        ],
        commodity: '',
        user: ''
      },
      tableBill: [
        {
          order: '1234567890',
          date: '2020-2-13 21:16',
          billType: '商品订单抽成',
          billName: '商品A',
          user: '啊啊啊（12345678912）',
          pay: '+1.00'
        },
        {
          order: '1234567890',
          date: '2020-2-13 21:16',
          billType: '商品订单抽成',
          billName: '商品A',
          user: '啊啊啊（12345678912）',
          pay: '+1.00'
        }
      ],
      formWithdraw: {
        date: '',
        type: '',
        typeOptions: [
          {value: '选项一', option: '全部'},
          {value: '选项二', option: '待审核'},
          {value: '选项三', option: '提现成功'},
          {value: '选项四', option: '提现失败'},
          {value: '选项五', option: '审核不通过'}
        ]
      },
      tableWithdraw: [
        {
          date: '2020-2-13 21:16',
          money: '￥12.00',
          user: '店主A',
          state: '待审核'
        },
        {
          date: '2020-2-13 21:16',
          money: '￥12.00',
          user: '店主A',
          state: '待审核'
        }
      ],
      formWithdraw: {money: ''}
    }
  },
  methods: {},
  mounted: function() {},
  created: function () {}
}
</script>
<style>
.data-ul{font-weight:bold;text-align:center;color:#fff;overflow:hidden}
.data-ul li{height:200px;border-radius:20px;position: relative;box-sizing: border-box;}
.data-ul li .content{position: absolute;width:100%;text-align: center;}
.ask-question{text-decoration: underline;}
</style>
