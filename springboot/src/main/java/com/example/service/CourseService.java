package com.example.service;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.ObjectUtil;
import com.example.common.enums.RecommendEnum;
import com.example.common.enums.ResultCodeEnum;
import com.example.entity.Course;
import com.example.exception.CustomException;
import com.example.mapper.CourseMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

/**
 * @author : Shiranui
 * @date : $ $
 */
@Service
public class CourseService {

    @Resource
    private CourseMapper courseMapper;



    /**
     * 新增
     */
    public void add(Course course) {
        if (ObjectUtil.isNotEmpty(course.getRecommend()) && RecommendEnum.YES.status.equals(course.getRecommend())) {
            // 做一下校验
            Course recommend = courseMapper.getRecommend();
            if (ObjectUtil.isNotEmpty(recommend)) {
                throw new CustomException(ResultCodeEnum.RECOMMEND_ALREADY_ERROR);
            }
        }
        course.setTime(DateUtil.format(new Date(),"yyyy-MM-dd"));
        courseMapper.insert(course);
    }
    /**
     * 删除
     */
    public void deleteById(Integer id) {
        courseMapper.deleteById(id);
    }

    /**
     * 批量删除
     */
    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            courseMapper.deleteById(id);
        }
    }

    /**
     * 修改
     */
    public void updateById(Course course) {
        if (ObjectUtil.isNotEmpty(course.getRecommend()) && RecommendEnum.YES.status.equals(course.getRecommend())) {
            // 做一下校验
            Course recommend = courseMapper.getRecommend();
            if (ObjectUtil.isNotEmpty(recommend) && !recommend.getId().equals(course.getId())) {
                throw new CustomException(ResultCodeEnum.RECOMMEND_ALREADY_ERROR);
            }
        }
        courseMapper.updateById(course);
    }
    /**
     * 根据ID查询
     */
    public Course selectById(Integer id) {
        return courseMapper.selectById(id);
    }

    /**
     * 查询所有
     */
    public List<Course> selectAll(Course course) {
        return courseMapper.selectAll(course);
    }

    /**
     * 分页查询
     */
    public PageInfo<Course> selectPage(Course course, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Course> list = courseMapper.selectAll(course);
        return PageInfo.of(list);
    }

    /**
     * 获取推荐
     * @return
     */
    public Course getRecommend() {
        return courseMapper.getRecommend();
    }

    public List<Course> selectTop8() {
        return courseMapper.selectTop8();
    }





}
