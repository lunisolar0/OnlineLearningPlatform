package com.example.dto.login;

/**
 * @author : Shiranui
 * @date : $ $
 */

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 后台登录dto
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class LoginDto {
    private String username;     //账号
    private String password;    //密码
    private String role;        //角色
    private String captcha;        //验证码
}