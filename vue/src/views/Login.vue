<template>
  <div class="container">
    <div style="width: 400px; padding: 30px; background-color: white; border-radius: 5px;">
      <div style="text-align: center; font-size: 20px; margin-bottom: 20px; color: #333">欢迎使用</div>
      <el-form :model="form" :rules="rules" ref="formRef">


        <el-form-item prop="username">
          <el-input prefix-icon="el-icon-user" placeholder="请输入账号" v-model="form.username"></el-input>
        </el-form-item>
        <el-form-item prop="password">
          <el-input prefix-icon="el-icon-lock" placeholder="请输入密码" show-password v-model="form.password"></el-input>
        </el-form-item>
        <!-- 验证码输入框和验证码图片 -->
        <el-form-item prop="captcha">
          <div style="display: flex; align-items: center;">
            <el-input placeholder="请输入验证码" v-model="form.captcha" style="flex: 2;"></el-input>
            <img :src="captchaImage" @click="fetchCaptcha"
              style="flex: 1; height: 36px; cursor: pointer; margin-left: 10px;">
          </div>
        </el-form-item>
        <el-form-item>
          <el-select v-model="form.role" placeholder="请选择角色" style="width: 100%">
            <el-option label="管理员" value="ADMIN"></el-option>
            <el-option label="用户" value="USER"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button style="width: 100%; background-color: #333; border-color: #333; color: white" @click="login">登
            录</el-button>
        </el-form-item>
        <div style="display: flex; align-items: center">
          <div style="flex: 1"></div>
          <div style="flex: 1; text-align: right">
            还没有账号？请 <a href="/register">注册</a>
          </div>
        </div>
      </el-form>
    </div>
  </div>
</template>

<script>
export default {
  name: "Login",
  data() {
    return {
      form: {
        username: '',
        password: '',
        role: 'ADMIN',
        captcha: '', // 验证码字段
      },
      captchaImage: '', // 存储验证码图片
      rules: {
        username: [
          { required: true, message: '请输入账号', trigger: 'blur' },
        ],
        password: [
          { required: true, message: '请输入密码', trigger: 'blur' },
        ],
        captcha: [
          { required: true, message: '请输入验证码', trigger: 'blur' },
        ]
      }
    }
  },

  methods: {
    // 请求验证码
    fetchCaptcha() {
      this.$axios.get('/getCode', { responseType: 'arraybuffer', withCredentials: true })
        .then(response => {
          const blob = new Blob([response.data], { type: 'image/jpeg' });
          this.captchaImage = URL.createObjectURL(blob);
        })
        .catch(error => {
          console.error('获取验证码失败:', error);
        });
    },

    login() {
      this.$refs['formRef'].validate((valid) => {
        if (valid) {
          // 验证通过
          this.$axios.post('/login', this.form, {
            withCredentials: true
          }).then(res => {
            if (res.data.code === '200') {
              console.log(res);
              localStorage.setItem("xm-user", JSON.stringify(res.data.data)); // 存储用户数据
              if (res.data.data.role === 'ADMIN') {
                location.href = '/home';
              } else {
                location.href = '/front/home';
              }
              this.$message.success('登录成功');
            } else {
              console.log(res);
              console.log("为什么");
              this.$message.error(res.msg);
              this.fetchCaptcha(); // 登录失败时刷新验证码
            }
          });
        }
      });
    },

  }, created() {
    this.fetchCaptcha(); // 页面加载时获取验证码
  }

}
</script>

<style scoped>
.container {
  height: 100vh;
  overflow: hidden;
  background-image: url("@/assets/imgs/bg.jpg");
  background-size: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #666;
}

a {
  color: #2a60c9;
}
</style>
