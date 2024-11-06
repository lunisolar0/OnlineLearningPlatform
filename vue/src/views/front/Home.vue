<template>
  <div class="main-content">
    <div style="display: flex">
      <div style="flex: 12%; height: 350px; background-color: #0c0c0c"></div>
      <div style="flex: 76%">
        <el-carousel height="350px">
          <el-carousel-item v-for="(item, index) in carouselData" :key="index">
            <img :src="item" alt="" style="width: 100%; height: 350px">
          </el-carousel-item>
        </el-carousel>
      </div>
      <div style="flex: 12%; height: 350px; background-color: #0c0c0c"></div>
    </div>

    <div style="width: 76%; margin: 50px auto; height: auto;">
      <div style="display: flex; align-items: center; margin-bottom: 20px;">
        <span style="font-size: 24px; color: #333333;">在线课程</span>
      </div>

      <div style="display: flex; margin-top: 20px;">
        <!-- 推荐课程 -->
        <div style="flex: 1; margin-right: 10px;">
          <div class="course-card recommend-course" @click="navTo(recommend.id)" @mouseenter="playVideo"
               @mouseleave="pauseVideo" >
            <span class="recommend-label">推荐</span> <!-- 新增的元素 -->
            <video ref="introVideo" class="course-video" muted>
              <source src="@/assets/videos/intro.mp4" type="video/mp4" >
              Your browser does not support the video tag.
            </video>
            <img :src="recommend.img" alt="" class="course-image" ref="recommendImage">
            <div class="course-title">{{ recommend.name }}</div>
          </div>
        </div>
        <!-- 其他课程 -->
        <div style="flex: 2; display: flex; flex-wrap: wrap;">
          <el-col :span="6" v-for="item in rightData" :key="item.id" style="margin-bottom: 35px; display: flex; justify-content: center;">
            <div class="course-card" @click="navTo(item.id)">
              <img :src="item.img" alt="" class="course-image">
              <div class="course-title">{{ item.name }}</div>
            </div>
          </el-col>
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
        require('@/assets/imgs/1.png'),
        require('@/assets/imgs/2.png'),
      ],
      recommend: {},
      rightData: [],
    }
  },

  mounted() {
    this.loadRecommend();
    this.loadRightData();
  },

  methods: {
    loadRecommend() {
      this.$request.get('/course/getRecommend').then(res => {
        if (res.code === '200') {
          this.recommend = res.data;
          this.loadRightData(); // 在获取推荐课程后再加载其他课程
        } else {
          this.$message.error(res.msg);
        }
      });
    },
    playVideo() {
      const video = this.$refs.introVideo;
      video.style.display = 'block'; // 显示视频
      video.style.opacity = '1'; // 渐变到可见
      this.$refs.recommendImage.style.opacity = '0'; // 隐藏图片
      video.play(); // 播放视频

      // 设置定时器，10秒后如果视频还在播放则暂停并处理结束
      setTimeout(() => {
        if (!video.paused) {
          video.pause(); // 暂停视频
          video.currentTime = 0; // 重置到开始
          this.handleVideoEnd(); // 调用处理结束的方法
        }
      }, 10000); // 等待10秒
    },



    pauseVideo() {
      const video = this.$refs.introVideo;
      video.pause(); // 暂停视频
      video.currentTime = 0; // 重置到开始
      video.style.opacity = '0'; // 渐变到不可见
      this.$refs.recommendImage.style.opacity = '1'; // 确保图片可见
      this.$refs.recommendImage.style.display = 'block'; // 确保图片显示
    },

    handleVideoEnd() {
      const video = this.$refs.introVideo;
      video.pause(); // 确保视频暂停
      video.currentTime = 0; // 重置到开始
      video.style.opacity = '0'; // 渐变到不可见
      this.$refs.recommendImage.style.opacity = '1'; // 立即显示图片

      setTimeout(() => {
        video.style.display = 'none'; // 隐藏视频
      }, 500); // 等待0.5秒再隐藏
    },

    navTo(id) {
      if (id) {
        location.href = '/front/courseDetail?id=' + id; // 跳转到课程详情页
      } else {
        this.$message.error('课程信息缺失'); // 提示课程信息缺失
      }
    },

    loadRightData() {
      this.$request.get('/course/selectTop8').then(res => {
        if (res.code === '200') {
          // 将推荐课程从数据中排除
          const allCourses = res.data;
          const filteredCourses = allCourses.filter(course => course.id !== this.recommend.id);
          this.rightData = filteredCourses.slice(0, 8); // 选择最多8个课程
        } else {
          this.$message.error(res.msg);
        }
      });
    }
  }
}
</script>

<style scoped>
.course-card {
  -webkit-text-size-adjust: 100%;
  -webkit-tap-highlight-color: rgba(0, 0, 0, 0);
  --antd-wave-shadow-color: #00CC7E;
  --scroll-bar: 0;
  font-family: "Arial", "Hiragino Sans GB", "Microsoft YaHei", "Helvetica", "sans-serif";
  line-height: 1.4;
  outline: none;
  touch-action: manipulation;
  text-decoration: none;
  width: 100%; /* 改为100%以确保每个卡片在列中填满空间 */
  height: auto; /* 自动高度，便于适应内容 */
  background: rgba(255, 255, 255, 1);
  border-radius: 8px;
  position: relative;
  padding: 10px; /* 调整内边距以避免重叠 */
  box-sizing: border-box;
  font-size: 14px;
  color: #333;
  display: flex;
  flex-direction: column; /* 确保内容垂直排列 */
  cursor: pointer;
  margin-bottom: 12px;
  transition: all ease-in 0.25s;
}

.course-card:hover {
  transform: translateY(-5px);
}

.course-image {
  width: 100%;
  height: 200px; /* 固定高度 */
  object-fit: cover; /* 保持图片比例 */
  border-radius: 5px;
}

.course-title {
  font-size: 15px;
  margin-top: 5px;
  color: #333333;
  overflow: hidden;
  text-align: center; /* 文字居中 */
  margin: 2px 0px 0px;
}

.recommend-course .course-image {
  position: relative;
  height: 100%; /* 设置为100%，使其占满整个推荐课程区域 */
  position: relative; /* 使图片相对定位 */
  z-index: 1; /* 确保在视频之上 */
  display: block; /* 确保默认情况下显示 */
}
.recommend-label {
  position: absolute; /* 绝对定位 */
  top: 10px; /* 距离顶部10px */
  left: 10px; /* 距离左侧10px */
  background-color: rgba(255, 0, 0, 0.7); /* 背景颜色（可根据需要调整） */
  color: white; /* 字体颜色 */
  padding: 5px 10px; /* 内边距 */
  border-radius: 5px; /* 圆角 */
  font-size: 14px; /* 字体大小 */
  z-index: 1; /* 确保在其他元素上面 */
}

.course-video {
  position: absolute; /* 绝对定位 */
  top: 0; /* 顶部对齐 */
  left: 0; /* 左侧对齐 */
  width: 100%; /* 宽度占满 */
  height: 100%; /* 高度占满 */
  opacity: 0; /* 默认隐藏 */
  transition: opacity 0.5s ease; /* 渐变效果 */
  object-fit: cover; /* 保持比例，填充 */
  z-index: 0; /* 确保在底层 */
}


</style>
