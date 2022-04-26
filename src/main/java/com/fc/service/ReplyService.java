package com.fc.service;

import com.fc.async.LogTask;
import com.fc.mapper.CommentMapper;
import com.fc.mapper.LogMapper;
import com.fc.mapper.PostMapper;
import com.fc.mapper.ReplyMapper;
import com.fc.mapper.UserMapper;
import com.fc.model.Comment;
import com.fc.model.Reply;
import com.fc.model.User;
import com.fc.util.MyConstant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.task.TaskExecutor;
import org.springframework.stereotype.Service;

import java.util.Date;

@Service
public class ReplyService {

    @Autowired
    private ReplyMapper replyMapper;

    @Autowired
    private CommentMapper commentMapper;

    @Autowired
    private PostMapper postMapper;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private LogMapper logMapper;

    @Autowired
    private TaskExecutor taskExecutor;

    public Reply getReplyById(int replyId) {
        Reply reply = replyMapper.getReplyById(replyId);
        return reply;
    }

    public boolean deleteReply(int replyId) {
        try {
            replyMapper.deleteReply(replyId);
            logMapper.deleteLogByReply(replyId);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public void reply(int postId, int sessionUid, int commentId, String content) {
        User user = new User(sessionUid);
        Comment comment = new Comment(commentId);
        Reply reply = new Reply();
        reply.setUser(user);
        reply.setComment(comment);
        reply.setContent(content);
        reply.setReplyTime(new Date());
        replyMapper.insertReply(reply);
        taskExecutor.execute(new LogTask(logMapper, userMapper, postMapper, commentMapper, replyMapper, postId, commentId, reply.getReplyId(), sessionUid, MyConstant.OPERATION_REPLY));
    }
}
