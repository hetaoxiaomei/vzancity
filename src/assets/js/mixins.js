/* eslint-disable no-undef */
export let vueMixins = {
  dat: {
    webconfig: {
      domain: 'http://ms-city.vzan.com'
    },
    mImgType: 'default',
    mImgCount: 9,
    mImgList: [],
    queryPara: {
      cityInfoId: 0,
      storeId: 0,
      areaCode: 0,
      pageIndex: 1,
      pageSize: 10
    },
    mEditor: ''
  },
  methods: {
    handleSizeChange(pageSize) {
      if (pageSize === this.queryPara.pageSize) return
      this.list = []
      this.queryPara.pageSize = pageSize
      this.search()
    },
    handleCurrentChange(pageIndex) {
      if (pageIndex === this.queryPara.pageIndex) return
      this.list = []
      this.queryPara.pageIndex = pageIndex
      this.loadData()
    },
    handleSelectionChange(val) {
      this.multipleSelection = val
    },
    search() {
      this.list = []
      this.queryPara.pageIndex = 1
      this.loadData()
    },
    uploadImageBefore(res) {
      console.log('uploadBefore')
    },
    uploadImageExceed(files, fileList) {
      this.$message({
        type: 'info',
        message: `当前限制选择${this.mImgCount}个文件，本次选择了 ${files.length} 个文件`
      })
    },
    uploadImageChange(file, list) {
      if (file.status === 'ready') {
        if (this.mImgList.length >= this.mImgCount) {
          this.$message({
            type: 'info',
            message: `图片最多能上传${this.mImgCount}张`
          })
          return
        }
        if (file.size > 2 * 1024 * 1024) {
          this.$message({
            type: 'info',
            message: '文件不能大于2M'
          })
        }
      }
    },
    uploadImageProgress(event, file, fileList) {
      console.log('uploadProgress')
    },
    uploadImageError(res) {
      this.$message({
        type: 'error',
        message: res.msg
      })
    },
    // 上传方法
    uploadImageSuccess(res, file, list) {
      if (res.Success) {
        this.$message({
          type: 'success',
          message: '上传成功'
        })
        if (this.mImgList.length < this.mImgCount) {
          this.uploadImageCompleted(res)
          if (file.status === 'success') {
            list.splice(list.indexOf(file), 1)
          }
        }
      } else {
        this.$message({
          type: 'error',
          message: res.Msg
        })
      }
    },
    // 上传完成，可以重写方法
    uploadImageCompleted(item) {

    },
    loadEditor() {
      var self = this
      self.mEditor = UM.getEditor('editor', {
        toolbar: [
          'source | undo redo | bold italic underline strikethrough | superscript subscript | forecolor backcolor | removeformat |',
          'insertorderedlist insertunorderedlist | selectall cleardoc paragraph | fontfamily fontsize',
          '| justifyleft justifycenter justifyright justifyjustify |',
          'link unlink | image '
        ],
        imageUrl: '/CityUpload/Image?cityid=' + self.cityInfoId,
        autoHeight: false
      })
      // 对编辑器的操作最好在编辑器ready之后再做
      self.mEditor.ready(function () {
        self.editorReady()
      })
      // 当富文本框内容发生改变时,展示框也要发生改变
      self.mEditor.addListener('selectionchange', function (res) {
        if (self.mEditor.hasContents()) {
          var desc = self.mEditor.getContent()
          // desc = encodeURIComponent(desc);
          self.editorChange(desc)
        }
      })
    },
    // 编辑器就绪
    editorReady() {
      self.mEditor.setContent(decodeURIComponent(''))
    },
    // 编辑器内容改变
    editorChange(content) {

    },
    convertData(time, hasSecond) {
      if (time === undefined) {
        return ''
      }
      // eslint-disable-next-line no-irregular-whitespace
      var date = new Date(parseInt(time.substr(6, 13))) // 时间戳为10位需*1000，时间戳为13位的话不需乘1000
      var y = date.getFullYear()
      var m = date.getMonth() + 1
      m = m < 10 ? ('0' + m) : m
      var d = date.getDate()
      d = d < 10 ? ('0' + d) : d
      var h = date.getHours()
      h = h < 10 ? ('0' + h) : h
      var minute = date.getMinutes()
      var second = date.getSeconds()
      minute = minute < 10 ? ('0' + minute) : minute
      second = second < 10 ? ('0' + second) : second
      var ntime = y + '-' + m + '-' + d + ' ' + h + ':' + minute + (hasSecond ? ':' + second : '')
      if (ntime === '1950-04-24' || ntime === '0001-01-01') {
        return '------'
      }
      return ntime
    },
    isNullOrEmpty(str) {
      if (str === '' || str == null) {
        return true
      }
      return false
    },
    getQueryString(name, def) {
      var reg = new RegExp('(^|&)' + name + '=([^&]*)(&|$)')
      var r = window.location.search.substr(1).match(reg)
      if (r != null) { return unescape(r[2]) }
      return def || ''
    }
  }
}
