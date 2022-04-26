package com.fc.model;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class Log {

    private Integer logId;
    private Integer userId;
    private Integer commentId;
    private Integer replyId;
    private String otherUsername;
    private String operation;
    private Integer postId;
    private String displayedContent;

    private Date MsgTime;

}
