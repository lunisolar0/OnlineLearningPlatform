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
    comment '公告信息表' engine = InnoDB
                         collate = utf8mb4_unicode_ci;

