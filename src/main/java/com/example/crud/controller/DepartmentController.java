/*
 * Project: ssm-crud
 * 
 * File Created at 2017年9月23日
 * 
 * Copyright 2016 CMCC Corporation Limited.
 * All rights reserved.
 *
 * This software is the confidential and proprietary information of
 * ZYHY Company. ("Confidential Information").  You shall not
 * disclose such Confidential Information and shall use it only in
 * accordance with the terms of the license.
 */
package com.example.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.crud.bean.Department;
import com.example.crud.bean.Msg;
import com.example.crud.service.DepartmentService;

/**
 * @Type DepartmentController.java
 * @Desc 
 * <pre>
 *  网站跳转逻辑的控制
 *  部门控制器
 *  处理和部门有关的请求
 * </pre>
 * @author limb
 * @date 2017年9月23日 上午11:12:16
 * @version 
 */
@Controller
public class DepartmentController {
    
    @Autowired
    DepartmentService departmentService; 
    
    /**
     * 返回所有的部门信息
     * @return Msg对象信息
     */
    @RequestMapping("/depts")  //@RequestMapping("/depts")作用--前端的这个/depts页面发送请求,
    @ResponseBody()  //@ResponseBody注解作用--使用getDepts方法处理并给页面返回信息
    public Msg getDepts(){
        List<Department> depts = departmentService.getDepts();
        return Msg.success().add("depts", depts);
    }
    
//    public Msg saveEmp(){
//         
//    }
}


/**
 * Revision history
 * -------------------------------------------------------------------------
 * 
 * Date Author Note
 * -------------------------------------------------------------------------
 * 2017年9月23日 LMB creat
 */