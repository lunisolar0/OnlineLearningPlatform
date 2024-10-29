package com.example.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * @author : Shiranui
 * @date : $ $
 */
@AllArgsConstructor
@NoArgsConstructor
@Data
public class Course implements Serializable {
    private static final long serialVersionUID = 1L;

    /** ID */
    private Integer id;
    private String img;
    private String name;
    private String content;
    private String type;
    private String video;
    private String file;
    private String recommend;
    private String time;

}
