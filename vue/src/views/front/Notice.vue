<template>
  <div class="main-content">
    <div style="width: 70%; margin: 30px auto">
      <div style="margin-bottom: 20px">
        <el-input placeholder="请输入通知标题" style="width: 200px" size="mini" v-model="title"></el-input>
        <el-button type="info" plain style="margin-left: 10px" size="mini" @click="load(1)">查询</el-button>
        <el-button type="warning" plain style="margin-left: 10px" size="mini" @click="reset">重置</el-button>
      </div>
      <div class="table">
        <el-table :data="noticeData" stripe>
          <el-table-column prop="id" label="序号" width="80" align="center" sortable></el-table-column>
          <el-table-column prop="title" label="通知标题" show-overflow-tooltip width="300">
            <template v-slot="scope">
              <a :href="'/front/noticeDetail?id=' + scope.row.id">{{ scope.row.title }}</a>
            </template>
          </el-table-column>
          <el-table-column prop="content" label="内容预览" show-overflow-tooltip>
            <template v-slot="scope">
              <span>{{ scope.row.content.length > 10 ? scope.row.content.slice(0, 10) + '...' : scope.row.content }}</span>
            </template>
          </el-table-column>
          <el-table-column prop="time" label="发布时间"></el-table-column>
          <el-table-column prop="user" label="发布人"></el-table-column>
          <el-table-column label="操作" width="180">
            <template v-slot="scope">
              <el-button type="success" size="mini" @click="confirmNotice(scope.row.id)">确认</el-button>
              <el-button type="primary" size="mini" @click="showDetail(scope.row)">显示详情</el-button>
            </template>
          </el-table-column>
        </el-table>

        <div class="pagination" style="margin-top: 20px">
          <el-pagination
              background
              @current-change="handleCurrentChange"
              :current-page="pageNum"
              :page-sizes="[5, 10, 20]"
              :page-size="pageSize"
              layout="total, prev, pager, next"
              :total="total">
          </el-pagination>
        </div>
      </div>
    </div>

    <!-- 详情弹窗 -->
    <el-dialog :visible.sync="dialogVisible" width="500px" title="通知详情">
      <div style="margin-bottom: 20px; text-align: center; font-weight: bold">{{ selectedNotice.title }}</div>
      <div style="display: flex; justify-content: space-between; margin-bottom: 20px;">
        <span>发布人：{{ selectedNotice.user }}</span>
        <span>{{ selectedNotice.time }}</span>
      </div>
      <div>{{ selectedNotice.content }}</div>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">关闭</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
export default {
  data() {
    return {
      noticeData: [],       // 通知数据
      pageNum: 1,           // 当前页码
      pageSize: 8,          // 每页显示数量
      total: 0,
      title: null,          // 查询通知标题
      dialogVisible: false, // 控制详情弹窗的显示
      selectedNotice: {},   // 存储选中的通知详情
    }
  },
  mounted() {
    this.load(1)
  },
  methods: {
    load(pageNum) {  // 分页查询通知
      if (pageNum) this.pageNum = pageNum
      this.$request.get('/notice/selectPage', {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          title: this.title,
        }
      }).then(res => {
        this.noticeData = res.data?.list
        this.total = res.data?.total
      })
    },
    reset() {
      this.title = null
      this.load(1)
    },
    handleCurrentChange(pageNum) {
      this.load(pageNum)
    },
    confirmNotice(id) {
      this.$request.get(`/notice/confirm/${id}`)
          .then(() => {
            this.$message.success("通知已确认")
            this.load(this.pageNum) // 刷新当前页面的数据
          })
          .catch(error => {
            this.$message.error("确认失败：" + error.message)
          })
    },
    showDetail(notice) {
      this.$request.get(`/notice/selectById/${notice.id}`)
          .then(res => {
            this.selectedNotice = res.data
            this.dialogVisible = true
          })
          .catch(error => {
            this.$message.error("加载详情失败：" + error.message)
          })
    },
  }
}
</script>
