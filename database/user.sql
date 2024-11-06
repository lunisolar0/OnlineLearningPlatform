create table user
(
    id       int auto_increment comment '主键ID'
        primary key,
    username varchar(255) null comment '用户名',
    password varchar(255) null comment '密码',
    name     varchar(255) null comment '姓名',
    avatar   varchar(255) null comment '头像',
    role     varchar(255) null comment '角色',
    phone    varchar(255) null comment '电话',
    email    varchar(255) null comment '邮箱'
)
    comment '用户信息表' engine = InnoDB
                         collate = utf8mb4_unicode_ci;

INSERT INTO study.user (id, username, password, name, avatar, role, phone, email) VALUES (1, 'ys', '2', '杨帅', 'http://localhost:9090/files/1730885975454-Image_1716136986400.jpg', 'USER', '19154080927', '1366036220@qq.com');
INSERT INTO study.user (id, username, password, name, avatar, role, phone, email) VALUES (2, 'wdc', '1', '大仓', 'http://localhost:9090/files/default_avatar.jpg', 'USER', '123456789', '234567@qq.com');
