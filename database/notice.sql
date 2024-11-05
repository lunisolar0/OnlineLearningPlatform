create table notice
(
    id            int auto_increment comment 'ID'
        primary key,
    title         varchar(255)  null comment '标题',
    content       varchar(255)  null comment '内容',
    time          varchar(255)  null comment '创建时间',
    user          varchar(255)  null comment '创建人',
    confirm_count int default 0 null
)
    comment '公告信息表' collate = utf8mb4_unicode_ci;

INSERT INTO study.notice (id, title, content, time, user, confirm_count) VALUES (1, '111', '11111', '2024-10-31', 'admin', 0);
INSERT INTO study.notice (id, title, content, time, user, confirm_count) VALUES (2, '我要玩原神', '我要玩原神', '2024-11-04', 'admin', 12);
