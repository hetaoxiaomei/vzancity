<template>
  <div class="iframe_body">
    <div class="qr">
      <img :src="qr" class="qrImg" />
      <p class="f01">专属同城小程序码</p>
    </div>
  </div>
</template>

<script>
import {vueMixins} from '../assets/js/mixins.js'

export default {
  name: 'situation',
  mixins: [vueMixins], // 注册mixins
  data () {
    return {
      qr: ''
    }
  },
  created: function () {

  }
}
</script>

<style scoped>
.qr {
  width: 200px;
}
.qr .qrImg {
  width: 200px;
  height: 200px;
  margin: 0 auto;
  display: block;
}
.qr .f01 {
  text-align: center;
  margin: 10px 0 0;
}
</style>
