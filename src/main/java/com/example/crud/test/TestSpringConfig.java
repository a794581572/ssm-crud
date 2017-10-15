/*
 * Project: ssm-crud
 * 
 * File Created at 2017年9月21日
 * 
 * Copyright 2016 CMCC Corporation Limited.
 * All rights reserved.
 *
 * This software is the confidential and proprietary information of
 * ZYHY Company. ("Confidential Information").  You shall not
 * disclose such Confidential Information and shall use it only in
 * accordance with the terms of the license.
 */
package com.example.crud.test;

import java.util.List;
import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.example.crud.bean.Department;
import com.example.crud.bean.Employee;
import com.example.crud.dao.DepartmentMapper;
import com.example.crud.dao.EmployeeMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * @Type TestSpringConfig.java
 * @Desc
 * @author limb
 * @date 2017年9月21日 上午9:42:38
 * @version
 */
//@JunitAndSpringTestAnnotation
//Junit里面的注解,使用SpringJUnit4ClassRunner.class这各类运行所以的单元测试
@RunWith(SpringJUnit4ClassRunner.class)
//spring-test里面的注解, 通过classpath加载spring配置文件,实现自动注入 直接@Resource 注入对象即可
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class TestSpringConfig {
    @Autowired
    private DepartmentMapper departmentMapper;
    @Autowired
    private EmployeeMapper employeeMapper;
    //注入org.mybatis.spring.SqlSessionTemplate的SqlSession,实现批量插入  这个要在applicationContext.xml文件里面配置批量插入
    @Autowired
    private SqlSession sqlSession;


    /**
     * 在测试中,我们手动的去拿对象,
     * 但是在实际开发中并不需要这样,
     * 我们可以自动注入的方式拿到对象
     *  @ContextConfiguration注解
     */
    @Deprecated
    @SuppressWarnings({"resource"})
    @Test
    public void testCRUD(){
        //1.创建springIOC容器                                                   applicationContext.xml
        ApplicationContext ioc = new ClassPathXmlApplicationContext("classpath:applicationContext.xml");
        //2.从容器中获取mapper对象
        DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);
        System.out.println(bean);
    }

    /**
     * 简单crud
     */
    @Test
    public void testCRUD1(){
        //1.增[部门]
//        departmentMapper.insertSelective(new Department(null, "部门6"));
//        departmentMapper.insertSelective(new Department(null, "部门7"));
//        System.out.println("添加成功");
        //删
//        departmentMapper.deleteByPrimaryKey(1);
//        System.out.println("删除成功");
        //改
        departmentMapper.updateByPrimaryKey(new Department(1,"修改部"));
        System.out.println("修改成功");
        //查
//        departmentMapper.selectByPrimaryKey(1);
//        DepartmentExample example = new DepartmentExample();
//        departmentMapper.selectByExample(example);
//        System.out.println(example);
    }

    /**
     * 批量插入
     */
    @Test
    public void testBatchInsert(){
        //创建Employee的sqlSessionFactory 实现批量插入Employee
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for(int i=0;i<9999;i++){
            String uid = UUID.randomUUID().toString().substring(0, 6);
            mapper.insertSelective(new Employee(null,uid+"员工","M",uid+"@qq.com",1));
        }
    }

    /**
     * 分页查询测试
     */
    public void testPageInfo(){
        System.out.println(1);
        PageHelper.startPage(1,8);
        List<Department> depts = departmentMapper.selectByExample(null);
        PageInfo page = new PageInfo(depts, 5);
        System.out.println(page.getNavigatepageNums());
        System.out.println(page.getLastPage());
        System.out.println(page.getTotal());
        System.out.println(page.getList());
        System.out.println(1);
    }
}


/**
 * Revision history
 * -------------------------------------------------------------------------
 *
 * Date Author Note
 * -------------------------------------------------------------------------
 * 2017年9月21日 LMB creat
 */