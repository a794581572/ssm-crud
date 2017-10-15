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
package com.example.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.crud.bean.Department;
import com.example.crud.dao.DepartmentMapper;

/**
 * @Type DepartmentService.java
 * @Desc 
 * @author limb
 * @date 2017年9月23日 上午11:15:15
 * @version 
 */
@Service
public class DepartmentService {
    @Autowired
    DepartmentMapper departmentMapper;
    
    /**
     * 返回所有部门信息
     * @return 返回部门list
     */
    public List<Department> getDepts(){
        //按照条件差询 selectByExample(where条件)
        return departmentMapper.selectByExample(null);
    }
}


/**
 * Revision history
 * -------------------------------------------------------------------------
 * 
 * Date Author Note
 * -------------------------------------------------------------------------
 * 2017年9月23日 LMB creat
 */