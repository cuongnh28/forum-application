package com.fc.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
public class Reply {

    private Integer replyId;

    private String content;
    private Comment comment;
    private User user;
    private String isPublish = "N";

    private Date replyTime;

}
