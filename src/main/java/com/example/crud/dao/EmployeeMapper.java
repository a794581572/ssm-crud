package com.example.crud.dao;

import com.example.crud.bean.Employee;
import com.example.crud.bean.EmployeeExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface EmployeeMapper {
    long countByExample(EmployeeExample example);

    int deleteByExample(EmployeeExample example);

    int deleteByPrimaryKey(Integer empId);

    int insert(Employee record);

    int insertSelective(Employee record);
    
    List<Employee> selectByExample(EmployeeExample example);

    Employee selectByPrimaryKey(Integer empId);
    
    /**
     * 通过员工资料查出员工信息 与部门表关联 并且查出他是哪个部门
     * @param example 员工资料
     * @return
     */
    List<Employee> selectByExampleWithDept(EmployeeExample example);
    
    /**
     * 通过员工编号查出员工信息 与部门表关联 并且查出他是哪个部门
     * @param empId 员工编号
     * @return
     */
    Employee selectByPrimaryKeyWithDept(Integer empId);

    int updateByExampleSelective(@Param("record") Employee record, @Param("example") EmployeeExample example);

    int updateByExample(@Param("record") Employee record, @Param("example") EmployeeExample example);

    int updateByPrimaryKeySelective(Employee record);

    int updateByPrimaryKey(Employee record);
}