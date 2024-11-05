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
    comment '评论信息表' collate = utf8mb4_unicode_ci;

INSERT INTO study.comment (id, user_id, course_id, time, content, parent_id) VALUES (35, 1, 4, '2024-11-04 23:53:02', '好看', 0);
INSERT INTO study.comment (id, user_id, course_id, time, content, parent_id) VALUES (36, 1, 4, '2024-11-04 23:53:15', '豪堪', 35);
INSERT INTO study.comment (id, user_id, course_id, time, content, parent_id) VALUES (37, 1, 4, '2024-11-05 00:05:08', '非常好视频，使我旋转', 0);
INSERT INTO study.comment (id, user_id, course_id, time, content, parent_id) VALUES (38, 1, 12, '2024-11-05 00:05:47', '尼玛的一刀给哥们砍shi了', 0);
