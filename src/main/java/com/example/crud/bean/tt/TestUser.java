package com.example.crud.bean.tt;

import java.util.Date;

public class TestUser {
    private Integer tId;

    private Byte tSex;

    private String tUsername;

    private String tPassword;

    private String tEmail;

    private Integer tQq;

    private Date tUpdateTime;

    private Date tCreateTime;

    public Integer gettId() {
        return tId;
    }

    public void settId(Integer tId) {
        this.tId = tId;
    }

    public Byte gettSex() {
        return tSex;
    }

    public void settSex(Byte tSex) {
        this.tSex = tSex;
    }

    public String gettUsername() {
        return tUsername;
    }

    public void settUsername(String tUsername) {
        this.tUsername = tUsername == null ? null : tUsername.trim();
    }

    public String gettPassword() {
        return tPassword;
    }

    public void settPassword(String tPassword) {
        this.tPassword = tPassword == null ? null : tPassword.trim();
    }

    public String gettEmail() {
        return tEmail;
    }

    public void settEmail(String tEmail) {
        this.tEmail = tEmail == null ? null : tEmail.trim();
    }

    public Integer gettQq() {
        return tQq;
    }

    public void settQq(Integer tQq) {
        this.tQq = tQq;
    }

    public Date gettUpdateTime() {
        return tUpdateTime;
    }

    public void settUpdateTime(Date tUpdateTime) {
        this.tUpdateTime = tUpdateTime;
    }

    public Date gettCreateTime() {
        return tCreateTime;
    }

    public void settCreateTime(Date tCreateTime) {
        this.tCreateTime = tCreateTime;
    }
}