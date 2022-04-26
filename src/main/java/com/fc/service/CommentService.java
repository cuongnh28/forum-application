package com.fc.service;

import com.fc.async.LogTask;
import com.fc.mapper.LogMapper;
import com.fc.mapper.PostMapper;
import com.fc.mapper.CommentMapper;
import com.fc.mapper.ReplyMapper;
import com.fc.mapper.UserMapper;
import com.fc.model.*;
import com.fc.util.MyConstant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.task.TaskExecutor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.temporal.TemporalAdjusters;
import java.util.Date;
import java.util.List;


@Service
public class CommentService {

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

    public void comment(int sessionUid, int postId, String content) {
        User user = new User(sessionUid);
        Post post = new Post(postId);
        Comment comment = new Comment();
        comment.setUser(user);
        comment.setPost(post);
        comment.setContent(content);
        comment.setCommentTime(new Date());
        commentMapper.insertComment(comment);
        postMapper.updateCommentCount(1, postId);
        postMapper.updateCommentTime(postId);
        taskExecutor.execute(new LogTask(logMapper, userMapper, postMapper, commentMapper, replyMapper, postId, comment.getCommentId(), null, sessionUid, MyConstant.OPERATION_COMMENT));
    }

    public List<Comment> listComment(int postId) {
        List<Comment> commentList = commentMapper.listComment(postId);
        for (Comment comment : commentList) {
            List<Reply> replyList = replyMapper.listReply(comment.getCommentId());
            comment.setReplyList(replyList);
        }
        return commentList;
    }

    public Comment getCommentById(int commentId) {
        Comment comment = commentMapper.getCommentById(commentId);
        return comment;
    }

    public boolean deleteComment(int commentId) {
        try {
            commentMapper.deleteComment(commentId);
            logMapper.deleteLogByComment(commentId);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public double getNoOfNewCommentsInMonth(LocalDate date) {
        LocalDate firstDayOfMonth = date.with(TemporalAdjusters.firstDayOfMonth());
        LocalDate lastDayOfMonth = date.with(TemporalAdjusters.lastDayOfMonth());
        return commentMapper.selectNoOfComment(java.sql.Date.valueOf(firstDayOfMonth), java.sql.Date.valueOf(lastDayOfMonth));
    }
}

