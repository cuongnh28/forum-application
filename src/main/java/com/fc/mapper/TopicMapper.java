package com.fc.mapper;

import com.fc.model.Topic;

import java.util.List;


public interface TopicMapper {

    List<Topic> listTopic();

    List<String> listImage();

    void insertTopic(Topic Topic);

    List<Topic> searchByTopicName(String name);

}
