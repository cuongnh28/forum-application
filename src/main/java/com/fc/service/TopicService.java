package com.fc.service;

import com.fc.mapper.LogMapper;
import com.fc.mapper.PostMapper;
import com.fc.mapper.CommentMapper;
import com.fc.mapper.TopicMapper;
import com.fc.mapper.UserMapper;
import com.fc.model.Topic;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class TopicService {


    @Autowired
    private TopicMapper topicMapper;

    @Autowired
    private CommentMapper commentMapper;

    @Autowired
    private PostMapper postMapper;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private LogMapper logMapper;

    public List<Topic> listTopic() {
        return topicMapper.listTopic();
    }

    public List<Topic> searchByTopicName(String name) {
        return topicMapper.searchByTopicName(name);
    }

    public List<String> listImage() {
        return topicMapper.listImage();
    }

    public void addTopic(String name, String content, String image) {
        Topic topic = new Topic();
        topic.setName(name);
        topic.setContent(content);
        topic.setImage(image);
        topicMapper.insertTopic(topic);
    }
}

