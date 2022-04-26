package com.fc.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.io.*;
import java.util.List;

@NoArgsConstructor
@Getter
@Setter
public class Topic implements Serializable {

    private Integer topicId;
    private String name;
    private String content;
    private String image;
    private int totalViews = 0;

    public Topic(Integer topicId) {
        this.topicId = topicId;
    }

    public List<Post> listPost;

    @Override
    public String toString() {
        return "Topic{" +
                "topicId=" + topicId +
                ", name='" + name + '\'' +
                ", content='" + content + '\'' +
                ", image='" + image + '\'' +
                '}';
    }
}
