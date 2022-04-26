package com.fc.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.io.*;
import java.util.Date;
import java.util.List;

@NoArgsConstructor
@Getter
@Setter
public class Post implements Serializable {
    private Integer postId;
    private String title;
    private String content;
    private Date publishTime;
    private Date commentTime;
    private Integer commentCount;
    private Integer likeCount;
    private Integer scanCount;
    private String isPublish;

    private User user;

    private Topic topic;

    private List<PostVisit> postVisitList;

    public Post(Integer postId) {
        this.postId = postId;
    }

}
