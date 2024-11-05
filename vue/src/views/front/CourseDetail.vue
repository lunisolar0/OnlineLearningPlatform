<template>
  <div class="main-content">
    <div style="width: 70%; margin: 30px auto; min-height: 1000px">
      <div style="text-align: center">
        <el-button type="success">{{ courseData.type === 'VIDEO' ? '视频课' : '图文课' }}</el-button>
        <span style="font-size: 20px; font-weight: 550; color: #333333; margin-left: 20px">{{ courseData.name }}</span>
      </div>
      <div style="text-align: center; margin-top: 15px">
        <span style="color: #666666; margin-left: 50px">发布时间：{{ courseData.time }}</span>
      </div>
      <div>
        <div style="font-size: 18px; margin: 10px 0">课程资料</div>
        <div>
          <video v-if="courseData.type === 'VIDEO'" :src="courseData.video" controls style="width: 65%; height: 400px"></video>
          <div style="margin-top: 10px">资料链接：<a :href="courseData.file" target="_blank">{{ courseData.file }}</a></div>
        </div>
      </div>
      <div style="margin-top: 20px">
        <div style="font-size: 18px">课程介绍</div>
        <div style="margin-top: 10px" v-html="courseData.content" class="w-e-text w-e-text-container"></div>
      </div>

      <div style="margin-top: 50px; font-size: 18px">欢迎发表您宝贵的意见</div>
      <div style="margin-top: 20px">
        <el-input type="textarea" :rows="5" v-model="content"></el-input>
      </div>
      <div style="margin-top: 10px; text-align: right">
        <el-button type="primary" @click="submit(content, 0)">提交</el-button>
      </div>

      <div style="margin-top: 30px; margin-bottom: 500px">
        <el-row v-for="item in commentData" :key="item.id" style="margin-bottom: 30px">
          <el-col :span="4">
            <div style="display: flex; align-items: center;">
              <img :src="item.userAvatar" alt="" style="width: 50px; height: 50px; border-radius: 50%">
              <div style="flex: 1; margin-left: 10px">{{ item.userName }}</div>
            </div>
          </el-col>
          <el-col :span="20">
            <div style="height: 50px; line-height: 50px">
              <el-row>
                <el-col :span="18" style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">{{ item.content }}</el-col>
                <el-col :span="6" style="text-align: right">{{ item.time }}</el-col>
              </el-row>
            </div>
            <div v-if="item.children && item.children.length">
              <div v-for="child in item.children" :key="child.id" style="margin-bottom: 5px">
                <el-row>
                  <el-col :span="5">
                    <div style="display: flex; align-items: center;">
                      <img :src="child.userAvatar" alt="" style="width: 50px; height: 50px; border-radius: 50%">
                      <div style="flex: 1; margin-left: 10px">{{ child.userName }} 回复：</div>
                    </div>
                  </el-col>
                  <el-col :span="13" style="height: 50px; line-height: 50px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">{{ child.content }}</el-col>
                  <el-col :span="6" style="height: 50px; line-height: 50px; text-align: right">{{ child.time }}</el-col>
                </el-row>
              </div>
            </div>

            <div style="margin-top: 20px">
              <el-input style="width: 400px" v-model="item.tmp"></el-input>
              <el-button type="primary" style="margin-left: 5px" @click="submit(item.tmp, item.id)">回复</el-button>
            </div>
          </el-col>
        </el-row>
      </div>
    </div>
  </div>
</template>


<script>
export default {
  data() {
    let courseId = this.$route.query.id;
    return {
      user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
      courseId: courseId,
      courseData: {},
      content: null,
      commentData: [],
    };
  },
  mounted() {
    this.loadCourse();
    this.loadComment();
  },
  methods: {
    submit(content, parentId) {
      let data = {
        userId: this.user.id,
        courseId: this.courseId,
        content: content,
        parentId: parentId,
      };
      this.$request.post('/comment/add', data).then(res => {
        if (res.code === '200') {
          this.$message.success('评论成功');
          this.content = null;
          this.loadComment(); // Reload comments after submission
        } else {
          this.$message.error(res.msg);
        }
      });
    },
    loadComment() {
      this.$request.get('/comment/selectAll', {
        params: {
          courseId: this.courseId,
        }
      }).then(res => {
        console.log(res); // 输出完整的响应
        if (res.code === '200') {
          console.log('Comment Data:', res.data); // 查看返回的评论数据
          this.commentData = res.data; // Ensure this data includes children
        } else {
          this.$message.error(res.msg);
        }
      });
    },
    loadCourse() {
      this.$request.get('/course/selectById/' + this.courseId).then(res => {
        if (res.code === '200') {
          this.courseData = res.data;
        } else {
          this.$message.error(res.msg);
        }
      });
    }
  }
}
</script>
