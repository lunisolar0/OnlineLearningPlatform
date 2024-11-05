create table admin
(
    id       int auto_increment comment 'ID'
        primary key,
    username varchar(255) null comment '用户名',
    password varchar(255) null comment '密码',
    name     varchar(255) null comment '姓名',
    avatar   varchar(255) null comment '头像',
    role     varchar(255) null comment '角色标识',
    phone    varchar(255) null comment '电话',
    email    varchar(255) null comment '邮箱'
)
    comment '管理员' engine = InnoDB
                     collate = utf8mb4_unicode_ci
                     row_format = DYNAMIC;

INSERT INTO study.admin (id, username, password, name, avatar, role, phone, email) VALUES (1, 'admin', 'admin', '小杨', 'http://localhost:9090/files/1730735120774-Image_1716136986400.jpg', 'ADMIN', '18033733892', '1366036220@qq.com');
