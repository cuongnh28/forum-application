package com.fc.mapper;

import com.fc.model.Reply;

import java.util.List;

public interface ReplyMapper {
    void deleteReply(int replyId);
    void insertReply(Reply reply);
    List<Reply> listReply(Integer commentId);
    Reply getReplyById (int replyId);
}
