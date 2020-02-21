<template>
    <div class="iframe_body">
        <el-tabs v-model="activeName" type="card">
            <el-tab-pane label="全部" name="first">
                <el-form :inline="true" :model="formOrder" class="demo-form-inline table-serch">
                    <el-form-item label="商品名/订单号：" size="small" style="margin:0">
                        <el-input v-model="formOrder.commodityID" placeholder="请输入商品名/订单号" style="width:180px;"></el-input>
                    </el-form-item>
                    <el-form-item label="商家名称：" size="small" style="margin:0 0 0 10px">
                        <el-input v-model="formOrder.buyerID" oninput="value=value.replace(/[^\d]/g,'')" placeholder="请输入买家ID" style="width:180px;"></el-input>
                    </el-form-item>
                    <el-form-item label="订单类型：" size="small" style="margin:0 0 0 10px">
                        <el-select v-model="formOrder.type" style="width:100%" @change="change">
                            <el-option v-for="item,index in formOrder.typeOptions" :label="item.option" :value="item.value">
                            </el-option>
                        </el-select>
                    </el-form-item>
                    <div style="margin:10px 0 0 0;">
                        <div style="display:inline-block;">
                            <span class="demonstration">时间段：</span>
                            <el-date-picker unlink-panels=false
                                v-model="formOrder.date"
                                type="daterange"
                                range-separator="至" size="small">
                            </el-date-picker>
                        </div>
                        <div style="display:inline-block;margin:0 0 0 10px">
                            <el-button size="small">清空条件</el-button>
                            <el-button type="primary" size="small" style="padding:9px 30px;">筛选</el-button>
                            <el-button size="small" type="primary" plain>导出Excel</el-button>
                        </div>
                    </div>
                </el-form>

                <!--表单-->
                <el-table ref="multipleTable" class="orderTableNav" tooltip-effect="dark" border style="width:100%;">
                    <el-table-column label="商品"></el-table-column>
                    <el-table-column label="售价(元)" width="80"></el-table-column>
                    <el-table-column label="数量" width="80"></el-table-column>
                    <el-table-column label="买家" width="120"></el-table-column>
                    <el-table-column label="实付金额" width="150"></el-table-column>
                    <el-table-column label="状态" width="80"></el-table-column>
                    <el-table-column label="店铺名称" width="120"></el-table-column>
                    <el-table-column label="买家备注" width="120"></el-table-column>
                    <el-table-column label="商户入账" width="80"></el-table-column>
                    <el-table-column label="操作" width="120"></el-table-column>
                </el-table>

                <div v-for="item,index in orders" style="margin:10px 0 0;">
                    <div class="d-flex d-flex-center" style="background:#f0f0f0;padding:10px;">
                        <div style="margin:0 20px 0 0;">下单时间：{{item.date}}</div>
                        <div style="margin:0 20px 0 0;">订单编号：{{item.number}}</div>
                        <div>订单类型：{{item.type}}</div>
                        <div class="flex"></div>
                        <a><el-button plain size="mini">查看详情</el-button></a>
                    </div>
                    <el-table class="orderTable" ref="multipleTable" :data="item.tableOrderManage" tooltip-effect="dark" border style="width:100%;">
                        <el-table-column prop="commodity" label="商品">
                            <template slot-scope="scope">
                                <div class="d-flex d-flex-center">
                                    <img :src="scope.row.commodity.head" style="display:block;width:50px;height:50px;margin:0 10px 0 0;">
                                    <div class="flex">{{scope.row.commodity.name}}</div>
                                </div>
                            </template>
                        </el-table-column>
                        <el-table-column prop="price" label="售价(元)" width="80"></el-table-column>
                        <el-table-column prop="number" label="数量" width="80"></el-table-column>
                        <el-table-column prop="buyer" label="买家" width="120"></el-table-column>
                        <el-table-column prop="pay" label="实付金额" width="150">
                            <template slot-scope="scope">
                                <div>合计：￥{{scope.row.pay.total}}</div>
                                <div>实付：￥{{scope.row.pay.actual}}</div>
                            </template>
                        </el-table-column>
                        <el-table-column prop="state" label="状态" width="80"></el-table-column>
                        <el-table-column prop="source" label="店铺名称" width="120"></el-table-column>
                        <el-table-column prop="remark" label="买家备注" width="120"></el-table-column>
                        <el-table-column prop="account" label="商户入账" width="80"></el-table-column>
                        <el-table-column label="操作" width="120">
                            <a><el-button type="primary" plain size="mini">用户评价</el-button></a>
                        </el-table-column>
                    </el-table>
                </div>

            </el-tab-pane>

            <el-tab-pane label="待付款" name="second"></el-tab-pane>

            <el-tab-pane label="待使用" name="third"></el-tab-pane>

            <el-tab-pane label="待评价" name="forth"></el-tab-pane>

        </el-tabs>

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
export default {
  name: 'orderManage',
  mixins: [vueMixins], // 注册mixins
  data() {
    return {
      activeName: 'first',
      formOrder: {
        commodityID: '',
        buyerID: '',
        type: '',
        typeOptions: [
          {value: '选项一', option: '全部'},
          {value: '选项二', option: '商品订单'},
          {value: '选项三', option: '秒杀订单'},
          {value: '选项三', option: '砍价订单'}
        ],
        date: ''
      },
      orders: [
        {
          date: '2019-11-25 16:09:31',
          number: '2019112500081224',
          type: '砍价订单',
          tableOrderManage: [
            {
              commodity: {
                name: '美味最佳葱油饼美味最佳葱油饼',
                head: 'https://i.vzan.cc/image/jpg/2017/12/18/1913525ddfba50b89a435fa0bacf1f5971c368.jpg@!640x210'
              },
              price: '12',
              number: '1',
              buyer: 'bruce(30561212)',
              pay: {total: '11', actual: '11'},
              state: '已收货',
              source: '微赞奶茶店',
              remark: '多糖',
              account: '0.09'
            }
          ]
        }
      ]

    }
  },
  methods: {},
  mounted: function() {}
}
</script>
<style>
    .orderTableNav .el-table__empty-block{
        display: none !important;
    }
    .orderTable .el-table__header-wrapper{display: none !important;}
</style>
