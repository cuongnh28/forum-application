package com.fc.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;
import java.util.List;

@NoArgsConstructor
@Getter
@Setter
public class Comment {

    private Integer commentId;
    private String content;
    private Post post;
    private User user;

    private Date commentTime;
    private String isPublish;

    private List<Reply> replyList;

    public Comment(Integer commentId) {
        this.commentId = commentId;
    }

    @Override
    public String toString() {
        return "Comment{" +
                "commentId=" + commentId +
                ", content='" + content + '\'' +
                ", post=" + post +
                ", user=" + user +
                ", commentTime='" + commentTime + '\'' +
                ", replyList=" + replyList +
                '}';
    }
}
