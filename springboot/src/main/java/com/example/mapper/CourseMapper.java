package com.example.mapper;

import com.example.entity.Course;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * @author : Shiranui
 * @date : $ $
 */
public interface CourseMapper {

    /**
     * 新增
     */
    int insert(Course course);

    /**
     * 删除
     */
    int deleteById(Integer id);

    /**
     * 修改
     */
    int updateById(Course course);

    /**
     * 根据ID查询
     */
    Course selectById(Integer id);

    /**
     * 查询所有
     */
    List<Course> selectAll(Course course);


    @Select("select * from course where recommend = '是'")
    Course getRecommend();

    @Select("select * from course where recommend = '否' order by id desc limit 8")
    List<Course> selectTop8();

}