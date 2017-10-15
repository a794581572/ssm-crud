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

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.example.crud.bean.Employee;
import com.github.pagehelper.PageInfo;

/**
 * @Type TestMvc.java
 * @Desc mvc的单元测试
 * <pre>
 *  使用Spring测试模块提供的测试请求功能，测试curd请求的正确性
 *  Spring4测试的时候，需要servlet3.0的支持 如果是Servlet2.x 请换3.x
 *  虚拟mvc请求，获取到处理结果。
 * </pre>
 * @author limb
 * @date 2017年9月21日 下午11:18:42
 * @version 
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration //webapp容器注解
@ContextConfiguration(locations = { "classpath:applicationContext.xml",
        "file:src/main/webapp/WEB-INF/dispatcherServlet-servlet.xml" })
public class TestMvc {
    //传人Springmvc的ioc
    @Autowired
    WebApplicationContext context;
    //虚拟mvc请求，获取到处理结果。
    MockMvc mockMvc;

    /**
     * 每次执行测试都需要调用的东西 写到before里面 自动初始化
     */
    @Before
    public void initMockMvc() {
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void testPage() throws Exception {
        //模拟mvc的get("/emps")方法  拿到返回值     参数 这里传的是 pn当前页码
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "2"))
                .andReturn();
        //请求成功以后,请求域中会有PageInfo,我们可以取出PageInfo进行验证
        MockHttpServletRequest mockHttpServletRequest = result.getRequest();
        PageInfo pi = (PageInfo) mockHttpServletRequest.getAttribute("pageInfo");//pageInfo
        System.out.println(pi);
        System.out.println("当前页码:" + pi.getPageNum());  //--4
        System.out.println("首页:" + pi.getFirstPage());  //--1
        System.out.println("首页:" + pi.isHasPreviousPage());  //--是否有上一页
        System.out.println("首页:" + pi.isHasNextPage());  //--是否有下一页
        System.out.println("末页:" + pi.getLastPage());  //--5 末页不是总页数 而是连续n页的 n
      /*  System.out.println("总记录数:" + pi.getTotal()); //--10019
        System.out.println("总页码:" + pi.getPages()); //--1002
        System.out.println("在页面需要连续显示的页码:"); //--2 3 4 5 6  当前页在中间,前2和后2除外
        //        在页面需要连续显示的页码
        int[] nums = pi.getNavigatepageNums();
        for (int i : nums) {
            System.out.print(i + " ");
        }
        System.out.println();
        //当前页显示的信息集合(条数就是自己设置的条数了,除非最后一页)
        List<Employee> emps = pi.getList();
        for (Employee emp : emps) {
            System.out.println("员工信息: " + emp);
        }*/
    }
}
///ssm-crud/src/main/webapp/WEB-INF/dispatcherServlet-servlet.xml
///ssm-crud/src/main/resources/applicationContext.xml   
//从上面可以得出: classpath指得是resource目录下面   file指得是工程下面

//file:加载非编译类的文件系统，即：作为 URL 从文件系统中加载。
//classpath:加载编译的class文件系统，即：从classpath中加载。

/**
 * Revision history
 * -------------------------------------------------------------------------
 * 
 * Date Author Note
 * -------------------------------------------------------------------------
 * 2017年9月21日 LMB creat
 */
