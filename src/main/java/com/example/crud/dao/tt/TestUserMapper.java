package com.example.crud.dao.tt;

import com.example.crud.bean.tt.TestUser;
import com.example.crud.bean.tt.TestUserExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TestUserMapper {
    long countByExample(TestUserExample example);

    int deleteByExample(TestUserExample example);

    int deleteByPrimaryKey(Integer tId);

    int insert(TestUser record);

    int insertSelective(TestUser record);

    List<TestUser> selectByExample(TestUserExample example);

    TestUser selectByPrimaryKey(Integer tId);

    int updateByExampleSelective(@Param("record") TestUser record, @Param("example") TestUserExample example);

    int updateByExample(@Param("record") TestUser record, @Param("example") TestUserExample example);

    int updateByPrimaryKeySelective(TestUser record);

    int updateByPrimaryKey(TestUser record);
}