

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head><meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><title>
	同城数据统计
</title>
    <script src="https://j.vzan.cc/content/jquery/3.4.0/jquery.min.js"></script>
    <!-- 引入样式 -->
    <link rel="stylesheet" href="https://j.vzan.cc/content/element-ui/index.css" />
    <script src="https://j.vzan.cc/content/vue/2.6.10/vue.js"></script>
    <!-- 引入组件库 -->
    <script src="https://j.vzan.cc/content/element-ui/index.js"></script>
</head>
<body style="margin: 2px;">
    <style>
        .btn-margin {
            margin: 2px 0;
        }

        .img-size {
            width: 75px;
            max-height: 75px;
            margin: 3px;
        }

        .btn-box {
            margin: 3px;
        }

        .span-black {
            color: black;
        }

        .span-blue {
            color: blue;
        }

        .span-red {
            color: red;
        }

        .span-green {
            color: #26d626;
        }
    </style>
    <div id="app-view" style=" display:none" v-show="isCreated">
    <el-form ref="form" :model="queryPara" label-width="80px" inline style="text-align: left;margin:5px;">
        <div>
            <span>同城ID：&nbsp;</span>
            <el-input v-model.trim="queryPara.areacode" placeholder="同城ID" size="mini" style="width:100px;"></el-input>
            <span>同城名称：&nbsp;</span>
            <el-input v-model.trim="queryPara.cname" placeholder="同城名称" size="mini" style="width:100px;"></el-input>
            <span>使用状态：&nbsp;</span>
            <el-select v-model="queryPara.state" placeholder="请选择" size="mini" style="width:100px;">
                <el-option key="0" label="全部" :value="0"></el-option>                
                <el-option key="2" label="正常" :value="1"></el-option>
                <el-option key="1" label="过期" :value="-1"></el-option>
            </el-select>
            <span>到期时间：&nbsp;</span>
            <el-date-picker v-model="queryPara.dateRange" type="daterange" range-separator="至" start-placeholder="开始日期" end-placeholder="结束日期" value-format="yyyyMMdd" size="mini"></el-date-picker>
            <span>版本：&nbsp;</span>
            <el-select v-model="queryPara.version" placeholder="请选择版本" size="mini" style="width:120px;">
                <el-option v-for="item,index in versionList" :key="item.value" :label="item.label" :value="item.value"></el-option>                
            </el-select>
            <span>区域：&nbsp;</span>
            <el-select v-model="queryPara.province" placeholder="请选择省" size="mini" style="width:120px;" @change="changeAddr(0)">
                <el-option v-for="item,index in provinceList" :key="item.Code" :label="item.Name" :value="item.Code"></el-option>                
            </el-select>
            <el-select v-model="queryPara.city" placeholder="请选择市" size="mini" style="width:120px;" @change="changeAddr(1)">
                <el-option v-for="item,index in cityList" :key="item.Code" :label="item.Name" :value="item.Code"></el-option>                
            </el-select>
            <el-select v-model="queryPara.area" placeholder="请选择区县" size="mini" style="width:120px;" @change="changeAddr(2)">
                <el-option v-for="item,index in areaList" :key="item.Code" :label="item.Name" :value="item.Code"></el-option>                
            </el-select>
            <span>流水时间：&nbsp;</span>
            <el-date-picker v-model="queryPara.orderDateRange" type="daterange" range-separator="至" start-placeholder="开始日期" end-placeholder="结束日期" value-format="yyyyMMdd" size="mini"></el-date-picker>
            <el-button type="default" @click="clear()" size="mini" icon="el-icon-delete">清空条件</el-button>
            <el-button type="primary" @click="search" size="mini" icon="el-icon-search">搜索</el-button>
            <el-button type="primary" @click="exportTable()" size="mini">导出当前页数据</el-button>
        </div>
        <br />
    </el-form>
    <el-table ref="elTable" :data="list" border style="width:100%;" size="small" v-loading="loading" @selection-change="selectionChange" @sort-change="sortChange">
        <el-table-column type="selection" width="50">
        </el-table-column>
        <el-table-column fixed label="同城ID" width="100" align="center">
            <template slot-scope="scope">
                <span>{{scope.row.AreaCode}}</span>
            </template>
        </el-table-column>
        <el-table-column fixed label="同城名称" width="130" align="center">
            <template slot-scope="scope">
                <span>{{scope.row.CName}}</span>
            </template>
        </el-table-column>
        <el-table-column fixed label="版本" width="130" align="center">
            <template slot-scope="scope">
                <span>{{scope.row.CityType}}</span>
            </template>
        </el-table-column>
        <el-table-column label="省" width="100" align="center">
            <template slot-scope="scope">
                <span>{{scope.row.Address.Province}}</span>
            </template>
        </el-table-column>
        <el-table-column label="市" width="100" align="center">
            <template slot-scope="scope">
                <span>{{scope.row.Address.City}}</span>
            </template>
        </el-table-column>
        <el-table-column label="区" width="100" align="center">
            <template slot-scope="scope">
                <span>{{scope.row.Address.Area}}</span>
            </template>
        </el-table-column>
        <el-table-column label="使用状态" width="100" align="center">
            <template slot-scope="scope">
                <span>{{scope.row.State}}</span>
            </template>
        </el-table-column>
        <el-table-column label="首次开通时间" width="120" align="center" sortable="custom" prop="CreateDate">
            <template slot-scope="scope">
                <span>{{scope.row.CreateDate.substring(0,10)}}</span>
            </template>
        </el-table-column>
        <el-table-column label="到期时间" width="120" align="center" sortable="custom" prop="EndDate">
            <template slot-scope="scope">
                <span>{{scope.row.EndDate.substring(0,10)}}</span>
            </template>
        </el-table-column>
        <el-table-column label="总流水" width="100" align="center" sortable="custom" prop="TotalIncome">
            <template slot-scope="scope">
                <span>{{(scope.row.TotalIncome * 0.01).toFixed(2)}}</span>
            </template>
        </el-table-column>
        <el-table-column label="分类信息总数" width="120" align="center" sortable="custom" prop="ArticleNum">
            <template slot-scope="scope">
                <span>{{scope.row.ArticleNum}}</span>
            </template>
        </el-table-column>
        <el-table-column label="信息付费发布数" width="140" align="center" sortable="custom" prop="PayPublishNum">
            <template slot-scope="scope">
                <span>{{scope.row.PayPublishNum}}</span>
            </template>
        </el-table-column>         
        <el-table-column label="置顶次数" width="120" align="center" sortable="custom" prop="PayIndexNum">
            <template slot-scope="scope">
                <span>{{scope.row.PayIndexNum}}</span>
            </template>
        </el-table-column>
        <el-table-column label="发帖付费并置顶次数" width="160" align="center" sortable="custom" prop="PayAndIndexNum">
            <template slot-scope="scope">
                <span>{{scope.row.PayAndIndexNum}}</span>
            </template>
        </el-table-column>
        <el-table-column label="刷新次数" width="120" align="center" sortable="custom" prop="PayRefreshNum">
            <template slot-scope="scope">
                <span>{{scope.row.PayRefreshNum}}</span>
            </template>
        </el-table-column>
        <el-table-column label="分类信息总收入" width="140" align="center" sortable="custom" prop="InfoIncome">
            <template slot-scope="scope">
                <span>{{(scope.row.InfoIncome * 0.01).toFixed(2)}}</span>
            </template>
        </el-table-column>
        <el-table-column label="商家入驻数" width="120" align="center" sortable="custom" prop="StoreCount">
            <template slot-scope="scope">
                <span>{{scope.row.StoreCount}}</span>
            </template>
        </el-table-column>
        <el-table-column label="营销活动数量" width="140" align="center">
            <template slot-scope="scope">
                <span>{{scope.row.CouponNum + scope.row.GroupNum + scope.row.LikeNum + scope.row.BargainNum}}</span>
            </template>
        </el-table-column>
        <el-table-column label="营销活动总销售额" width="160" align="center" sortable="custom" prop="ActivityIncome">
            <template slot-scope="scope">
                <span>{{(scope.row.ActivityIncome * 0.01).toFixed(2)}}</span>
            </template>
        </el-table-column>
        <el-table-column label="抢优惠活动数量" width="140" align="center" sortable="custom" prop="CouponNum">
            <template slot-scope="scope">
                <span>{{scope.row.CouponNum}}</span>
            </template>
        </el-table-column>
        <el-table-column label="抢优惠销售额" width="140" align="center" sortable="custom" prop="CouponIncome">
            <template slot-scope="scope">
                <span>{{(scope.row.CouponIncome * 0.01).toFixed(2)}}</span>
            </template>
        </el-table-column>
        <el-table-column label="拼团活动数量" width="140" align="center" sortable="custom" prop="GroupNum">
            <template slot-scope="scope">
                <span>{{scope.row.GroupNum}}</span>
            </template>
        </el-table-column>
        <el-table-column label="拼团销售额" width="140" align="center" sortable="custom" prop="GroupIncome">
            <template slot-scope="scope">
                <span>{{(scope.row.GroupIncome * 0.01).toFixed(2)}}</span>
            </template>
        </el-table-column>
        <el-table-column label="减价活动数量" width="140" align="center" sortable="custom" prop="BargainNum">
            <template slot-scope="scope">
                <span>{{scope.row.BargainNum}}</span>
            </template>
        </el-table-column>
        <el-table-column label="减价销售额" width="140" align="center" sortable="custom" prop="BargainIncome">
            <template slot-scope="scope">
                <span>{{(scope.row.BargainIncome * 0.01).toFixed(2)}}</span>
            </template>
        </el-table-column>
        <el-table-column label="爱心价活动数量" width="140" align="center" sortable="custom" prop="LikeNum">
            <template slot-scope="scope">
                <span>{{scope.row.LikeNum}}</span>
            </template>
        </el-table-column>
        <el-table-column label="爱心价销售额" width="140" align="center" sortable="custom" prop="LikeIncome">
            <template slot-scope="scope">
                <span>{{(scope.row.LikeIncome * 0.01).toFixed(2)}}</span>
            </template>
        </el-table-column>        
        <el-table-column label="投票活动数量" width="140" align="center" sortable="custom" prop="VoteNum">
            <template slot-scope="scope">
                <span>{{scope.row.VoteNum}}</span>
            </template>
        </el-table-column>
        <el-table-column label="投票活动收入" width="140" align="center" sortable="custom" prop="VoteIncome">
            <template slot-scope="scope">
                <span>{{(scope.row.VoteIncome * 0.01).toFixed(2)}}</span>
            </template>
        </el-table-column>        
    </el-table>
    <div style="margin-top:20px;display:none;" v-show="count>0">
        <el-pagination @size-change="handleSizeChange"
                       @current-change="handleCurrentChange"
                       :current-page="queryPara.pageIndex"
                       :page-sizes="[10, 20, 30, 40, 50, 100, 500, 800, 1000, 3000, 5000]"
                       :page-size="10"
                       layout="total, sizes, prev, pager, next, jumper"
                       background
                       :total="count">
        </el-pagination>
    </div>
