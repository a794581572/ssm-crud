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
package com.example.crud.annotation;

import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * @Type JunitTestAnnotation.java
 * @Desc 
 * <pre>
 *      定义单元测试的注解,自动注入对象
 * </pre>
 * 
 * @author limb
 * @date 2017年9月21日 下午1:13:36
 * @version 
 */
//Junit里面的注解,使用SpringJUnit4ClassRunner.class这各类运行所以的单元测试
@RunWith(SpringJUnit4ClassRunner.class)
//spring-test里面的注解, 通过classpath加载spring配置文件,实现自动注入 直接@Resource 注入对象即可
@ContextConfiguration(locations={"classpath:applicationContext.xml"})  
public @interface JunitAndSpringTestAnnotation {
    String name() default "";
}


/**
 * Revision history
 * -------------------------------------------------------------------------
 * 
 * Date Author Note
 * -------------------------------------------------------------------------
 * 2017年9月21日 LMB creat
 */