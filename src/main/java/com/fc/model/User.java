package com.fc.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.io.*;
import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
@Entity
public class User implements Serializable {

    @Id
    private Integer userId;

    @Column
    private String email;
    @Column
    private String password;
    @Column
    private Integer actived;
    @Column
    private String activateCode;
    @Column
    private Date joinTime;

    @Column
    private String username;
    @Column
    private String description;
    @Column
    private String headUrl;
    @Column
    private String position;
    @Column
    private String school;
    @Column
    private String job;

    @Column
    private Integer postCount;
    @Column
    private Integer scanCount;
    @Column
    private Integer likeCount;
    @Column
    private Integer followCount;
    @Column
    private Integer followerCount;

    @Column
    private String isAdmin;

    private FullName fullName;

    @Column
    private String cover;

    public User(Integer userId) {
        this.userId = userId;
    }

    public boolean checkIsAdmin () {
        return isAdmin.equalsIgnoreCase("Y");
    }

}
