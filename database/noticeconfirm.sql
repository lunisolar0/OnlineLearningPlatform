create table noticeconfirm
(
    id        int auto_increment comment 'ID'
        primary key,
    notice_id int               not null comment '通知ID',
    user_id   int               not null comment '用户ID',
    confirm   tinyint default 0 not null comment '0未确认/1确认'
)
    comment '公告确认表' engine = InnoDB;

