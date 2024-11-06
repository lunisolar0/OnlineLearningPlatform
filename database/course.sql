create table course
(
    id        int auto_increment comment '主键ID'
        primary key,
    img       varchar(255) null comment '课程封面',
    name      varchar(255) null comment '课程名称',
    content   longtext     null comment '课程介绍',
    type      varchar(255) null comment '课程类型',
    video     varchar(255) null comment '课程视频',
    file      varchar(255) null comment '资料链接',
    recommend varchar(255) null comment '是否推荐',
    time      varchar(255) null comment '发布时间'
)
    comment '课程信息表' engine = InnoDB
                         collate = utf8mb4_unicode_ci;

INSERT INTO study.course (id, img, name, content, type, video, file, recommend, time) VALUES (14, 'http://localhost:9090/files/1730888651395-Screenshot_2024_1106_182118.png', '张宇数学', '<p>课程介绍</p>', 'VIDEO', 'http://localhost:9090/files/1730887982901-zy.mp4', 'https://www.bilibili.com/video/BV195411y75U/?spm_id_from=333.788.recommend_more_video.-1&vd_source=266c2283414d4027f88cc59b1d47383a', '是', '2024-11-06');
INSERT INTO study.course (id, img, name, content, type, video, file, recommend, time) VALUES (15, 'http://localhost:9090/files/1730888642627-1730888516462.jpg', '王志超数学', '<p>王志超数学</p>', 'VIDEO', 'http://localhost:9090/files/1730888255329-wzc.mp4', 'https://www.bilibili.com/video/BV17q4y187gC/?spm_id_from=333.337.search-card.all.click&vd_source=266c2283414d4027f88cc59b1d47383a', '否', '2024-11-06');
INSERT INTO study.course (id, img, name, content, type, video, file, recommend, time) VALUES (16, 'http://localhost:9090/files/1730888630792-Screenshot_2024_1106_182247.png', '宋浩数学', '<p>111</p>', 'VIDEO', 'http://localhost:9090/files/1730888306443-songhao.mp4', 'https://www.bilibili.com/video/BV1h7pteyEww/?spm_id_from=333.337.search-card.all.click&vd_source=266c2283414d4027f88cc59b1d47383a', '否', '2024-11-06');
