package com.example.controller;

import cn.hutool.captcha.CaptchaUtil;
import cn.hutool.captcha.LineCaptcha;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.example.common.Result;
import com.example.common.enums.ResultCodeEnum;
import com.example.common.enums.RoleEnum;
import com.example.dto.login.LoginDto;
import com.example.entity.Account;
import com.example.service.AdminService;
import com.example.service.UserService;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * 基础前端接口
 */
@Slf4j
@RestController
public class WebController {

    @Resource
    private AdminService adminService;
    @Autowired
    private final static String SESSION_KEY = "captcha";    // 验证码session key
    @Resource
    private UserService userService;

    @GetMapping("/")
    public Result hello() {
        return Result.success("访问成功");
    }

    /**
     * 登录
     */
    @PostMapping("/login")
    public Result login(@RequestBody LoginDto loginDto, HttpSession session) {
        Account account = new Account();
        account.setUsername(loginDto.getUsername());
        account.setPassword(loginDto.getPassword());
        account.setRole(loginDto.getRole());
        // 检查输入参数是否完整
        if (ObjectUtil.isEmpty(account.getUsername()) || ObjectUtil.isEmpty(account.getPassword())
                || ObjectUtil.isEmpty(account.getRole()) || ObjectUtil.isEmpty(loginDto.getCaptcha())) {
            return Result.error(ResultCodeEnum.PARAM_LOST_ERROR);
        }

        // 校验验证码
        log.info("登录时的Session ID: {}", session.getId());
        String sessionCaptcha = (String) session.getAttribute("captcha"); // 从 session 中获取验证码
        log.info("验证码前台传入的值为：{}", loginDto.getCaptcha());
        log.info("验证码读取自Session中的值为：{}", session.getAttribute("captcha"));
        if (StrUtil.isEmpty(loginDto.getCaptcha()) || !loginDto.getCaptcha().equalsIgnoreCase(sessionCaptcha)) {
            return Result.error(ResultCodeEnum.CAPTCHA_ERROR); // 假设ResultCodeEnum有CAPTCHA_ERROR枚举
        }
        // 根据用户角色调用不同的登录方法
        if (RoleEnum.ADMIN.name().equals(account.getRole())) {
            // 管理员登录逻辑
            account = adminService.login(account);
            if (account == null) {
                return Result.error(ResultCodeEnum.USER_ACCOUNT_ERROR);
            }
        } else if (RoleEnum.USER.name().equals(account.getRole())) {
            // 普通用户登录逻辑
            account = userService.login(account);
            if (account == null) {
                return Result.error(ResultCodeEnum.USER_ACCOUNT_ERROR);
            }
        } else {
            return Result.error(ResultCodeEnum.USER_ACCOUNT_ERROR);
        }

        return Result.success(account);
    }


    @RequestMapping("/getCode")
    public void getCode(HttpServletResponse response, HttpSession session) {
        LineCaptcha lineCaptcha = CaptchaUtil.createLineCaptcha(116, 36, 4, 10);
        String code = lineCaptcha.getCode();
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);
        response.setContentType("image/jpeg");
        session.setAttribute("captcha", code);  // 将验证码存入session

        log.info("============================");
        log.info("获取验证码时的Session ID: {}", session.getId());
        log.info("验证码存入在Session中的值为：{}", session.getAttribute("captcha"));
        try {
            ServletOutputStream outputStream = response.getOutputStream();
            lineCaptcha.write(outputStream);
            outputStream.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * 注册
     */
    @PostMapping("/register")
    public Result register(@RequestBody Account account, HttpSession session, @RequestParam String captcha) {
        if (StrUtil.isBlank(account.getUsername()) || StrUtil.isBlank(account.getPassword())
                || ObjectUtil.isEmpty(account.getRole())) {
            return Result.error(ResultCodeEnum.PARAM_LOST_ERROR);
        }

        // 校验验证码
        String sessionCaptcha = (String) session.getAttribute(SESSION_KEY);
        if (StrUtil.isEmpty(captcha) || !captcha.equalsIgnoreCase(sessionCaptcha)) {
            return Result.error(ResultCodeEnum.CAPTCHA_ERROR);
        }

        if (RoleEnum.USER.name().equals(account.getRole())) {
            userService.register(account);
        }
        return Result.success();
    }

    /**
     * 修改密码
     */
    @PutMapping("/updatePassword")
    public Result updatePassword(@RequestBody Account account) {
        if (StrUtil.isBlank(account.getUsername()) || StrUtil.isBlank(account.getPassword())
                || ObjectUtil.isEmpty(account.getNewPassword())) {
            return Result.error(ResultCodeEnum.PARAM_LOST_ERROR);
        }
        if (RoleEnum.ADMIN.name().equals(account.getRole())) {
            adminService.updatePassword(account);
        }
        if (RoleEnum.USER.name().equals(account.getRole())) {
            userService.updatePassword(account);
        }
        return Result.success();
    }
}
