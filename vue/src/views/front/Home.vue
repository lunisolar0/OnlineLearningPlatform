<template>
  <div class="main-content">
    <div style="display: flex">
      <div style="flex: 12%; height: 350px; background-color: #0c0c0c"></div>
      <div style="flex: 76%">
        <el-carousel height="350px">
          <el-carousel-item v-for="item in carouselData">
            <img :src="item" alt="" style="width: 100%; height: 350px">
          </el-carousel-item>
        </el-carousel>
      </div>
      <div style="flex: 12%; height: 350px; background-color: #0c0c0c"></div>
    </div>



    <div style="width: 76%; margin: 50px auto; min-height: 1000px">
      <div style="display: flex">
        <div style="flex: 1">
          <span style="font-size: 24px; color: #333333; margin-right: 50px">在线课程</span>
        </div>
      </div>

      <div style="display: flex; margin-top: 20px; height: 300px">
        <div style="flex: 1; margin-right: 10px; width: 0">
          <img :src="recommend.img" alt="" style="width: 100%; height: 270px; border-radius: 5px" @click="navTo(recommend.id)">
          <div style="font-size: 15px; margin-top: 5px" class="overflowShow">{{ recommend.name }}</div>
        </div>
        <div style="flex: 2; margin-left: 10px">
          <el-row :gutter="20">
            <el-col :span="6" style="margin-bottom: 35px" v-for="item in rightData">
              <img :src="item.img" alt="" style="width: 100%; height: 100px; border-radius: 5px; border: 1px solid #cccccc" @click="navTo(item.id)">
              <div style="color: #333333; margin-top: 10px" class="overflowShow">{{ item.name }}</div>
            </el-col>
          </el-row>
        </div>
      </div>
</div>
  </div>
</template>

<script>

export default {

  data() {
    return {
      carouselData: [
        require('@/assets/imgs/da4a9058921d7a2ea96e625c8c940e87.png'),
      ],
      recommend: {},
      rightData: [],
    }
  },

  mounted() {
    this.loadRecommend()
    this.loadRightData()
    console.log(this.recommend)
  },
  methods: {
    loadRecommend() {
      this.$request.get('/course/getRecommend').then(res => {
        if (res.code === '200') {
          this.recommend = res.data
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    navTo(id) {
        // 往课程详情页跳
        location.href = '/front/courseDetail?id=' + id

    },
    loadRightData() {
      this.$request.get('/course/selectTop8').then(res => {
        if (res.code === '200') {
          this.rightData = res.data
        } else {
          this.$message.error(res.msg)
        }
      })
    }
  }
}
</script>