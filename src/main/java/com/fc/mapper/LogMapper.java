package com.fc.mapper;

import com.fc.model.Log;

import java.util.List;

public interface LogMapper {

    void insertLog(Log log);

    List<Log> listLogByUserId(Integer userId);

    void deleteLogByPost(int postId);

    void deleteLogByReply(int replyId);

    void deleteLogByComment(int commentId);

}
