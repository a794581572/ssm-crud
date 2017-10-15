/*
 * Project: ssm-crud
 * 
 * File Created at 2017年9月22日
 * 
 * Copyright 2016 CMCC Corporation Limited.
 * All rights reserved.
 *
 * This software is the confidential and proprietary information of
 * ZYHY Company. ("Confidential Information").  You shall not
 * disclose such Confidential Information and shall use it only in
 * accordance with the terms of the license.
 */
package com.example.crud.bean;

import java.util.HashMap;
import java.util.Map;

/**
 * @Type Msg.java
 * @Desc 返回json的通用类
 * @author limb
 * @date 2017年9月22日 上午11:14:04
 * @version 
 */
public class Msg {
    /**
     * 状态码
     */
    private int code; 
    /**
     * 提示信息
     */
    private String msg;
    /**
     * 用户要返回给浏览器的数据
     */
    private Map<String,Object> extend = new HashMap<String,Object>();
    
    /**
     * 请求成功 返回信息
     * @return
     */
    public static Msg success() {
        Msg result = new Msg();
        result.setCode(100);
        result.setMsg("处理成功");
        return result;
    }
    
    /**
     * 请求失败 返回信息
     * @return
     */
    public static Msg fail() {
        Msg result = new Msg();
        result.setCode(200);
        result.setMsg("处理失败");
        return result;
    }
    
    public Msg add(String key,Object value){
        this.getExtend().put(key, value);
        return this;
    }
    
    public int getCode() {
        return code;
    }
    public void setCode(int code) {
        this.code = code;
    }
    public String getMsg() {
        return msg;
    }
    public void setMsg(String msg) {
        this.msg = msg;
    }
    public Map<String, Object> getExtend() {
        return extend;
    }
    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }
    @Override
    public String toString() {
        return "Msg [code=" + code + ", msg=" + msg + ", extend=" + extend + "]";
    }
    public Msg() {
        super();
    }
    public Msg(int code, String msg, Map<String, Object> extend) {
        super();
        this.code = code;
        this.msg = msg;
        this.extend = extend;
    }
    
}


/**
 * Revision history
 * -------------------------------------------------------------------------
 * 
 * Date Author Note
 * -------------------------------------------------------------------------
 * 2017年9月22日 LMB creat
 */