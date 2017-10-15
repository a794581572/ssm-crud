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
package com.example.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.crud.bean.Employee;
import com.example.crud.bean.EmployeeExample;
import com.example.crud.bean.EmployeeExample.Criteria;
import com.example.crud.dao.EmployeeMapper;
/**
 * @Type EmployeeService.java
 * @Desc 
 * @author limb
 * @date 2017年9月21日 下午10:20:00
 * @version 
 */
@Service //业务逻辑组件
public class EmployeeService {

    /**
     * 注入dao
     */
    @Autowired
    EmployeeMapper employeeMapper;
    
   /**
    * 返回所有员工信息
    * @return 员工信息
    */
    public List<Employee> getAll(){
        return employeeMapper.selectByExampleWithDept(null);
    }

    /**
     * 保存员工信息
     * @param employee 员工对象
     */
    public void saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    /**
     * <pre>
     *  校验姓名是否可用
     *  保存员工时检查员工姓名是否可用 
     *  是否重复 重复不可用
     * </pre>
     * @param empName
     * @return true:代表当前姓名可用  false:代表当前姓名不可用
     */
    public boolean checkUser(String empName) {
        //创建带条件的员工对象
        EmployeeExample example = new EmployeeExample();
        //添加条件 where empName = empName
        Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        //查询数据库里面是否有数据 
        long count = employeeMapper.countByExample(example);
        //返回 true没数据 false有数据
        return count == 0;
    }

    /**
     * 通过员工编号查询员工信息
     * @param id
     * @return
     */
    public Employee getEmp(Integer id) {
        return employeeMapper.selectByPrimaryKeyWithDept(id);
    }

    /**
     * 更新员工信息
     * @param employee 员工信息
     */
    public void updateEmp(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
        
    }

    /**
     * 单个删除员工
     * @param id 员工id
     */
    public void deleteEmp(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }

    /**
     * 批量删除员工
     * @param str_ids 员工集合
     */
    public void deleteBatch(List<Integer> ids) {
        //创建带条件的Employee
        EmployeeExample employeeExample = new EmployeeExample();
        //创建条件
        Criteria createCriteria = employeeExample.createCriteria();
        //添加条件: list集合里面的所有员工
        //delete from tbl_emp where emp_id in(1,2,3);
        createCriteria.andEmpIdIn(ids);
        employeeMapper.deleteByExample(employeeExample);
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