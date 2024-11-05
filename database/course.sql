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
    comment '课程信息表' collate = utf8mb4_unicode_ci;

INSERT INTO study.course (id, img, name, content, type, video, file, recommend, time) VALUES (4, 'http://localhost:9090/files/1730736062469-1730360835130-a621e48ac745f739f8c5b71b515bf390_6511269016252122211.jpg', '1', '<p>1</p>', 'VIDEO', 'http://localhost:9090/files/1730735333059-intro.mp4', '1', '是', '2024-11-04');
INSERT INTO study.course (id, img, name, content, type, video, file, recommend, time) VALUES (5, 'http://localhost:9090/files/1730735389795-1730365365817-oVS4M1YAigdMdGj.thumb.400_0.png', '2', '<p>2</p>', 'VIDEO', 'http://localhost:9090/files/1730735734697-1730033351256-2.mp4', '2', '否', '2024-11-04');
INSERT INTO study.course (id, img, name, content, type, video, file, recommend, time) VALUES (6, 'http://localhost:9090/files/1730735751857-1730364199955-aLSjg4qVu0WDw9N.jpg', '3', '<p>3</p>', 'TEXT', null, '3', '否', '2024-11-04');
INSERT INTO study.course (id, img, name, content, type, video, file, recommend, time) VALUES (7, 'http://localhost:9090/files/1730735769285-1730364215766-d9d3cdab42b2252c2f3879b4ae2d9131_9118388853183177991.jpg', '4', '<p>4</p>', 'TEXT', null, '4', '否', '2024-11-04');
INSERT INTO study.course (id, img, name, content, type, video, file, recommend, time) VALUES (8, 'http://localhost:9090/files/1730735805982-1730360835130-a621e48ac745f739f8c5b71b515bf390_6511269016252122211.jpg', '5', '<p>5</p>', 'TEXT', null, '5', '否', '2024-11-04');
INSERT INTO study.course (id, img, name, content, type, video, file, recommend, time) VALUES (9, 'http://localhost:9090/files/1730735826128-1730735751857-1730364199955-aLSjg4qVu0WDw9N.jpg', '6', '<p>6</p>', 'TEXT', null, '6', '否', '2024-11-04');
INSERT INTO study.course (id, img, name, content, type, video, file, recommend, time) VALUES (10, 'http://localhost:9090/files/1730735852204-IMG_20220602_180327.jpg', '晶体光学', '<p><img src="http://localhost:9090/files/1730735870232-IMG_20220602_180259.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1730735879490-IMG_20220602_180327.jpg" style="max-width:100%;" contenteditable="false"/></p>', 'TEXT', null, '7', '否', '2024-11-04');
INSERT INTO study.course (id, img, name, content, type, video, file, recommend, time) VALUES (11, 'http://localhost:9090/files/1730735901206-1000轮.jpg', '数学建模', '<p><img src="http://localhost:9090/files/1730735920495-微信截图_20220824194758.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1730735925279-微信截图_20220824203238.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1730735931880-微信截图_20220905224245.png" style="max-width:100%;" contenteditable="false"/></p>', 'TEXT', null, '8', '否', '2024-11-04');
INSERT INTO study.course (id, img, name, content, type, video, file, recommend, time) VALUES (12, 'http://localhost:9090/files/1730735958861-sgj2hksl43bnyknjt0fy0egseaigxz1.jpg', '大吴疆土', '<p><span style="font-size: 14px;">😅</span><span style="font-size: 14px;">😅</span><span style="font-size: 14px;">😅</span></p><video ref="introVideo" class="course-video" muted="">               <source src="@/assets/videos/intro.mp4" type="video/mp4">               Your browser does not support the video tag.             </video>', 'TEXT', null, 'https://tse2-mm.cn.bing.net/th/id/OIP-C.FGOc4G7AaG8tzmn8LUpoRAHaEo?rs=1&pid=ImgDetMain', '否', '2024-11-05');
