package com.example.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.List;

/**
 * @author : Shiranui
 * @date : $ $
 */
@AllArgsConstructor
@NoArgsConstructor
@Data
public class Comment implements Serializable {
    private static final long serialVersionUID = 1L;

    /** ID */
    private Integer id;
    private Integer userId;
    private Integer courseId;
    private String time;
    private String content;
    private Integer parentId;

    private String userName;
    private String userAvatar;
    private String departmentName;
    private List<Comment> children;
}