</div>
<script type="text/javascript">    
    var vm = new Vue({
        el: "#app-view",
        data: {
            switchBtn: false,
            queryPara: {
                pageIndex: 1,
                pageSize: 10,                
                sortName: '',                
                sortType: 0,
                state: 0,
                dateRange: '',
                dateStr:'',
                province:'',
                city:'',
                area: '',
                version: -1,
                orderDateRange: '',
                orderDateStr: '',
            },
            sortlist: [
                { label: "降序", value: 0 },
                { label: "升序", value: 1 }
            ],
            versionList: [
                { label: "全部", value: -1 },
                { label: "同城", value: 0 },
                { label: "行业", value: 1 },
                { label: "营销系统", value: 3 },
                { label: "招聘工具", value: 4 },
                { label: "同镇", value: 5 },
            ],
            isCreated: false,
            list: [],
            count: 0,
            dialogVisible: false,
            loading: false,
            multipleSelection: [],
            provinceList:[],
            cityList:[],
            areaList:[],
        },
        methods: {
            loadData() {
                this.loading = true;
                $.post("/Handler/CityHandler.ashx?oper=GetCityData", this.queryPara, function (res) {
                    if (res != "") {
                        var data = JSON.parse(res);
                        if (data.count > 0) {
                            if (vm.queryPara.pageIndex === 1) {
                                vm.list = [];
                            }
                            vm.list = vm.list.concat(data.data || []);
                            vm.count = data.count;
                        } else {
                            vm.count = 0;
                        }
                    }
                    vm.loading = false;
                });
            },
            handleSizeChange(pageSize) {
                if (pageSize == this.queryPara.pageSize) return;
                this.list = [];
                this.queryPara.pageSize = pageSize;
                this.search();
            },
            handleCurrentChange(pageIndex) {
                if (pageIndex == this.queryPara.pageIndex) return;
                this.list = [];
                this.queryPara.pageIndex = pageIndex;
                this.loadData();
            },
            search() {
                if (this.queryPara.dateRange.length > 1) {
                    this.queryPara.dateStr = this.queryPara.dateRange[0] + '-' + this.queryPara.dateRange[1];
                }
                if (this.queryPara.orderDateRange.length > 1) {
                    this.queryPara.orderDateStr = this.queryPara.orderDateRange[0] + '-' + this.queryPara.orderDateRange[1];
                }                
                this.list = [];
                this.queryPara.pageIndex = 1;
                this.loadData();
            },
            convertData(time) {
                if (time == undefined) {
                    return "";
                }
                var date = new Date(parseInt(time.substr(6, 13))); //时间戳为10位需*1000，时间戳为13位的话不需乘1000
                var y = date.getFullYear();
                var m = date.getMonth() + 1;
                m = m < 10 ? ("0" + m) : m;
                var d = date.getDate();
                d = d < 10 ? ("0" + d) : d;
                var h = date.getHours();
                h = h < 10 ? ("0" + h) : h;
                var minute = date.getMinutes();
                var second = date.getSeconds();
                minute = minute < 10 ? ("0" + minute) : minute;
                second = second < 10 ? ("0" + second) : second;
                var ntime = y + "-" + m + "-" + d + " " + h + ":" + minute + ":" + second;
                if (ntime == "1950-04-24" || ntime == "0001-01-01") {
                    return "------";
                }
                return ntime;
            },
            dropHandle(command) {
                var self = this;
                var tip = "亲，您要继续此操作吗？";
                if (command[0] == 4) {
                    tip = "亲，您确定要删除吗？";
                }

                self.$confirm(tip, "提示", {
                    confirmButtonText: "确定",
                    cancelButtonText: "取消",
                    type: "warning"
                }).then(() => {
                    $.post("/Handler/FriendHandler.ashx?oper=UpdateState", { pIds: command[1], state: command[2] }, function (res) {
                        if (res != "") {
                            var data = JSON.parse(res);
                            if (data && data.isok) {
                                vm.$message({ showClose: true, message: "操作成功", type: "info" });
                                vm.list = [];
                                vm.loadData();
                            } else {
                                vm.$message({ showClose: true, message: "操作失败", type: "info" });
                            }
                        } else {
                            vm.$message({ showClose: true, message: "网络异常！", type: "info" });
                        }
                    });
                }).catch(() => {
                });
            },
            initControl() {
                this.getProvince();
            },
            clear() {
                this.queryPara.userId = "";
                this.queryPara.areacode = "";
                this.queryPara.cname = "";
                this.queryPara.compType = -1;
                this.queryPara.sourceType = -1;
                this.queryPara.compState = -1;
                this.queryPara.sortType = 0;
                this.queryPara.dateRange = '';
                this.queryPara.dateStr = '';
                this.queryPara.province = '';
                this.queryPara.city = '';
                this.queryPara.area = '';
                this.queryPara.version = -1;
                this.queryPara.orderDateRange = '';
                this.queryPara.orderDateStr = '';
            },
            selectionChange(val) {
                this.multipleSelection = val;
            },
            sortChange(column, prop, order) {
                if (column.order && column.prop) {
                    if (column.order == "descending") {
                        this.queryPara.sortName = column.prop;
                        this.queryPara.sortType = 1;
                    } else if (column.order == "ascending") {
                        this.queryPara.sortName = column.prop;
                        this.queryPara.sortType = 2;
                    } else {
                        this.queryPara.sortName = '';
                        this.queryPara.sortType = 0;
                    }
                    this.list = [];
                    this.queryPara.pageIndex = 1;
                    this.loadData();
                } else if (column.prop != '') {
                    this.queryPara.sortName = '';
                    this.queryPara.sortType = 0;
                }
                console.log(column);
            },
            exportTable() {
                if (this.list.length > 0) {
                    var html = [];
                    html.push(`,同城ID,同城名称,版本,省,市,区,使用状态,首次开通时间,到期时间,总流水,分类信息总数,信息付费发布数,置顶次数,发帖付费并置顶次数,刷新次数,分类信息总收入,商家入驻数,营销活动数量,营销活动总收入,抢优惠活动数量,抢优惠活动收入,拼团活动数量,拼团活动收入,爱心价活动数量,爱心价活动收入,减价活动数量,减价活动总收入,投票活动数量,投票活动收入\n`);
                    for (var i = 0; i < this.list.length; i++) {
                        var item = this.list[i];
                        if (item) {
                            html.push(`${item.AreaCode},${item.CName},${item.CityType},${item.Address.Province},${item.Address.City},${item.Address.Area},${item.State},${item.CreateDate.substring(0, 10)},${item.EndDate.substring(0, 10)},${(item.TotalIncome * 0.01).toFixed(2)},${item.ArticleNum},${item.PayPublishNum},${item.PayIndexNum},${item.PayAndIndexNum},${item.PayRefreshNum},${(item.InfoIncome * 0.01).toFixed(2)},${item.StoreCount},${item.CouponNum + item.GroupNum + item.LikeNum + item.BargainNum},${(item.ActivityIncome * 0.01).toFixed(2)},${item.CouponNum},${(item.CouponIncome * 0.01).toFixed(2)},${item.GroupNum},${(item.GroupIncome * 0.01).toFixed(2)},${item.LikeNum},${(item.LikeIncome * 0.01).toFixed(2)},${item.BargainNum},${(item.BargainIncome * 0.01).toFixed(2)},${item.VoteNum},${(item.VoteIncome * 0.01).toFixed(2)}\n`);
                        }
                    }
                    var uri = 'data:text/csv;charset=utf-8,\ufeff' + encodeURIComponent(html.toString());
                    //通过创建a标签实现
                    var link = document.createElement("a");
                    link.href = uri;
                    //对下载的文件命名
                    link.download = "同城统计数据.csv";
                    document.body.appendChild(link);
                    link.click();
                    document.body.removeChild(link);
                }                
            },
            changeAddr(type) {
                var self = this;
                if (type == 0) {
                    this.queryPara.city = '';
                    this.queryPara.area = '';
                    self.cityList = [];
                    var province = this.provinceList.find(function (x) {
                        return x.Code == self.queryPara.province;
                    });
                    if (province) {
                        this.getCity(province.Code);
                    }                    
                } else if (type == 1) {
                    this.queryPara.area = '';
                    self.areaList = [];
                    var city = this.cityList.find(function (x) {
                        return x.Code == self.queryPara.city;
                    });
                    if (city) {                        
                        this.getArea(city.Code);
                    }
                }
            },
            getProvince() {
                var self = this;
                $.get('/Handler/CityHandler.ashx?oper=GetProvinceList', function (res) {
                    self.provinceList = res;
                }, 'json');
            },
            getCity(pid) {
                var self = this;
                $.get('/Handler/CityHandler.ashx?oper=GetCountryList&pid=' + pid, function (res) {
                    self.cityList = res;
                }, 'json');
            },
            getArea(pid) {
                var self = this;
                $.get('/Handler/CityHandler.ashx?oper=GetCountryList&pid='+ pid, function (res) {
                    self.areaList = res;
                }, 'json');
            }
        },
        created() {
            this.isCreated = true;
        },
        mounted() {
            this.loadData();
            this.initControl();
        }
    });
</script>
</body>
</html>
