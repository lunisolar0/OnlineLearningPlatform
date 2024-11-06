create table comment
(
    id        int auto_increment comment '主键ID'
        primary key,
    user_id   int          null comment '用户ID',
    course_id int          null comment '课程ID',
    time      varchar(255) null comment '评论时间',
    content   varchar(255) null comment '评论内容',
    parent_id int          null comment '父ID'
)
    comment '评论信息表' engine = InnoDB
                         collate = utf8mb4_unicode_ci;

INSERT INTO study.comment (id, user_id, course_id, time, content, parent_id) VALUES (43, 2, 14, '2024-11-06 18:28:56', '继续训练', 0);
INSERT INTO study.comment (id, user_id, course_id, time, content, parent_id) VALUES (44, 2, 14, '2024-11-06 18:29:02', '兄弟们', 0);
